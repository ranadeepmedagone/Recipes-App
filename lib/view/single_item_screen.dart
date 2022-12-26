// ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/controller/single_controller.dart';
import 'package:meals/model/single_meal.dart';
import 'package:meals/widget/body_loader.dart';
import 'package:meals/widget/downloading_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/share_button.dart';

class SingleItemScreen extends StatelessWidget {
  SingleItemScreen({super.key});
  final controller = Get.put(SingleController());
  Widget appBarShareButton(MealSingle? event, controller) => AppBarShareButton(
        initialLoading: controller.initialLoading.value,
        padding: const EdgeInsets.only(left: 16, right: 16),
        shareTitle: 'Share Event',
        title: event!.strCategory.toString(),
        subject: 'Event - Narayana Educational Institutions',
        imageUrl: event.strMealThumb,
        richText: event.strCreativeCommonsConfirmed,
        imageName: event.strCategory,
      );

  Widget ingredient(String? ingre, String? mea) {
    return (ingre == null || ingre == "" || mea == null || mea == "")
        ? Container()
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 186, 207, 223),
            ),
            padding: const EdgeInsets.all(10),
            // height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ingre,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  // mea ?? "",
                  mea,

                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
          );
  }
  // Widget fab(VoidCallback onPressed) {
  //   return IconButton(
  //     icon: controller.isFav!
  //         ? const Icon(
  //             Icons.favorite,
  //             color: Colors.red,
  //           )
  //         : const Icon(Icons.favorite_border_outlined),
  //     onPressed: onPressed,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var mealId = Get.arguments["idMeal"];

    return GetBuilder<SingleController>(initState: (_) async {
      // print(mealId);

      await controller.getItemById(mealId);
      await controller.getIsMealFavorite(mealId);
    }, builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // title: const Text(
          //   "Chicken",
          //   style:
          //       TextStyle(fontWeight: FontWeight.bold, color: Colors.black38),
          // ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => DownLoadingPdf(
                          single: controller.singleRes,
                        ));
              },
              icon: const Icon(Icons.download),
              color: Colors.black38,
            )
          ],
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black38),
            onPressed: () => Get.back(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: controller.isSingleScreenLoading
            ? const BodyLoader()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CircleAvatar(
                      //   radius: 72.0,
                      //   backgroundColor: Colors.transparent,
                      //   backgroundImage:
                      //       NetworkImage(controller.singleRes!.strMealThumb.toString()),
                      // ),
                      Container(
                          width: 500.00,
                          height: 400.00,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: NetworkImage(controller
                                  .singleRes!.strMealThumb
                                  .toString()),
                              fit: BoxFit.fitHeight,
                            ),
                          )),
                      // if (controller.singleRes != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.singleRes!.strMeal.toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // const Spacer(),
                            IconButton(
                                onPressed: () async {
                                  if (controller.singleRes != null &&
                                      controller.singleRes!.strMealThumb !=
                                          null) {
                                    appBarShareButton(
                                        controller.singleRes, controller);
                                  }
                                  // final imagePath =
                                  //     controller.singleRes?.strMealThumb;

                                  // await Share.share(controller
                                  //     .singleRes!.strCategory
                                  //     .toString());
                                },
                                icon: const Icon(
                                  Icons.share,
                                )),
                            GestureDetector(
                              child: controller.isFav
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_outlined,
                                    ),
                              onTap: () {
                                controller.setIsMealFavorited(
                                    mealId, !controller.isFav);
                              },
                            ),
                            // IconButton(
                            //   color: controller.onClick
                            //       ? Colors.red
                            //       : Colors.black,
                            //   onPressed: controller.toggle,
                            //   icon: controller.onClick
                            //       ? const Icon(
                            //           Icons.favorite,
                            //         )
                            //       : const Icon(
                            //           Icons.favorite_border_outlined,
                            //         ),
                            // ),
                            // fab(() {
                            //   controller
                            //       .isFavorite(controller.favFood.toString());
                            // })
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Ingredients",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "Measurement",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      ingredient(
                        controller.singleRes!.strIngredient1.toString(),
                        controller.singleRes!.strMeasure1.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient2.toString(),
                        controller.singleRes!.strMeasure2.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient3.toString(),
                        controller.singleRes!.strMeasure3.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient4.toString(),
                        controller.singleRes!.strMeasure4.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient5.toString(),
                        controller.singleRes!.strMeasure5.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient6.toString(),
                        controller.singleRes!.strMeasure6.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient7.toString(),
                        controller.singleRes!.strMeasure7.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient8.toString(),
                        controller.singleRes!.strMeasure8.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient9.toString(),
                        controller.singleRes!.strMeasure9.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient10.toString(),
                        controller.singleRes!.strMeasure10.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient11.toString(),
                        controller.singleRes!.strMeasure11.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient12.toString(),
                        controller.singleRes!.strMeasure12.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient13.toString(),
                        controller.singleRes!.strMeasure13.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient14.toString(),
                        controller.singleRes!.strMeasure14.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient15.toString(),
                        controller.singleRes!.strMeasure15.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient16.toString(),
                        controller.singleRes!.strMeasure16.toString(),
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient17.toString(),
                        controller.singleRes!.strMeasure17.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient18.toString(),
                        controller.singleRes!.strMeasure18.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ingredient(
                        controller.singleRes!.strIngredient19.toString(),
                        controller.singleRes!.strMeasure19.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      ingredient(
                        controller.singleRes!.strIngredient20.toString(),
                        controller.singleRes!.strMeasure20.toString(),
                      ),

                      const Text(
                        "Instructions",
                        // controller.singleRes!.strInstructions.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.singleRes!.strInstructions.toString(),
                          // controller.singleRes!.strInstructions.toString(),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Container(
                      //       width: 150.00,
                      //       height: 50.00,
                      //       decoration: const BoxDecoration(
                      //         color: Colors.grey,
                      //       ),
                      //       child: Center(
                      //           child: Text(
                      //         controller.totalPrice.toString(),
                      //         style: const TextStyle(
                      //           fontSize: 15,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       )),
                      //     ),
                      //     Container(
                      //       width: 150.00,
                      //       height: 50.00,
                      //       decoration: const BoxDecoration(
                      //         color: Colors.grey,
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           IconButton(
                      //             onPressed: controller.decrement,
                      //             icon: const Icon(Icons.remove),
                      //           ),
                      //           Text(
                      //             controller.quantity.toString(),
                      //             style: const TextStyle(
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           IconButton(
                      //             onPressed: controller.increment,
                      //             icon: const Icon(Icons.add),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Container(
                      //   child: RichText(
                      //     text: TextSpan(
                      //       children: [
                      //         TextSpan(
                      //           text: 'This is Source Link',
                      //           style: const TextStyle(color: Colors.blue),
                      //           recognizer: TapGestureRecognizer()
                      //             ..onTap = () {
                      //               controller.singleRes!.strSource.toString();
                      //             },
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                      InkWell(
                        child: const Text(
                          'This is Source Link',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () => launchUrl(
                          Uri.parse(
                              controller.singleRes!.strYoutube.toString()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
