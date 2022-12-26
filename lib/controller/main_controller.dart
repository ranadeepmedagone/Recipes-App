import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/model/category.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/view/single_screen.dart';

import '../api/dio_helper.dart';
import '../view/single_item_screen.dart';

class CategoryController extends GetxController {
  List<Category> listOfCategories = [];
  List<Category> searchedUsers = [];
  final FocusNode textFocusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  List<Meals> listOfItems = [];
  // List<MealSingle> favFood = [];
  int totalPrice = 0;
  int quantity = 0;

  List<String> cartFood = [];
  bool onClick = false;

  void toggle() {
    onClick = !onClick;
    update();
  }

  // final singleController = Get.find<CategoryController>();
  bool isLoading = true;
  bool isScreenLoading = true;

  // List<MealSingle> singleRes = [];
  // DioHelpers? api;
  // DioHelpers api = Get.find<DioHelpers>();
  DioHelpers api = Get.put(DioHelpers());

  @override
  void onInit() async {
    isLoading = true;
    update();
    getAllCategories();
    // isLoading = true;
    // update();

    super.onInit();
  }

  void increment() {
    quantity++;
    update();
  }

  void decrement() {
    quantity = quantity-- < 1 ? 0 : quantity--;
    update();
  }

  String calculatePricePerEachItem() {
    int price = 50;
    totalPrice = quantity * price;
    update();
    return price.toString();
  }

  quaryUsers(String value) {
    searchedUsers = listOfCategories
        .where((element) =>
            element.strCategory.toLowerCase().contains(value.toLowerCase()))
        .toList();
    if (textEditingController.text.isEmpty && searchedUsers.isEmpty) {
      print("No Category Found!");
    }
    update();
  }
  // isFavorite(MealSingle mealSingle) {
  //   mealSingle.isFav = !mealSingle.isFav;
  //   if (mealSingle.isFav) {
  //     favFood.add(mealSingle);
  //   } else {
  //     favFood.removeWhere((element) => element == mealSingle);
  //   }
  //   update();
  // }

  goToSingleScreen(String id) {
    update();
    Get.to(SingleItemScreen(), arguments: {
      "idMeal": id,
    });
    update();
  }

  Future getAllCategories() async {
    final res = await api.categoriesGetAll();

    if (res == null) {
      await Get.dialog(const Dialog(
        child: Text(""),
      ));
      Get.back();
      return false;
    }
    for (var i in res.data["categories"]) {
      listOfCategories.add(Category.fromJson(i));
    }
    isLoading = !isLoading;
    update();
    return true;
  }

  Future getAllItems(String strCategory) async {
    isScreenLoading = true;
    final res = await api.categoryGetByName(strCategory: strCategory);
    print(res);
    if (res == null) {
      await Get.dialog(const Dialog(
        child: Text("error"),
      ));
      Get.back();
      return false;
    }
    for (var i in res.data["meals"]) {
      listOfItems.add(Meals.fromJson(i));
    }
    isScreenLoading = false;
    update();
    Get.to(SingleScreen());

    return true;
  }
}
