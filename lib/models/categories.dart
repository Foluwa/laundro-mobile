import 'sub_categories.dart';

class CategoryList {
  List<Category> category;
  CategoryList({required this.category});
  factory CategoryList.fromJson(category) {
    // print('CategoryList category $category');
    final operations = category as List;
    // print('CategoryList operations $operations');
    final data = operations.map((f) => Category.fromJson(f)).toList();
    // print('CategoryList data $data');
    return CategoryList(category: data);
  }
}

class Category {
  int id;
  String Name;
  String Description;
  SubCategoryList subCategory;

  Category({
    required this.id,
    required this.Name,
    required this.Description,
    required this.subCategory,
  });

  factory Category.fromJson(category) {
    // Map<String, dynamic> category
    // print('category $category');
    var _subcategory;
    if (category != null && category['sub_categories'] != null) {
      // print('Operations: ${booking['Operation']}');
      final dd = category['sub_categories']; //as List;
      _subcategory = SubCategoryList.fromJson(dd);
    }
    return Category(
      id: category['id'] ?? '',
      Name: category['Name'] ?? '',
      Description: category['Description'] ?? '',
      subCategory: _subcategory ?? '',
    );
  }

  @override
  String toString() {
    return 'id: ${id}, name: ${Name}';
  }
}
