import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optizenqor/feature/master/home/home_controller/home_controller.dart';
import 'package:optizenqor/feature/master/home/home_controller/home_state.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({HomeController? controller})
    : _controller = controller ?? HomeController(),
      super(const HomeState());

  final HomeController _controller;
  final List<String> _localProducts = const <String>[
    'Laptop',
    'Laptop Bag',
    'Laptop Stand',
    'Headphones',
    'Headset',
    'Mouse',
    'Keyboard',
    'Smartphone',
    'Smartwatch',
    'Tablet',
  ];

  List<ProductModel> get searchableProducts {
    final data = _controller.dashboardData;
    return <ProductModel>[...data.featuredProducts, ...data.trendingProducts];
  }

  void setCurrentBanner(int index) {
    emit(state.copyWith(currentBanner: index));
  }

  void expandSearch() {
    emit(state.copyWith(isSearchExpanded: true));
  }

  void clearSearch() {
    emit(
      state.copyWith(
        isSearchExpanded: false,
        suggestions: const <String>[],
        searchResults: const <ProductModel>[],
      ),
    );
  }

  void onSearchChanged(String query) {
    final String normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      emit(
        state.copyWith(
          suggestions: const <String>[],
          searchResults: const <ProductModel>[],
        ),
      );
      return;
    }

    final List<String> suggestions = _localProducts
        .where((String item) => item.toLowerCase().contains(normalizedQuery))
        .take(5)
        .toList();
    final List<ProductModel> results = searchableProducts
        .where(
          (ProductModel product) =>
              product.name.toLowerCase().contains(normalizedQuery) ||
              product.categoryName.toLowerCase().contains(normalizedQuery),
        )
        .toList();

    emit(state.copyWith(suggestions: suggestions, searchResults: results));
  }
}
