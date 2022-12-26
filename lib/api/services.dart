import 'package:hive/hive.dart';

import '../main.dart';

class DBServices {
  Future<bool> isMealFavorited(String idMeal) async {
    var box = Hive.box(FAVORITES_BOX);

    var value = await box.get(FAVORITES_BOX);
    if (value == null || value == false) return false;

    return true;
  }

  Future<List<String>> getAllFovoriteMeal() async {
    var box = Hive.box(FAVORITES_BOX);

    var list = box.keys.toList();

    List<String> favorites = [];

    for (var i in list) {
      if (box.get(i) == true) {
        favorites.add(i.toString());
      }
    }
    return favorites;
  }

  Future<bool>saveMealFavorite(String idMeal, bool isFavrite) async {
    var box = Hive.box(FAVORITES_BOX);

    await box.put(idMeal, isFavrite);
    return isFavrite;
  }
}
