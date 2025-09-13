class RouteModel {
  final String id;
  final String name;
  final String toLocation;
  final double distance;
  final int duration; // بالدقائق
  final double price;
  final int shipmentsCount;

  RouteModel({
    required this.id,
    required this.name,
    required this.toLocation,
    required this.distance,
    required this.duration,
    required this.price,
    required this.shipmentsCount,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['id'],
      name: json['name'],
      toLocation: json['toLocation'],
      distance: json['distance'].toDouble(),
      duration: json['duration'],
      price: json['price'].toDouble(),
      shipmentsCount: json['shipmentsCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'toLocation': toLocation,
      'distance': distance,
      'duration': duration,
      'price': price,
      'shipmentsCount': shipmentsCount,
    };
  }
}