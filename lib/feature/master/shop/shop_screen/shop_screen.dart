import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/card_widget.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/feature/master/shop/shop_controller/shop_controller.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ShopController _controller = ShopController();
  final TextEditingController _searchController = TextEditingController();
  late List<ProductModel> _products;

  @override
  void initState() {
    super.initState();
    _products = _controller.data.products;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _products = _controller.searchProducts(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = _controller.data;

    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Shop'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Offer page ready to add next'),
                        ),
                      );
                    },
                    child: const Text('Offer'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: const InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.categories.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 10),
                itemBuilder: (BuildContext context, int index) {
                  final category = data.categories[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColor.border),
                    ),
                    child: Text(category.name, style: AppTextStyle.body),
                  );
                },
              ),
            ),
            const SizedBox(height: 22),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.68,
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
