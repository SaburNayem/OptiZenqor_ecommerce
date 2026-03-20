import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/button_widget.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/cart_item_model.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({required this.items, super.key});

  final List<CartItemModel> items;

  double get _subtotal {
    return items.fold<double>(
      0,
      (double total, CartItemModel item) =>
          total + (item.product.price * item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double subtotal = _subtotal;
    final double deliveryFee = items.isEmpty ? 0 : 5;
    final double total = subtotal + deliveryFee;

    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Checkout'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        children: <Widget>[
          _CheckoutSection(
            title: 'Delivery Address',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Shob Bazaar',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 6),
                Text(
                  'House 12, Road 5, Mirpur 1, Dhaka',
                  style: AppTextStyle.body,
                ),
                SizedBox(height: 4),
                Text(
                  '+880 1700 000000',
                  style: AppTextStyle.body,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _CheckoutSection(
            title: 'Order Items',
            child: Column(
              children: items.map((CartItemModel item) {
                final double lineTotal = item.product.price * item.quantity;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item.product.imageUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Qty: ${item.quantity}',
                              style: AppTextStyle.body,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${lineTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColor.accent,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          _CheckoutSection(
            title: 'Payment Summary',
            child: Column(
              children: <Widget>[
                _SummaryRow(label: 'Subtotal', value: subtotal),
                _SummaryRow(label: 'Delivery Fee', value: deliveryFee),
                const Divider(height: 24),
                _SummaryRow(
                  label: 'Total',
                  value: total,
                  isEmphasis: true,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: AppButton(
          title: 'Place Order',
          onPressed: items.isEmpty
              ? null
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Order placed successfully.'),
                    ),
                  );
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoute.mainShell,
                    (Route<dynamic> route) => false,
                    arguments: 0,
                  );
                },
        ),
      ),
    );
  }
}

class _CheckoutSection extends StatelessWidget {
  const _CheckoutSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColor.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: AppTextStyle.title),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isEmphasis = false,
  });

  final String label;
  final double value;
  final bool isEmphasis;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = isEmphasis
        ? const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColor.primary,
          )
        : AppTextStyle.body;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label, style: style),
          Text('\$${value.toStringAsFixed(2)}', style: style),
        ],
      ),
    );
  }
}
