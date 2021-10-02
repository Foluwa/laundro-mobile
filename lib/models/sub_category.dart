class SubCategoryList {
  List<SubCategory> subcategory;
  SubCategoryList({required this.subcategory});

  factory SubCategoryList.fromJson(subcategory) {
    final operations = subcategory as List;
    final data = operations.map((f) => SubCategory.fromJson(f)).toList();
    return SubCategoryList(subcategory: data);
  }
}

class SubCategory {
  int id;
  String name;
  String description;
  int category_id;
  String img_url;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.category_id,
    required this.img_url,
  });

  factory SubCategory.fromJson(subCategory) {
    // print('${subCategory['id']} is ${subCategory['Image'][0]['url']}');
    return SubCategory(
      id: subCategory['id'] ?? '',
      name: subCategory['Name'] ?? '',
      description: subCategory['Description'] ?? '',
      category_id: subCategory['category'] ?? '',
      img_url: subCategory['Image'][0]['url'] ?? '',
    );
  }

  @override
  String toString() {
    return 'id: ${id}, product_name: ${name}';
  }
}
