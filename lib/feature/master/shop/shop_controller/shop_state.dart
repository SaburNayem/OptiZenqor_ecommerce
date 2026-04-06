import 'package:flutter/material.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

@immutable
class ShopState {
  const ShopState({
    this.products = const <ProductModel>[],
    this.priceRange = const RangeValues(0, 50),
    this.minimumRating = 0,
    this.sortBy = 'default',
    this.query = '',
  });

  final List<ProductModel> products;
  final RangeValues priceRange;
  final double minimumRating;
  final String sortBy;
  final String query;

  bool get hasSearchQuery => query.trim().isNotEmpty;

  ShopState copyWith({
    List<ProductModel>? products,
    RangeValues? priceRange,
    double? minimumRating,
    String? sortBy,
    String? query,
  }) {
    return ShopState(
      products: products ?? this.products,
      priceRange: priceRange ?? this.priceRange,
      minimumRating: minimumRating ?? this.minimumRating,
      sortBy: sortBy ?? this.sortBy,
      query: query ?? this.query,
    );
  }
}
