import 'package:flutter/foundation.dart';
import '../data/foods.dart';

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
  static Food get init {
    return Food(
        name: '', imgURL: '', calories: 0, ingredients: [], methods: []);
  }
}

class FoodProvider with ChangeNotifier {
  List<Food> foodList;
  Food selectedFood;
  FoodProvider({required this.foodList, required this.selectedFood});

  Future<void> fetchFood() async {
    this.foodList = foods;
    notifyListeners();
  }

  Future<void> searchFood(String search) async {
    final searchList =
        foods.where((element) => element.name.indexOf(search) != -1).toList();
    if (searchList.length == 0) {
      this.foodList = foods;
    } else {
      this.foodList = searchList;
    }
    notifyListeners();
  }

  Future<bool> hasFood(String name) async {
    return foodList.any((element) => element.name == name);
  }

  Future<void> getFoodByName(String name) async {
    this.selectedFood = foodList.firstWhere((element) => element.name == name);
    notifyListeners();
  }
}
