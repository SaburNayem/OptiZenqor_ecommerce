import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/feature/master/shop/shop_controller/shop_controller.dart';
import 'package:optizenqor/feature/master/shop/shop_controller/shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit({ShopController? controller})
    : _controller = controller ?? ShopController(),
      super(const ShopState()) {
    initialize();
  }

  final ShopController _controller;

  void initialize({String? initialQuery}) {
    final String query = initialQuery?.trim() ?? '';
    final List<ProductModel> products = query.isEmpty
        ? _controller.data.products
        : _controller.searchProducts(query);

    emit(
      state.copyWith(
        query: query,
        products: _applySort(
          _applyFilters(
            products,
            priceRange: state.priceRange,
            minimumRating: state.minimumRating,
          ),
          state.sortBy,
        ),
      ),
    );
  }

  void search(String query) {
    emit(
      state.copyWith(
        query: query,
        products: _applySort(
          _applyFilters(
            _controller.searchProducts(query),
            priceRange: state.priceRange,
            minimumRating: state.minimumRating,
          ),
          state.sortBy,
        ),
      ),
    );
  }

  void clearSearch() {
    search('');
  }

  void updateFilters({
    required RangeValues priceRange,
    required double minimumRating,
  }) {
    emit(
      state.copyWith(
        priceRange: priceRange,
        minimumRating: minimumRating,
        products: _applySort(
          _applyFilters(
            _controller.searchProducts(state.query),
            priceRange: priceRange,
            minimumRating: minimumRating,
          ),
          state.sortBy,
        ),
      ),
    );
  }

  void resetFilters() {
    updateFilters(
      priceRange: const RangeValues(0, 50),
      minimumRating: 0,
    );
  }

  void updateSort(String sortBy) {
    emit(
      state.copyWith(
        sortBy: sortBy,
        products: _applySort(
          _applyFilters(
            _controller.searchProducts(state.query),
            priceRange: state.priceRange,
            minimumRating: state.minimumRating,
          ),
          sortBy,
        ),
      ),
    );
  }

  List<ProductModel> _applyFilters(
    List<ProductModel> products, {
    required RangeValues priceRange,
    required double minimumRating,
  }) {
    return products.where((ProductModel product) {
      return product.price >= priceRange.start &&
          product.price <= priceRange.end &&
          product.rating >= minimumRating;
    }).toList();
  }

  List<ProductModel> _applySort(List<ProductModel> products, String sortBy) {
    final List<ProductModel> sorted = List<ProductModel>.from(products);

    switch (sortBy) {
      case 'price_low_to_high':
        sorted.sort(
          (ProductModel a, ProductModel b) => a.price.compareTo(b.price),
        );
        break;
      case 'price_high_to_low':
        sorted.sort(
          (ProductModel a, ProductModel b) => b.price.compareTo(a.price),
        );
        break;
      case 'rating':
        sorted.sort(
          (ProductModel a, ProductModel b) => b.rating.compareTo(a.rating),
        );
        break;
      case 'name':
        sorted.sort(
          (ProductModel a, ProductModel b) => a.name.compareTo(b.name),
        );
        break;
      case 'default':
      default:
        break;
    }

    return sorted;
  }
}
