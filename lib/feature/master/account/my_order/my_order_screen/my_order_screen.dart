import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/account/account_shared/account_shared.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/http_mathod/network_service/catalog_service.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  static const List<String> _statuses = <String>[
    'To Pay',
    'To Ship',
    'To Receive',
    'To Review',
    'To Return',
    'Cancellation',
  ];

  late final List<AccountMyOrderItem> _orders;
  String _selectedStatus = _statuses.first;

  @override
  void initState() {
    super.initState();
    final List<ProductModel> products = const CatalogService().getProducts();
    _orders = <AccountMyOrderItem>[
      AccountMyOrderItem(
        id: 'mo-1',
        product: products[1],
        status: 'To Pay',
        date: 'March 20, 2026',
        amount: '\$${products[1].price.toStringAsFixed(2)}',
        actionLabel: 'Pay Now',
      ),
      AccountMyOrderItem(
        id: 'mo-2',
        product: products[3],
        status: 'To Ship',
        date: 'March 18, 2026',
        amount: '\$${products[3].price.toStringAsFixed(2)}',
        actionLabel: 'Track Packing',
      ),
      AccountMyOrderItem(
        id: 'mo-3',
        product: products[4],
        status: 'To Receive',
        date: 'March 17, 2026',
        amount: '\$${products[4].price.toStringAsFixed(2)}',
        actionLabel: 'Track Delivery',
      ),
      AccountMyOrderItem(
        id: 'mo-4',
        product: products[6],
        status: 'To Review',
        date: 'March 14, 2026',
        amount: '\$${products[6].price.toStringAsFixed(2)}',
        actionLabel: 'Write Review',
      ),
      AccountMyOrderItem(
        id: 'mo-5',
        product: products[5],
        status: 'To Return',
        date: 'March 10, 2026',
        amount: '\$${products[5].price.toStringAsFixed(2)}',
        actionLabel: 'Request Return',
      ),
      AccountMyOrderItem(
        id: 'mo-6',
        product: products[0],
        status: 'Cancellation',
        date: 'March 9, 2026',
        amount: '\$${products[0].price.toStringAsFixed(2)}',
        actionLabel: 'View Details',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<AccountMyOrderItem> filteredOrders = _orders
        .where((AccountMyOrderItem order) => order.status == _selectedStatus)
        .toList();

    return Scaffold(
      appBar: const AppCustomAppBar(title: 'My Order'),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 66,
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
              scrollDirection: Axis.horizontal,
              itemCount: _statuses.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 10),
              itemBuilder: (BuildContext context, int index) {
                final String status = _statuses[index];
                final bool isSelected = status == _selectedStatus;
                return ChoiceChip(
                  label: Text(status),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedStatus = status;
                    });
                  },
                  selectedColor: AppColor.primary,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColor.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  side: const BorderSide(color: AppColor.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'No orders available in $_selectedStatus.',
                        style: AppTextStyle.body,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    itemCount: filteredOrders.length,
                    itemBuilder: (BuildContext context, int index) {
                      final AccountMyOrderItem order = filteredOrders[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: AppColor.border),
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
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      order.status,
                                      style: const TextStyle(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      order.date,
                                      style: AppTextStyle.body.copyWith(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.network(
                                        order.product.imageUrl,
                                        width: 86,
                                        height: 86,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            order.product.categoryName,
                                            style: AppTextStyle.body.copyWith(
                                              color: Colors.black54,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            order.amount,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                              color: AppColor.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Order ID: ${order.id}',
                                      style: AppTextStyle.body.copyWith(
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoute.productDetails,
                                          arguments: order.product,
                                        );
                                      },
                                      child: Text(order.actionLabel),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
