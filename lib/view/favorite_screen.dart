import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/api/services.dart';
import 'package:meals/controller/single_controller.dart';
import 'package:meals/model/single_meal.dart';
import 'package:meals/view/single_item_screen.dart';
import 'package:meals/widget/item_card.dart';

import '../api/dio_helper.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final controller = Get.put(SingleController());

  List<String> allFav = [];
  var d = DBServices();

  late bool isLoading;

  var api = Get.find<DioHelpers>();

  Future<void> chnage() async {
    controller.isFav = !controller.isFav;
    controller.update();
  }

  Future<void> getAllFavList() async {
    setState(() {
      isLoading = true;
    });
    allFav = await d.getAllFovoriteMeal();
    setState(() {
      isLoading = false;
    });
  }

  Future<MealSingle?> getIndivisualMeal(String id) async {
    return await api.itemGetById(idMeal: id);
  }

  @override
  void initState() {
    getAllFavList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var mealId = Get.arguments["idMeal"];
    return GetBuilder<SingleController>(initState: (state) async {
      // await controller.getIsMealFavorite(mealId);
    }, builder: (context) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
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
            title: const Text("Favorite Items"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ...allFav.map((e) => FutureBuilder(
                    future: getIndivisualMeal(e),
                    builder: (context, AsyncSnapshot snap) {
                      if (snap.hasData) {
                        if (snap.data == null) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: const Text(" Error fetching this item"),
                          );
                        }

                        var item = snap.data as MealSingle;
                        // return card here.
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ItemCard(
                              strMeal: item.strMeal ?? "",
                              strMealThumb: item.strMealThumb ?? "",
                              icon: IconButton(
                                icon: !controller.isFav
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.favorite_border_outlined),
                                onPressed: () {
                                  // chnage();
                                  // controller.setIsMealFavorited(
                                  //     mealId, controller.isFav);
                                },
                              ),
                              onTap: () {
                                Get.to(SingleItemScreen, arguments: {
                                  "idMeal": e,
                                });
                              }),
                        );
                      }

                      if (snap.hasError) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: const Text(" Error fetching this item"),
                        );
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: const LinearProgressIndicator(),
                      );
                    }))
              ],
            ),
          ));
    });
  }
}
