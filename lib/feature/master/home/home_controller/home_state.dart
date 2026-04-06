import 'package:flutter/material.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

@immutable
class HomeState {
  const HomeState({
    this.currentBanner = 0,
    this.isSearchExpanded = false,
    this.suggestions = const <String>[],
    this.searchResults = const <ProductModel>[],
  });

  final int currentBanner;
  final bool isSearchExpanded;
  final List<String> suggestions;
  final List<ProductModel> searchResults;

  HomeState copyWith({
    int? currentBanner,
    bool? isSearchExpanded,
    List<String>? suggestions,
    List<ProductModel>? searchResults,
  }) {
    return HomeState(
      currentBanner: currentBanner ?? this.currentBanner,
      isSearchExpanded: isSearchExpanded ?? this.isSearchExpanded,
      suggestions: suggestions ?? this.suggestions,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}
