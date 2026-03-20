import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/widget/card_widget.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/drawer/drawer_screen/drawer_screen.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/feature/master/shop/shop_controller/shop_controller.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({this.initialQuery, super.key});

  final String? initialQuery;

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ShopController _controller = ShopController();
  final TextEditingController _searchController = TextEditingController();
  late List<ProductModel> _products;
  RangeValues _priceRange = const RangeValues(0, 50);
  double _minimumRating = 0;
  String _sortBy = 'default';

  bool get _hasSearchQuery => _searchController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _products = _controller.data.products;

    if (widget.initialQuery != null && widget.initialQuery!.trim().isNotEmpty) {
      _searchController.text = widget.initialQuery!;
      _products = _controller.searchProducts(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _products = _applySort(_applyFilters(_controller.searchProducts(query)));
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _products = _applySort(_applyFilters(_controller.data.products));
    });
  }

  List<ProductModel> _applyFilters(List<ProductModel> products) {
    return products.where((ProductModel product) {
      return product.price >= _priceRange.start &&
          product.price <= _priceRange.end &&
          product.rating >= _minimumRating;
    }).toList();
  }

  List<ProductModel> _applySort(List<ProductModel> products) {
    final List<ProductModel> sorted = List<ProductModel>.from(products);

    switch (_sortBy) {
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

  void _refreshProducts() {
    setState(() {
      _products = _applySort(
        _applyFilters(
          _controller.searchProducts(_searchController.text.trim()),
        ),
      );
    });
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
                                        const SizedBox(height: 12),
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
                                          _refreshProducts();
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
                                          _refreshProducts();
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
                      _refreshProducts();
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
    return Scaffold(
      endDrawer: const MasterDrawerScreen(),
      appBar: AppCustomAppBar(
        title: 'Shop',
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(Icons.menu_rounded),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (!_hasSearchQuery) ...<Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.categories);
                      },
                      child: const Text('Categories'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.offer);
                      },
                      child: const Text('Offer'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
            ],
            TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _hasSearchQuery
                    ? IconButton(
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 18),
            Row(
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
                        border: Border.all(color: const Color(0xFFE3E8EB)),
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
                        border: Border.all(color: const Color(0xFFE3E8EB)),
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
            const SizedBox(height: 18),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (BuildContext context, int index) {
                final ProductModel product = _products[index];
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
            ),
          ],
        ),
      ),
    );
  }
}
