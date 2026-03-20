import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/widget/card_widget.dart';
import 'package:optizenqor/feature/master/categories/category_detail_controller/category_detail_controller.dart';
import 'package:optizenqor/feature/master/categories/category_detail_model/category_detail_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/http_mathod/network_service/catalog_service.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({
    required this.title,
    required this.categoryId,
    super.key,
  });

  final String title;
  final String categoryId;

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final CatalogService _catalogService = const CatalogService();
  final CategoryDetailController _controller = const CategoryDetailController();
  late final CategoryDetailModel _data;
  late final TabController _tabController;
  late final List<ProductModel> _allProducts;
  RangeValues _priceRange = const RangeValues(0, 50);
  double _minimumRating = 0;
  String _sortBy = 'default';

  @override
  void initState() {
    super.initState();
    _data = _controller.fromCategoryId(widget.categoryId);
    _tabController = TabController(length: _data.tabs.length, vsync: this);
    _allProducts = _catalogService.getProductsByCategory(widget.categoryId);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  List<ProductModel> _visibleProducts() {
    final String query = _searchController.text.trim().toLowerCase();
    final List<ProductModel> filtered = _allProducts.where((
      ProductModel product,
    ) {
      final bool matchesSearch =
          query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.categoryName.toLowerCase().contains(query);

      return matchesSearch &&
          product.price >= _priceRange.start &&
          product.price <= _priceRange.end &&
          product.rating >= _minimumRating;
    }).toList();

    switch (_sortBy) {
      case 'price_low_to_high':
        filtered.sort(
          (ProductModel a, ProductModel b) => a.price.compareTo(b.price),
        );
        break;
      case 'price_high_to_low':
        filtered.sort(
          (ProductModel a, ProductModel b) => b.price.compareTo(a.price),
        );
        break;
      case 'rating':
        filtered.sort(
          (ProductModel a, ProductModel b) => b.rating.compareTo(a.rating),
        );
        break;
      case 'name':
        filtered.sort(
          (ProductModel a, ProductModel b) => a.name.compareTo(b.name),
        );
        break;
      case 'default':
      default:
        break;
    }

    return filtered;
  }

  Future<void> _openFilterPanel() async {
    double selectedRating = _minimumRating;
    final TextEditingController minimumPriceController = TextEditingController(
      text: _priceRange.start.round().toString(),
    );
    final TextEditingController maximumPriceController = TextEditingController(
      text: _priceRange.end.round().toString(),
    );

    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Filter',
      barrierColor: Colors.black38,
      pageBuilder:
          (
            BuildContext dialogContext,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => const SizedBox.shrink(),
      transitionBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(-1, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOut,
                          ),
                        ),
                    child: Material(
                      color: Colors.white,
                      child: SafeArea(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.84,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Text(
                                      'Filter Products',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Price Range',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: TextField(
                                                controller:
                                                    minimumPriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: 'Minimum',
                                                      prefixText: '\$',
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: TextField(
                                                controller:
                                                    maximumPriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: 'Maximum',
                                                      prefixText: '\$',
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Minimum Rating: ${selectedRating.toStringAsFixed(1)}',
                                        ),
                                        const SizedBox(height: 10),
                                        DropdownButtonFormField<double>(
                                          initialValue: selectedRating,
                                          decoration: const InputDecoration(
                                            labelText: 'Rating',
                                          ),
                                          items:
                                              List<double>.generate(
                                                11,
                                                (int index) => index * 0.5,
                                              ).map((double value) {
                                                return DropdownMenuItem<double>(
                                                  value: value,
                                                  child: Text(
                                                    value == 0
                                                        ? 'All Ratings'
                                                        : '${value.toStringAsFixed(1)} & up',
                                                  ),
                                                );
                                              }).toList(),
                                          onChanged: (double? value) {
                                            if (value == null) {
                                              return;
                                            }
                                            setModalState(() {
                                              selectedRating = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            _priceRange = const RangeValues(
                                              0,
                                              50,
                                            );
                                            _minimumRating = 0;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Reset'),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: FilledButton(
                                        onPressed: () {
                                          final double? minimumPrice =
                                              double.tryParse(
                                                minimumPriceController.text
                                                    .trim(),
                                              );
                                          final double? maximumPrice =
                                              double.tryParse(
                                                maximumPriceController.text
                                                    .trim(),
                                              );
                                          final double resolvedMinimumPrice =
                                              (minimumPrice ?? 0).clamp(0, 50);
                                          final double resolvedMaximumPrice =
                                              (maximumPrice ?? 50).clamp(0, 50);
                                          final double startPrice =
                                              resolvedMinimumPrice <=
                                                  resolvedMaximumPrice
                                              ? resolvedMinimumPrice
                                              : resolvedMaximumPrice;
                                          final double endPrice =
                                              resolvedMaximumPrice >=
                                                  resolvedMinimumPrice
                                              ? resolvedMaximumPrice
                                              : resolvedMinimumPrice;

                                          setState(() {
                                            _priceRange = RangeValues(
                                              startPrice,
                                              endPrice,
                                            );
                                            _minimumRating = selectedRating;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Apply'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
    );
  }

  Future<void> _openSortSheet() async {
    String selectedSortBy = _sortBy;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Sort By',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  ...<Map<String, String>>[
                    <String, String>{'label': 'Default', 'value': 'default'},
                    <String, String>{
                      'label': 'Price: Low to High',
                      'value': 'price_low_to_high',
                    },
                    <String, String>{
                      'label': 'Price: High to Low',
                      'value': 'price_high_to_low',
                    },
                    <String, String>{'label': 'Ranking', 'value': 'rating'},
                    <String, String>{'label': 'Name', 'value': 'name'},
                  ].map((Map<String, String> option) {
                    final bool isSelected = selectedSortBy == option['value']!;

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        option['label']!,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle,
                              color: Color(0xFF0F9D9A),
                            )
                          : const Icon(
                              Icons.circle_outlined,
                              color: Color(0xFFB8C4CC),
                            ),
                      onTap: () {
                        setModalState(() {
                          selectedSortBy = option['value']!;
                        });
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  FilledButton(
                    onPressed: () {
                      setState(() {
                        _sortBy = selectedSortBy;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products = _visibleProducts();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(_data.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.mainShell,
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.home),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(58),
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            decoration: BoxDecoration(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              dividerColor: Colors.transparent,
              labelColor: AppColor.primary,
              unselectedLabelColor: Colors.white,
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              tabs: _data.tabs.map((String item) => Tab(text: item)).toList(),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _searchController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.trim().isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.close),
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF5FAFA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _openFilterPanel,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5FAFA),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColor.border),
                      ),
                      child: const Row(
                        children: <Widget>[
                          Icon(Icons.tune_rounded, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Filter',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _openSortSheet,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5FAFA),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColor.border),
                      ),
                      child: const Row(
                        children: <Widget>[
                          Icon(Icons.swap_vert_rounded, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Sort By',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List<Widget>.generate(_data.tabs.length, (
                int tabIndex,
              ) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.64,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final ProductModel product = products[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.productDetails,
                          arguments: product,
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
