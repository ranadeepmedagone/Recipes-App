class Meals {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;


  Meals({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  });

  factory Meals.fromJson(Map<String, dynamic> data) {
    return Meals(
      // dateOfJoin: data['date_of_join'],
      idMeal: data['idMeal'],
      strMeal: data['strMeal'],
      strMealThumb: data['strMealThumb'],
    );
  }

  Map<String, dynamic> toJson() {
   
    return <String, dynamic>{
      // 'date_of_join': dateOfJoin,
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
    };
  }
}

// idMeal": "52772",
//       "strMeal": "Teriyaki Chicken Casserole",
//       "strDrinkAlternate": null,
//       "strCategory": "Chicken",
//       "strArea": "Japanese",
//       "strInstructions": "


// class MealSingle {
//   final String idMeal;
//   final String strMeal;
//   final String strMealThumb;
//   // final String strDrinkAlternate;
//   final String strArea;
//   final String strInstructions;

//   MealSingle({
//     required this.idMeal,
//     required this.strMeal,
//     required this.strMealThumb,
//     // required this.strDrinkAlternate,
//     required this.strArea,
//     required this.strInstructions
//   });

//   factory MealSingle.fromJson(Map<String, dynamic> data) {
//     return MealSingle(
//       // dateOfJoin: data['date_of_join'],
//       idMeal: data['idMeal'],
//       strMeal: data['strMeal'],
//       strMealThumb: data['strMealThumb'],
//       // strDrinkAlternate: data['strDrinkAlternate'],
//       strArea: data['strArea'],
//       strInstructions: data['strInstructions'],
//     );
//   }

//   Map<String, dynamic> toJson() {
   
//     return <String, dynamic>{
//       // 'date_of_join': dateOfJoin,
//       'idMeal': idMeal,
//       'strMeal': strMeal,
//       'strMealThumb': strMealThumb,
//       'strArea': strArea,
//       'strInstructions': strInstructions,
//     };
//   }
// }
