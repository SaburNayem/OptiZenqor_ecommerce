import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/button_widget.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/cart/cart_controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = CartController();
    final data = controller.data;
    final total = controller.calculateTotal(data.items);

    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Cart'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                itemCount: data.items.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 14),
                itemBuilder: (BuildContext context, int index) {
                  final item = data.items[index];
                  return Container(
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
                            item.product.imageUrl,
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
                              Text(
                                item.product.name,
                                style: AppTextStyle.title,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Qty: ${item.quantity}',
                                style: AppTextStyle.body,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$${item.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColor.accent,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColor.border),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Total', style: AppTextStyle.title),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColor.accent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    title: 'Checkout',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Checkout flow ready to connect'),
                        ),
                      );
                    },
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
