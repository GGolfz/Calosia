import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatelessWidget {
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
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    onEditingComplete: () {
                      Navigator.of(context).pushNamed('/food',
                          arguments: {'detail': _text.text});
                      _text.text = '';
                      FocusScope.of(context).unfocus();
                    },
                    controller: _text,
                    autofocus: false,
                    style: TextStyle(fontSize: 20.0, color: Color(0xFF8B8B8B)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF8B8B8B),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
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
                )),
            Container(
                height: 600,
                child: ListView.separated(
                    itemBuilder: (ctx, index) => ListTile(
                          leading: Container(
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/e/e8/Tom_yam_kung_maenam.jpg',
                              fit: BoxFit.cover,
                            ),
                            width: 50,
                            clipBehavior: Clip.hardEdge,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                          ),
                          title: Text('Food $index'),
                          subtitle: Text('300 kcals'),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            print(index);
                            Navigator.of(context).pushNamed('/food',
                                arguments: {'detail': '$index'});
                          },
                        ),
                    separatorBuilder: (ctx, index) => Divider(),
                    itemCount: 10))
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
          showModalBottomSheet(
              context: context,
              barrierColor: Colors.transparent,
              builder: (ctx) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    final _pickedImage =
                                        await imagePicker.getImage(
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    final _pickedImage =
                                        await imagePicker.getImage(
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
                  ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
