import 'package:optizenqor/feature/master/product_details/product_details_model/category_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class HomeModel {
  const HomeModel({
    required this.categories,
    required this.featuredProducts,
    required this.trendingProducts,
    required this.newArrivedProducts,
    required this.bestForYouProducts,
  });

  final List<CategoryModel> categories;
  final List<ProductModel> featuredProducts;
  final List<ProductModel> trendingProducts;
  final List<ProductModel> newArrivedProducts;
  final List<ProductModel> bestForYouProducts;
}
