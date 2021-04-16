import 'package:calosia/provider/foodProvider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _text = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();
    Provider.of<FoodProvider>(context, listen: false).fetchFood();
  }

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
      if (foodList.indexOf(result) != -1) {
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
            BottomSheet(imagePicker: imagePicker, predict: predict));
  }

  void onSearch(String searchVal) {
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
            SearchField(text: _text, onSearch: onSearch),
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

class SearchField extends StatelessWidget {
  final text;
  final onSearch;
  SearchField({required this.text, required this.onSearch});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          child: TextField(
            onEditingComplete: () {
              onSearch(text.text);
              text.text = '';
              FocusScope.of(context).unfocus();
            },
            controller: text,
            autofocus: false,
            style: TextStyle(fontSize: 20.0, color: Color(0xFF8B8B8B)),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xFF8B8B8B),
              ),
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
          ),
        ));
  }
}

class FoodTile extends StatelessWidget {
  final String name;
  final String imgURL;
  final double calories;
  FoodTile({required this.name, required this.imgURL, required this.calories});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        child: Image.network(
          imgURL,
          fit: BoxFit.cover,
        ),
        width: 50,
        clipBehavior: Clip.hardEdge,
        height: 50,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25))),
      ),
      title: Text(name),
      subtitle: Text('$calories kcals'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).pushNamed('/food', arguments: {'detail': name});
      },
    );
  }
}

class BottomSheet extends StatelessWidget {
  final imagePicker;
  final predict;
  BottomSheet({required this.imagePicker, required this.predict});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            ElevatedButton.icon(
                onPressed: () async {
                  final _pickedImage = await imagePicker.getImage(
                    source: ImageSource.camera,
                    imageQuality: 70,
                    maxWidth: 600,
                    maxHeight: 500,
                  );
                  if (_pickedImage != null) {
                    predict(_pickedImage, context);
                  }
                },
                icon: Icon(Icons.camera_alt),
                label: Text('Take a photo'))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            ElevatedButton.icon(
                onPressed: () async {
                  final _pickedImage = await imagePicker.getImage(
                    source: ImageSource.gallery,
                    imageQuality: 70,
                    maxWidth: 600,
                    maxHeight: 500,
                  );
                  if (_pickedImage != null) {
                    predict(_pickedImage, context);
                  }
                },
                icon: Icon(Icons.photo_library),
                label: Text('Select from library'))
          ])
        ],
      ),
      height: 150,
    );
  }
}
