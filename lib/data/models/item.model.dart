class ItemModel {
  String id;
  String name;
  String category;
  int quantity;
  double price;
  String description;

  ItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    required this.description,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price'] ?? 0,
      description: map['description'] ?? '',
    );
  }
}
