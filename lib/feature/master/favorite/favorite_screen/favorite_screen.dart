import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/widget/card_widget.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/favorite/favorite_controller/favorite_controller.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = FavoriteController().data;

    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Favorites'),
      body: data.products.isEmpty
          ? const Center(child: Text('No favorite products yet'))
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: data.products.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 16),
              itemBuilder: (BuildContext context, int index) {
                final product = data.products[index];
                return SizedBox(
                  height: 280,
                  child: ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.productDetails,
                        arguments: product,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
