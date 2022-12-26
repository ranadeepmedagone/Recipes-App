import 'dart:io';

// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
// import 'package:wc_flutter_share/wc_flutter_share.dart';

import '../api/dio_helper.dart';
import '../api/services.dart';
import '../model/single_meal.dart';

class SingleController extends GetxController {
  DioHelpers api = Get.put(DioHelpers());
  MealSingle? singleRes;
  bool isSingleScreenLoading = true;
  List<MealSingle> favFood = [];
  bool onClick = true;
  DBServices dbServices = DBServices();

  bool isFav = false;

  Future<void> getIsMealFavorite(String idMeal) async {
    isSingleScreenLoading = true;

    isFav = await dbServices.isMealFavorited(idMeal);
    isSingleScreenLoading = false;

    update();
  }

  Future<void> setIsMealFavorited(String id, bool val) async {
    isSingleScreenLoading = true;

    isFav = await dbServices.saveMealFavorite(id, val);
    isSingleScreenLoading = false;

    update();
  }

  void toggle() {
    onClick = !onClick;
    update();
  }

  // isFavorite(MealSingle f) {
  //   f.fav = !f.fav!;
  //   if (f.fav!) {
  //     favFood.add(f);
  //   }
  //   print("favoriteItem+++++++++++++$f");
  //   if (!isFav!) {
  //     favFood.removeWhere((element) => element == f);
  //   }
  //   update();
  // }

  Future<void> getItemById(String idMeal) async {
    isSingleScreenLoading = true;

    final res = await api.itemGetById(idMeal: idMeal);

    singleRes = res;
    isSingleScreenLoading = false;
    update();
  }

  static String? getFileExtFromNetworkUrl(String url) {
    final strs = url.trim().toLowerCase().replaceAll("/", "").split(".");
    if (strs.length > 0) {
      return strs.last;
    } else {
      return null;
    }
  }

  static String? getMimeTypeFromExtension(String ext) {
    if (ext == "png") return "image/png";
    if (ext == "jpg" || ext == "jpeg") return "image/jpeg";
    if (ext == "gif") return "image/gif";
    if (ext == "xlsx")
      return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    if (ext == "docx")
      return "'application/vnd.openxmlformats-officedocument.wordprocessingml.document'";

    if (ext == "pdf") return 'application/pdf';
    return null;
  }

  void onShareClicked(String url) async {
    String? fileExt;
    fileExt = getFileExtFromNetworkUrl(url);

    Uint8List? bytes =
        (await NetworkAssetBundle(Uri.parse(singleRes!.strMealThumb.toString()))
                .load(singleRes!.strMealThumb.toString()))
            .buffer
            .asUint8List();
    Directory? tempDir = await getExternalStorageDirectory();

    print(" temp dir : $tempDir");
    if (tempDir == null) return;
    String tempPath = tempDir.absolute.path;
    // var filePath = tempPath + '/file_01.png';

    var file = File("$tempPath/myfile.png");
    file = await file.writeAsBytes(bytes);

    // if (!fileExt.isBlank!) {
    //   image = await api.getBytesOfNetworkFile(Uri.parse(url));
    // }
    try {
      await Share.shareFiles([file.path], text: "My awesome new meal");

      // await WcFlutterShare.share(
      //   sharePopupTitle: 'Share Image',
      //   subject: "Gallery Image - Narayana Educational Institutions",
      //   text:
      //       "${singleRes!.strMeal}: \nShared from nConnect App by Narayana Educational Institutions.",
      //   fileName: "${'nconnect-event-image'}.$fileExt",
      //   mimeType: getMimeTypeFromExtension(fileExt!)!,
      //   bytesOfFile: bytes,
      //   //  mimeType: '',
      // );
    } catch (err) {
      print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww$err");
      // Get.snackbar('User 123', 'Error', snackPosition: SnackPosition.BOTTOM);
    }
    // isSharePressed.value = false;
  }
}
