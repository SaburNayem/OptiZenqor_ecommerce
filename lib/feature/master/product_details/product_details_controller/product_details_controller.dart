import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class ProductDetailsController {
  const ProductDetailsController();

  List<String> getHighlights(ProductModel product) {
    return <String>[
      'Premium pick from ${product.categoryName}',
      'Rating ${product.rating} out of 5',
      'Ready for mock checkout flow',
    ];
  }
}
