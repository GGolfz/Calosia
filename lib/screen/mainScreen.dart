import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../widget/customBottomSheet.dart';
import '../widget/foodTile.dart';
import '../widget/searchField.dart';
import '../provider/foodProvider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    fetchFood();
    super.initState();
  }

  void fetchFood() async {
    await Provider.of<FoodProvider>(context, listen: false).fetchFood();
  }

  final _text = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();

  final List<String> foodList = <String>[
    'Apple',
    'Apple pie',
    'Bacon',
    'Banana',
    'Beef burger',
    'Bingsu',
    'Carbonara',
    'Fried rice',
    'Pizza'
  ];

  void predict(PickedFile image, BuildContext context) async {
    final bytes = await image.readAsBytes();
    String base64 = base64Encode(bytes);
    try {
      final response =
          await Dio().post('https://foodai.org/v1/classify', data: {
        'image_url': 'data:image/jpeg;base64,' + base64,
        'num_tag': 1,
        'uid': 'smu_admin'
      });
      String result = response.data['food_results'][0][0] as String;
      result = result.split('(')[0].trim();
      print(result);
      final foundFood = await Provider.of<FoodProvider>(context, listen: false)
          .hasFood(result);
      if (foundFood) {
        Navigator.of(context).pushNamed('/food', arguments: {'detail': result});
      } else {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Sorry for inconvenience'),
                  content:
                      Text("We don't have the information of this food now."),
                ));
      }
    } on DioError catch (error) {
      print(error.response!.data);
    }
  }

  void buildBottomModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        builder: (ctx) =>
            CustomBottomSheet(imagePicker: imagePicker, predict: predict));
  }

  void onSearch(String searchVal, BuildContext context) {
    Provider.of<FoodProvider>(context, listen: false).searchFood(searchVal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/app_logo.png'),
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Container(
          color: Color(0xFFFFF9F6),
          child: Column(children: [
            SizedBox(
              height: 16,
            ),
            SearchField(text: _text, onSearch: (val) => onSearch(val, context)),
            SizedBox(
              height: 8,
            ),
            Container(
                height: 600,
                child: Consumer<FoodProvider>(
                    builder: (ctx, foods, _) => ListView.separated(
                        itemBuilder: (ctx, index) {
                          Food food = foods.foodList[index];
                          return FoodTile(
                              name: food.name,
                              imgURL: food.imgURL,
                              calories: food.calories);
                        },
                        separatorBuilder: (ctx, index) => Divider(),
                        itemCount: foods.foodList.length)))
          ]),
          height: MediaQuery.of(context).size.height * 0.8,
        ),
        Container(
          color: Color(0xFFFFFFFF),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          buildBottomModalSheet(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
