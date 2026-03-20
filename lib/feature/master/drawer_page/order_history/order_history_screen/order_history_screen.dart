import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/http_mathod/network_service/catalog_service.dart';

class OrderHistoryBody extends StatelessWidget {
  const OrderHistoryBody({super.key});

  List<OrderHistoryItem> _orders() {
    final List<ProductModel> products = const CatalogService().getProducts();
    return <OrderHistoryItem>[
      OrderHistoryItem(
        orderId: '#123456',
        date: 'March 8, 2025',
        amount: '\$${products[0].price.toStringAsFixed(2)}',
        status: 'Delivered',
        product: products[0],
      ),
      OrderHistoryItem(
        orderId: '#123457',
        date: 'March 5, 2025',
        amount: '\$${products[4].price.toStringAsFixed(2)}',
        status: 'Cancelled',
        product: products[4],
      ),
      OrderHistoryItem(
        orderId: '#123458',
        date: 'March 1, 2025',
        amount: '\$${products[6].price.toStringAsFixed(2)}',
        status: 'Processing',
        product: products[6],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<OrderHistoryItem> orders = _orders();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildOrderSection(context, orders, 'Processing', Colors.orange),
          _buildOrderSection(context, orders, 'Delivered', Colors.green),
          _buildOrderSection(context, orders, 'Cancelled', Colors.red),
        ],
      ),
    );
  }

  Widget _buildOrderSection(
    BuildContext context,
    List<OrderHistoryItem> orders,
    String status,
    Color color,
  ) {
    final List<OrderHistoryItem> filteredOrders = orders
        .where((OrderHistoryItem order) => order.status == status)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        ...filteredOrders.map(
          (OrderHistoryItem order) => Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColor.border),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 14,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.productDetails,
                  arguments: order.product,
                );
              },
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        order.product.imageUrl,
                        width: 84,
                        height: 84,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            order.product.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            order.orderId,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            order.date,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.14),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  order.status,
                                  style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                order.amount,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderHistoryItem {
  const OrderHistoryItem({
    required this.orderId,
    required this.date,
    required this.amount,
    required this.status,
    required this.product,
  });

  final String orderId;
  final String date;
  final String amount;
  final String status;
  final ProductModel product;
}
