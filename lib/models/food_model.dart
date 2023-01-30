
class FoodModel {
  final int id;
  final String name;
  final String imageUrl;
  final String category;
  final int categoryId;
  final int price;

  FoodModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.categoryId,
    required this.price,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        category: json["category"],
        categoryId: json["category_id"],
        price: json["price"],
      );
}
