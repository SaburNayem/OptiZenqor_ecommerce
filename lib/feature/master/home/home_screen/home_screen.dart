import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/card_widget.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/home/home_controller/home_controller.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/category_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeModelData data = HomeModelData.fromController(HomeController());

    return Scaffold(
      appBar: const AppCustomAppBar(title: 'OmniZara'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFF1F2937), Color(0xFFFF6B35)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'New season essentials',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Explore curated arrivals inspired by the OmniZara reference app flow.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Categories', style: AppTextStyle.heading),
            const SizedBox(height: 12),
            SizedBox(
              height: 108,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.categories.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 12),
                itemBuilder: (BuildContext context, int index) {
                  final CategoryModel category = data.categories[index];
                  return Container(
                    width: 140,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColor.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Icon(
                          Icons.category_outlined,
                          color: AppColor.accent,
                        ),
                        Text(category.name, style: AppTextStyle.title),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text('Featured', style: AppTextStyle.heading),
            const SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.featuredProducts.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 16),
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
