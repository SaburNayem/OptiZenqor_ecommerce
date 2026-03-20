import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class OfferModel {
  const OfferModel({required this.tabs, required this.products});

  final List<String> tabs;
  final List<ProductModel> products;
}
