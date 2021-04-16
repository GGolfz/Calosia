import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IngredientsList extends StatefulWidget {
  final List<String> ingredients;
  IngredientsList({required this.ingredients});
  @override
  IngredientsListState createState() => IngredientsListState();
}

class IngredientsListState extends State<IngredientsList> {
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
              Text("Ingredients", style: TextStyle(fontSize: 20)),
              SizedBox(
                width: 204,
              ),
              IconButton(
                  onPressed: changeShow,
                  icon: Icon(isShow
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down))
            ],
          ),
          if (isShow)
            ...widget.ingredients
                .map((element) => IngredientItem(element))
                .toList(),
        ],
      )
    ]);
  }
}

class IngredientItem extends StatelessWidget {
  final String text;
  IngredientItem(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        margin: EdgeInsets.only(bottom: 2),
        child: Row(children: [
          Flexible(
              child: Text(
            '${String.fromCharCode(0x2022)} $text',
            softWrap: true,
          ))
        ]));
  }
}
