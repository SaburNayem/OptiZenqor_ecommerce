import 'package:optizenqor/feature/master/favorite/favorite_model/favorite_model.dart';
import 'package:optizenqor/http_mathod/network_service/catalog_service.dart';

class FavoriteController {
  FavoriteController({CatalogService? catalogService})
    : _catalogService = catalogService ?? const CatalogService();

  final CatalogService _catalogService;

  FavoriteModel get data =>
      FavoriteModel(products: _catalogService.getProducts().take(2).toList());
}
