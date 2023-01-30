class RestaurantModel {
  RestaurantModel({
    required this.id,
    this.imageUrl,
    required this.name,
    required this.address,
    required this.category,
    required this.distance,
    required this.timeClose,
    required this.timeReady,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json['id'],
        name: json['name'],
        imageUrl: json['image_url'],
        address: json['address'],
        category: json['category'],
        distance: json['distance'],
        timeClose: json['close_time'],
        timeReady: json['time_ready'],
      );

  final int id;
  final String? imageUrl;
  final String name;
  final String address;
  final String category;
  final String distance;
  final String timeReady;
  final dynamic timeClose;
}
