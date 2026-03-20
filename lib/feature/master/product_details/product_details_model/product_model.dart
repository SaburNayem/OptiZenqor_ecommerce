class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.description,
  });

  final String id;
  final String name;
  final String categoryId;
  final String categoryName;
  final double price;
  final double rating;
  final String imageUrl;
  final String description;
}
