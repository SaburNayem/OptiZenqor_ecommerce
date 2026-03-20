import 'package:optizenqor/feature/master/offer/offer_model/offer_model.dart';
import 'package:optizenqor/http_mathod/network_service/catalog_service.dart';

class OfferController {
  OfferController({CatalogService? catalogService})
    : _catalogService = catalogService ?? const CatalogService();

  final CatalogService _catalogService;

  OfferModel get data => OfferModel(
    tabs: const <String>[
      'Free Delivery',
      'Flash Sell',
      'Buy Get',
      'Must Buy',
      'Best Price',
      'Mega Discount',
      'Free Gift',
    ],
    products: _catalogService.getProducts(),
  );
}
