import 'package:flutter/foundation.dart';

class Food {
  final String name;
  final String imgURL;
  final double calories;
  final List<String> ingredients;
  final List<String> methods;
  Food(
      {required this.name,
      required this.imgURL,
      required this.calories,
      required this.ingredients,
      required this.methods});
      
}
