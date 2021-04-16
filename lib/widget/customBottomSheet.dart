import 'package:calosia/widget/sourceButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomBottomSheet extends StatelessWidget {
  final imagePicker;
  final predict;
  CustomBottomSheet({required this.imagePicker, required this.predict});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color: Colors.white),
      child: Column(
        children: [
          SourceButton(
              text: "Choose from library",
              textColor: Color(0x82000000),
              color: Color(0xFFF4F4F4),
              onTap: () async {
                final _pickedImage = await imagePicker.getImage(
                  source: ImageSource.gallery,
                  imageQuality: 70,
                  maxWidth: 600.0,
                  maxHeight: 500.0,
                );
                if (_pickedImage != null) {
                  predict(_pickedImage, context);
                }
              }),
          SizedBox(
            height: 12,
          ),
          SourceButton(
              text: "Take a new picture",
              textColor: Color(0xFFFFFFFF),
              color: Color(0xFFFF9B54),
              onTap: () async {
                final _pickedImage = await imagePicker.getImage(
                  source: ImageSource.camera,
                  imageQuality: 70,
                  maxWidth: 600.0,
                  maxHeight: 500.0,
                );
                if (_pickedImage != null) {
                  predict(_pickedImage, context);
                }
              }),
        ],
      ),
      height: 150,
    );
  }
}
