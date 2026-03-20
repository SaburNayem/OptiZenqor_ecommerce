import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/card_widget.dart';
import 'package:optizenqor/feature/master/drawer/drawer_screen/drawer_screen.dart';
import 'package:optizenqor/feature/master/home/home_controller/home_controller.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = HomeController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final List<String> _localProducts = <String>[
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

  List<String> _suggestions = <String>[];
  List<ProductModel> _searchedProducts = <ProductModel>[];
  int _currentBanner = 0;
  bool _isSearchExpanded = false;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _suggestions = <String>[];
      } else {
        _suggestions = _localProducts
            .where(
              (String item) => item.toLowerCase().contains(query.toLowerCase()),
            )
            .take(5)
            .toList();
      }
    });
  }

  void _performSearch(List<ProductModel> products) {
    final String query = _searchController.text.trim().toLowerCase();

    setState(() {
      _suggestions = <String>[];
      if (query.isEmpty) {
        _searchedProducts = <ProductModel>[];
        return;
      }

      _searchedProducts = products.where((ProductModel product) {
        return product.name.toLowerCase().contains(query) ||
            product.categoryName.toLowerCase().contains(query) ||
            product.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
      if (!_isSearchExpanded) {
        _searchController.clear();
        _suggestions = <String>[];
        _searchedProducts = <ProductModel>[];
        _searchFocusNode.unfocus();
      }
    });

    if (_isSearchExpanded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _searchFocusNode.requestFocus();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeModelData data = HomeModelData.fromController(_controller);
    final List<ProductModel> banners = data.topProducts.take(3).toList();
    final List<ProductModel> searchableProducts = data.searchableProducts;

    return Scaffold(
      backgroundColor: AppColor.background,
      drawer: const MasterDrawerScreen(),
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        leadingWidth: _isSearchExpanded ? 0 : null,
        automaticallyImplyLeading: !_isSearchExpanded,
        leading: _isSearchExpanded ? const SizedBox.shrink() : null,
        titleSpacing: _isSearchExpanded ? 12 : 0,
        title: _isSearchExpanded
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: _onSearchChanged,
                  onSubmitted: (_) => _performSearch(searchableProducts),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                    prefixIcon: IconButton(
                      onPressed: () => _performSearch(searchableProducts),
                      icon: const Icon(Icons.search, color: Colors.black),
                    ),
                    suffixIcon: IconButton(
                      onPressed: _toggleSearch,
                      icon: const Icon(Icons.close, color: Colors.black),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              )
            : const Text('Shob Bazaar'),
        actions: <Widget>[
          if (!_isSearchExpanded)
            IconButton(
              onPressed: () {
                setState(() {
                  _isSearchExpanded = true;
                });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    _searchFocusNode.requestFocus();
                  }
                });
              },
              icon: const Icon(Icons.search),
            ),
          if (!_isSearchExpanded)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
            ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                _buildBannerCarousel(banners),
                const SizedBox(height: 12),
                _buildBannerIndicator(banners.length),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Featured', style: AppTextStyle.heading),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: data.featuredProducts.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 16);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final ProductModel product = data.featuredProducts[index];
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
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Popular', style: AppTextStyle.heading),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: data.popularProducts.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 16);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final ProductModel product = data.popularProducts[index];
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
                ),
              ],
            ),
          ),
          if (_isSearchExpanded &&
              (_suggestions.isNotEmpty || _searchedProducts.isNotEmpty))
            Positioned(left: 0, right: 0, top: 0, child: _buildSearchOverlay()),
        ],
      ),
    );
  }

  Widget _buildSearchOverlay() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.border),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 340),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (_suggestions.isNotEmpty) _buildSuggestionList(),
              if (_searchedProducts.isNotEmpty) ...<Widget>[
                if (_suggestions.isNotEmpty) const SizedBox(height: 12),
                const Text('Search Result', style: AppTextStyle.title),
                const SizedBox(height: 10),
                SizedBox(
                  height: 220,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _searchedProducts.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 12);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final ProductModel product = _searchedProducts[index];
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
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        final String item = _suggestions[index];

        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          minTileHeight: 40,
          leading: const Icon(Icons.history, size: 18, color: Colors.black54),
          title: Text(
            item,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
          onTap: () {
            _searchController.text = item;
            _performSearch(
              HomeModelData.fromController(_controller).searchableProducts,
            );
          },
        );
      },
    );
  }

  Widget _buildBannerCarousel(List<ProductModel> banners) {
    return CarouselSlider.builder(
      itemCount: banners.length,
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.48,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 900),
        enlargeCenterPage: true,
        viewportFraction: 0.92,
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          setState(() {
            _currentBanner = index;
          });
        },
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final ProductModel product = banners[index];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoute.productDetails,
              arguments: product,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(product.imageUrl, fit: BoxFit.cover),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[Colors.transparent, Color(0xB0000000)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    right: 18,
                    bottom: 18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          product.categoryName,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBannerIndicator(int count) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(count, (int index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: 8,
            width: _currentBanner == index ? 22 : 8,
            decoration: BoxDecoration(
              color: _currentBanner == index
                  ? AppColor.primary
                  : AppColor.border,
              borderRadius: BorderRadius.circular(999),
            ),
          );
        }),
      ),
    );
  }
}

class HomeModelData {
  const HomeModelData({
    required this.topProducts,
    required this.featuredProducts,
    required this.popularProducts,
    required this.searchableProducts,
  });

  final List<ProductModel> topProducts;
  final List<ProductModel> featuredProducts;
  final List<ProductModel> popularProducts;
  final List<ProductModel> searchableProducts;

  factory HomeModelData.fromController(HomeController controller) {
    final data = controller.dashboardData;
    final List<ProductModel> searchableProducts = <ProductModel>[
      ...data.featuredProducts,
      ...data.trendingProducts,
    ];
    return HomeModelData(
      topProducts: data.featuredProducts,
      featuredProducts: data.featuredProducts,
      popularProducts: data.trendingProducts,
      searchableProducts: searchableProducts,
    );
  }
}
