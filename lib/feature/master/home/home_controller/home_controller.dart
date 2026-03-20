import 'package:optizenqor/feature/master/home/home_model/home_model.dart';
import 'package:optizenqor/http_mathod/network_service/catalog_service.dart';

class HomeController {
  HomeController({CatalogService? catalogService})
    : _catalogService = catalogService ?? const CatalogService();

  final CatalogService _catalogService;

  HomeModel get dashboardData => HomeModel(
    categories: _catalogService.getCategories(),
    featuredProducts: _catalogService.getFeaturedProducts(),
    trendingProducts: _catalogService.getProducts(),
  );
}
