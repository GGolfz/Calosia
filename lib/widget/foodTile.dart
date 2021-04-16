import 'package:flutter/material.dart';

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
