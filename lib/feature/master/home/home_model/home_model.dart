import 'package:optizenqor/feature/master/product_details/product_details_model/category_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class HomeModel {
  const HomeModel({
    required this.categories,
    required this.featuredProducts,
    required this.trendingProducts,
  });

  final List<CategoryModel> categories;
  final List<ProductModel> featuredProducts;
  final List<ProductModel> trendingProducts;
}
