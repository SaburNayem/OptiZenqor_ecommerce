import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class CartItemModel {
  const CartItemModel({required this.product, required this.quantity});

  final ProductModel product;
  final int quantity;
}
