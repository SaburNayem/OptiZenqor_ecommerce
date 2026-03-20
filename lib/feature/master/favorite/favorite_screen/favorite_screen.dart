import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/favorite/favorite_controller/favorite_controller.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late final List<ProductModel> _favoriteProducts;

  @override
  void initState() {
    super.initState();
    _favoriteProducts = List<ProductModel>.from(
      FavoriteController().data.products,
    );
  }

  void _removeFavorite(ProductModel product) {
    setState(() {
      _favoriteProducts.removeWhere(
        (ProductModel item) => item.id == product.id,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} removed from favorites')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Favorites'),
      body: _favoriteProducts.isEmpty
          ? const Center(child: Text('No favorite products yet'))
          : Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
              child: ListView.separated(
                itemCount: _favoriteProducts.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 14),
                itemBuilder: (BuildContext context, int index) {
                  final ProductModel product = _favoriteProducts[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.productDetails,
                        arguments: product,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColor.border),
                      ),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.network(
                              product.imageUrl,
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(product.name, style: AppTextStyle.title),
                                const SizedBox(height: 4),
                                Text(
                                  product.categoryName,
                                  style: AppTextStyle.body,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.accent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                onPressed: () => _removeFavorite(product),
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                '${product.rating} ★',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
