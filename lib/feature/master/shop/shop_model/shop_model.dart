import 'package:optizenqor/feature/master/product_details/product_details_model/category_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class ShopModel {
  const ShopModel({required this.categories, required this.products});

  final List<CategoryModel> categories;
  final List<ProductModel> products;
}
