class Car {
  final String? id;
  final String model;
  final String brand;
  final int year;
  final double price;
  final int quantity;
  final String? categoryId;

  Car({
    this.id,
    required this.model,
    required this.brand,
    required this.year,
    required this.price,
    required this.quantity,
    this.categoryId,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      model: json['model'],
      brand: json['brand'],
      year: json['year'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model': model,
      'brand': brand,
      'year': year,
      'price': price,
      'quantity': quantity,
      'categoryId': categoryId,
    };
  }
}
