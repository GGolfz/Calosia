import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomBottomSheet extends StatelessWidget {
  final imagePicker;
  final predict;
  CustomBottomSheet({required this.imagePicker, required this.predict});

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
                    maxWidth: 600.0,
                    maxHeight: 500.0,
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
