import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/view/favorite_screen.dart';
import 'package:meals/widget/body_loader.dart';
import 'package:meals/widget/item_card.dart';

import '../controller/main_controller.dart';

class SingleScreen extends StatelessWidget {
  SingleScreen({super.key});
  final categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // title: const Text(
            //   "Chicken",
            //   style:
            //       TextStyle(fontWeight: FontWeight.bold, color: Colors.black38),
            // ),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black38),
                onPressed: () => Get.back(),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              PopupMenuButton(
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 15, 0),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.black38,
                  ),
                ),
                onSelected: (ind) {
                  if (ind == 1) {
                    Get.to(FavoriteScreen());
                  }
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      child: Text("Favorites"),
                      value: 1,
                    ),
                  ];
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: categoryController.isScreenLoading
                ? const BodyLoader()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ...categoryController.listOfItems.map(
                          (element) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ItemCard(
                                onTap: () {
                                  categoryController
                                      .goToSingleScreen(element.idMeal);
                                  // categoryController.getSingleById(element.idMeal);
                                },
                                strMeal: element.strMeal,
                                strMealThumb: element.strMealThumb,
                                icon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.arrow_right))),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
