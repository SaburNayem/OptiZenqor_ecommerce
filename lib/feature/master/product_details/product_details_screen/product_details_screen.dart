import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/button_widget.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/product_details/product_details_controller/product_details_controller.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({required this.product, super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    const ProductDetailsController controller = ProductDetailsController();
    final List<String> highlights = controller.getHighlights(product);

    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Product Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),
            Text(product.name, style: AppTextStyle.heading),
            const SizedBox(height: 8),
            Text(product.categoryName, style: AppTextStyle.label),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColor.accent,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x1AFF6B35),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text('${product.rating} ★'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(product.description, style: AppTextStyle.body),
            const SizedBox(height: 18),
            ...highlights.map(
              (String item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.check_circle,
                      color: AppColor.success,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(item, style: AppTextStyle.body)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              title: 'Add To Cart',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} added to cart')),
                );
              },
            ),
            const SizedBox(height: 12),
            AppButton(
              title: 'Go To Cart',
              isOutlined: true,
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.mainShell, arguments: 3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
