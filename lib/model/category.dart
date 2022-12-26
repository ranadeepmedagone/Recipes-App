class Category {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  Category({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> data) {
    return Category(
      // dateOfJoin: data['date_of_join'],
      idCategory: data['idCategory'],
      strCategory: data['strCategory'],
      strCategoryDescription: data['strCategoryDescription'],
      strCategoryThumb: data['strCategoryThumb']
    );
  }

  Map<String, dynamic> toJson() {
   
    return <String, dynamic>{
      // 'date_of_join': dateOfJoin,
      'idCategory': idCategory,
      'strCategory': strCategory,
      'strCategoryDescription': strCategoryDescription,
      'strCategoryThumb': strCategoryThumb
    };
  }
}
