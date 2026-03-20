import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/widget/card_widget.dart';
import 'package:optizenqor/feature/master/offer/offer_controller/offer_controller.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen>
    with SingleTickerProviderStateMixin {
  final OfferController _controller = OfferController();
  late final TabController _tabController;
  bool _isListView = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _controller.data.tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = _controller.data;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _isListView = !_isListView;
              });
            },
            icon: Icon(
              _isListView ? Icons.grid_view_rounded : Icons.view_list_rounded,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: data.tabs.map((String item) => Tab(text: item)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List<Widget>.generate(data.tabs.length, (int index) {
          if (_isListView) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: data.products.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (BuildContext context, int itemIndex) {
                final ProductModel product = data.products[itemIndex];
                return _OfferListTile(
                  product: product,
                  badge: data.tabs[index],
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
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.64,
            ),
            itemBuilder: (BuildContext context, int itemIndex) {
              final ProductModel product = data.products[itemIndex];
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
    );
  }
}

class _OfferListTile extends StatelessWidget {
  const _OfferListTile({
    required this.product,
    required this.badge,
    required this.onTap,
  });

  final ProductModel product;
  final String badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.border),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                product.imageUrl,
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F8F7),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      badge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.categoryName,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColor.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColor.accent,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${product.rating} ★',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
