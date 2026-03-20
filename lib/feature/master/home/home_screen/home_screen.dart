import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/card_widget.dart';
import 'package:optizenqor/feature/master/home/home_controller/home_controller.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/category_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = HomeController();
  final TextEditingController _searchController = TextEditingController();
  final PageController _bannerController = PageController(
    viewportFraction: 0.92,
  );
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
  int _currentBanner = 0;

  @override
  void dispose() {
    _searchController.dispose();
    _bannerController.dispose();
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
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomeModelData data = HomeModelData.fromController(_controller);
    final List<ProductModel> banners = data.featuredProducts.take(3).toList();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        titleSpacing: 0,
        title: Container(
          height: 42,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search products',
              hintStyle: TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (_suggestions.isNotEmpty) _buildSuggestionList(),
            const SizedBox(height: 20),
            _buildBannerCarousel(banners),
            const SizedBox(height: 12),
            _buildBannerIndicator(banners.length),
            const SizedBox(height: 24),
            _buildCategoryHeader(context),
            const SizedBox(height: 10),
            _buildCategoryScroller(data.categories, context),
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
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionList() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.primary.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: _suggestions.map((String item) {
          return ListTile(
            dense: true,
            title: Text(item, style: const TextStyle(color: Colors.white)),
            onTap: () {
              _searchController.text = item;
              setState(() {
                _suggestions = <String>[];
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBannerCarousel(List<ProductModel> banners) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.48,
      child: PageView(
        controller: _bannerController,
        onPageChanged: (int index) {
          setState(() {
            _currentBanner = index;
          });
        },
        children: banners.map((ProductModel product) {
          return Padding(
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
          );
        }).toList(),
      ),
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

  Widget _buildCategoryHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text('Categories', style: AppTextStyle.heading),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.categories);
            },
            child: const Text('See all'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryScroller(
    List<CategoryModel> categories,
    BuildContext context,
  ) {
    return SizedBox(
      height: 116,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (BuildContext context, int index) {
          final CategoryModel category = categories[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoute.categories);
            },
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColor.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Icon(Icons.arrow_outward, color: AppColor.accent),
                  Text(category.name, style: AppTextStyle.title),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeModelData {
  const HomeModelData({
    required this.categories,
    required this.featuredProducts,
  });

  final List<CategoryModel> categories;
  final List<ProductModel> featuredProducts;

  factory HomeModelData.fromController(HomeController controller) {
    final data = controller.dashboardData;
    return HomeModelData(
      categories: data.categories,
      featuredProducts: data.featuredProducts,
    );
  }
}
