import 'package:optizenqor/feature/master/drawer/drawer_model/drawer_model.dart';

class MasterDrawerController {
  const MasterDrawerController();

  DrawerModel get data => const DrawerModel(
    name: 'Optizenqor Store',
    email: 'support@yourapp.com',
    items: <String>[
      'Order History',
      'Support',
      'Review',
      'Help',
      'About Us',
      'Logout',
    ],
  );
}
