import 'sub_category.dart';

class CategoryList {
  List<Category> category;
  CategoryList({required this.category});
  factory CategoryList.fromJson(category) {
    final operations = category as List;
    final data = operations.map((f) => Category.fromJson(f)).toList();
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
