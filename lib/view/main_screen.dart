import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/controller/main_controller.dart';
import 'package:meals/view/profile.dart';
import 'package:meals/widget/body_loader.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            // implement GridView.builder

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Text(
                        "Recipes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Get.to(const ProfileScreen());
                        },
                        icon: const Icon(
                          Icons.person,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            categoryController.toggle();
                          },
                          icon: controller.onClick
                              ? const Icon(Icons.close)
                              : const Icon(Icons.search)),
                    ],
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                //   child: TextField(
                //     onChanged: categoryController.quaryUsers,
                //     decoration: const InputDecoration(
                //       labelText: "Search",
                //       hintText: "Search",
                //       prefixIcon: Icon(Icons.search),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(20),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                if (controller.onClick)
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16.0, left: 16, right: 16),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 231, 229, 229),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Center(
                          child: TextField(
                            controller: controller.textEditingController,
                            focusNode: controller.textFocusNode,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              // prefix: Icon(Icons.search),
                              hintText: "Search here...",
                              border: InputBorder.none,
                            ),
                            onChanged: controller.quaryUsers,
                          ),
                        ),
                      ),
                    ),
                  ),
                Expanded(
                    child: categoryController.isLoading
                        ? const BodyLoader()
                        : GridView.builder(
                            // physics: null,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.85,
                              // mainAxisSpacing: 1.0,
                              // crossAxisSpacing: 1.0,
                            ),
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: controller
                                    .textEditingController.text.isNotEmpty
                                ? controller.searchedUsers.length
                                : categoryController.listOfCategories.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                key: ValueKey(
                                  categoryController.listOfCategories[index],
                                ),
                                onTap: () {
                                  categoryController.listOfItems.clear();
                                  categoryController.getAllItems(
                                      categoryController
                                          .listOfCategories[index].strCategory);
                                },
                                child: Column(children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.3),
                                    backgroundImage: NetworkImage(
                                        controller.textEditingController.text
                                                .isNotEmpty
                                            ? controller.searchedUsers[index]
                                                .strCategoryThumb
                                            : categoryController
                                                .listOfCategories[index]
                                                .strCategoryThumb,
                                        scale: 1.0),
                                  ),
                                  Text(
                                    controller.textEditingController.text
                                            .isNotEmpty
                                        ? controller
                                            .searchedUsers[index].strCategory
                                        : categoryController
                                            .listOfCategories[index]
                                            .strCategory,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                              );
                            }))
              ],
            ),
          ),
        ),
      );
    });
  }
}
