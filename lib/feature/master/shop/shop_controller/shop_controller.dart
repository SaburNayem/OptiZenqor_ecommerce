import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/feature/master/shop/shop_model/shop_model.dart';
import 'package:optizenqor/http_mathod/network_service/catalog_service.dart';

class ShopController {
  ShopController({CatalogService? catalogService})
    : _catalogService = catalogService ?? const CatalogService();

  final CatalogService _catalogService;

  ShopModel get data => ShopModel(
    categories: _catalogService.getCategories(),
    products: _catalogService.getProducts(),
  );

  List<ProductModel> searchProducts(String query) {
    final List<ProductModel> products = _catalogService.getProducts();

    if (query.trim().isEmpty) {
      return products;
    }

    return products
        .where(
          (ProductModel product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.categoryName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
