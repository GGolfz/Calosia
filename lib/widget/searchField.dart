import 'package:flutter/material.dart';

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
              FocusScope.of(context).unfocus();
            },
            textAlignVertical: TextAlignVertical.center,
            controller: text,
            autofocus: false,
            style: TextStyle(fontSize: 16.0, color: Color(0xFF8B8B8B)),
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
