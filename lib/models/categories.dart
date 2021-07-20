class CategoryList {
  List<Category> category;
  CategoryList({this.category});
  factory CategoryList.fromJson(category) {
    print('CategoryList category $category');
    final operations = category as List;
    print('CategoryList operations $operations');
    final data = operations.map((f) => Category.fromJson(f)).toList();
    print('CategoryList data $data');
    return CategoryList(category: data);
  }
}

class Category {
  int id;
  String Name;
  String Description;
  // SubCategory subCategory;

  Category({
    this.id,
    this.Name,
    this.Description,
    // this.subCategory,
  });

  factory Category.fromJson(Map<String, dynamic> category) {
    // var _subcategory;
    // if (category != null && category['sub_categories'] != null) {
    //   // print('Operations: ${booking['Operation']}');
    //   var dd = category['sub_categories'] as List;
    //   _subcategory = SubCategory.fromJson(dd);
    // }
    return Category(
      id: category['id'],
      Name: category['Name'],
      Description: category['Description'],
      // subCategory: _subcategory,
    );
  }

  @override
  String toString() {
    return 'id: ${id}, UserId: ${Name}';
  }
}
