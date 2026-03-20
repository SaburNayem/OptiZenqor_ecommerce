import 'package:optizenqor/feature/master/account/account_model/account_model.dart';

class AccountController {
  const AccountController();

  AccountModel get data => const AccountModel(
    name: 'Nayem Sabur',
    email: 'nayem@example.com',
    actions: <String>[
      'My Orders',
      'Delivery Address',
      'Payment Method',
      'Settings',
      'Support',
    ],
  );
}
