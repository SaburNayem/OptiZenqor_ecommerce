import 'package:optizenqor/feature/master/cart/cart_model/cart_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/cart_item_model.dart';
import 'package:optizenqor/http_mathod/network_service/catalog_service.dart';

class CartController {
  CartController({CatalogService? catalogService})
    : _catalogService = catalogService ?? const CatalogService();

  final CatalogService _catalogService;

  CartModel get data => CartModel(
    items: _catalogService
        .getProducts()
        .take(2)
        .map((product) => CartItemModel(product: product, quantity: 1))
        .toList(),
  );

  double calculateTotal(List<CartItemModel> items) {
    return items.fold<double>(
      0,
      (double total, CartItemModel item) =>
          total + (item.product.price * item.quantity),
    );
  }
}
