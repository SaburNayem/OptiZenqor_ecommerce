import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/account/account_controller/account_controller.dart';
import 'package:optizenqor/feature/master/account/account_shared/account_shared.dart';
import 'package:optizenqor/feature/master/account/delivery_address/delivery_address_screen/delivery_address_screen.dart';
import 'package:optizenqor/feature/master/account/my_order/my_order_screen/my_order_screen.dart';
import 'package:optizenqor/feature/master/account/personal_details/personal_details_screen/personal_details_screen.dart';
import 'package:optizenqor/feature/master/account/settings/settings_screen/settings_screen.dart';
import 'package:optizenqor/feature/master/account/account_model/account_model.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  void _handleAction(BuildContext context, AccountActionModel action) {
    switch (action.title) {
      case 'Personal Details':
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const PersonalDetailsScreen(),
          ),
        );
        return;
      case 'My Order':
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const MyOrderScreen(),
          ),
        );
        return;
      case 'Delivery Address':
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const DeliveryAddressScreen(),
          ),
        );
        return;
      case 'Order History':
        Navigator.pushNamed(
          context,
          AppRoute.drawerPage,
          arguments: 'Order History',
        );
        return;
      case 'Settings':
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const SettingsScreen(),
          ),
        );
        return;
      default:
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                _AccountActionDetailsScreen(action: action),
          ),
        );
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AccountModel data = AccountController().data;

    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Account'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColor.border),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.primary, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=12',
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data.name, style: AppTextStyle.title),
                    const SizedBox(height: 4),
                    Text(data.email, style: AppTextStyle.body),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ...data.actions.map(
            (AccountActionModel action) => InkWell(
              onTap: () => _handleAction(context, action),
              borderRadius: BorderRadius.circular(18),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColor.border),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0x1420B2AA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(action.icon, color: AppColor.primary),
                  ),
                  title: Text(action.title),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(action.subtitle, style: AppTextStyle.body),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountActionDetailsScreen extends StatelessWidget {
  const _AccountActionDetailsScreen({required this.action});

  final AccountActionModel action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(title: action.title),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: _buildSections(),
      ),
    );
  }

  List<Widget> _buildSections() {
    switch (action.title) {
      case 'Payment Method':
        return <Widget>[
          AccountInfoCard(
            title: 'Saved Cards',
            children: const <Widget>[
              AccountPaymentCardTile(
                title: 'Visa ending in 2048',
                subtitle: 'Default payment method',
                color: Color(0xFF0D47A1),
              ),
              AccountPaymentCardTile(
                title: 'Mastercard ending in 8891',
                subtitle: 'Expires 11/28',
                color: Color(0xFF00695C),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const AccountInfoCard(
            title: 'Billing',
            children: <Widget>[
              AccountLabeledRow(label: 'Billing name', value: 'Shob Bazaar'),
              AccountLabeledRow(
                label: 'Billing email',
                value: 'support@yourapp.com',
              ),
              AccountLabeledRow(label: 'Currency', value: 'USD'),
            ],
          ),
        ];
      case 'Pickup Point':
        return <Widget>[
          const AccountInfoCard(
            title: 'Available Pickup Points',
            children: <Widget>[
              AccountAddressTile(
                label: 'Mirpur Hub',
                address: 'Road 10, Mirpur 1, Dhaka',
                note: 'Open daily from 9 AM - 9 PM',
              ),
              AccountAddressTile(
                label: 'Banani Point',
                address: 'Block C, Banani, Dhaka',
                note: 'Fast pickup for small and medium parcels',
              ),
              AccountAddressTile(
                label: 'Uttara Collection Center',
                address: 'Sector 7, Uttara, Dhaka',
                note: 'Weekend pickup available',
              ),
            ],
          ),
        ];
      default:
        return <Widget>[
          AccountInfoCard(
            title: action.title,
            children: <Widget>[Text(action.subtitle, style: AppTextStyle.body)],
          ),
        ];
    }
  }
}
