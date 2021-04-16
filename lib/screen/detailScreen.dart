import 'package:calosia/widget/methodList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/ingredientList.dart';
import '../provider/foodProvider.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    Provider.of<FoodProvider>(context, listen: false)
        .getFoodByName(args["detail"].toString());
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/app_logo.png'),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Consumer<FoodProvider>(
          builder: (ctx, foods, _) {
            final food = foods.selectedFood;
            return Container(
                padding: EdgeInsets.all(16),
                color: Color(0xFFFFF9F6),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.network(
                              food.imgURL,
                              fit: BoxFit.cover,
                            ),
                          ))
                    ]),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          food.name,
                          style: TextStyle(fontSize: 22),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${food.calories} kcals',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                        height: 400,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              IngredientsList(ingredients: food.ingredients),
                              MethodList(methods: food.methods)
                            ],
                          ),
                        ))
                  ],
                ));
          },
        ));
  }
}
