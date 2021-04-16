import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MethodList extends StatefulWidget {
  final List<String> methods;
  MethodList({required this.methods});
  @override
  MethodListState createState() => MethodListState();
}

class MethodListState extends State<MethodList> {
  bool isShow = true;
  void changeShow() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Methods", style: TextStyle(fontSize: 20)),
              SizedBox(
                width: 227,
              ),
              IconButton(
                  onPressed: changeShow,
                  icon: Icon(isShow
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down))
            ],
          ),
          if (isShow)
            ...List.generate(widget.methods.length,
                (index) => MethodItem(index + 1, widget.methods[index])),
        ],
      )
    ]);
  }
}

class MethodItem extends StatelessWidget {
  final String text;
  final int number;
  MethodItem(this.number, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        margin: EdgeInsets.only(bottom: 2),
        child: Row(children: [
          Flexible(
              child: Text(
            '$number. $text',
            softWrap: true,
          ))
        ]));
  }
}
