class SubCategoryList {
  List<SubCategory> subcategory;
  SubCategoryList({this.subcategory});

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

  SubCategory({
    this.id,
    this.name,
    this.description,
    this.category_id,
  });

  factory SubCategory.fromJson(subCategory) {
    return SubCategory(
      id: subCategory['id'],
      name: subCategory['Name'],
      description: subCategory['Description'],
      category_id: subCategory['category'],
    );
  }

  @override
  String toString() {
    return 'id: ${id}, product_name: ${name}';
  }
}
