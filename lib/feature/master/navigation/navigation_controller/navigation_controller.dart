import 'package:flutter/material.dart';
import 'package:optizenqor/feature/master/account/account_screen/account_screen.dart';
import 'package:optizenqor/feature/master/cart/cart_screen/cart_screen.dart';
import 'package:optizenqor/feature/master/favorite/favorite_screen/favorite_screen.dart';
import 'package:optizenqor/feature/master/home/home_screen/home_screen.dart';
import 'package:optizenqor/feature/master/navigation/navigation_model/navigation_item_model.dart';
import 'package:optizenqor/feature/master/shop/shop_screen/shop_screen.dart';

class NavigationController {
  const NavigationController();

  List<NavigationItemModel> get items => const <NavigationItemModel>[
    NavigationItemModel(label: 'Home', icon: Icons.home_rounded),
    NavigationItemModel(label: 'Shop', icon: Icons.storefront_rounded),
    NavigationItemModel(label: 'Favorite', icon: Icons.favorite_rounded),
    NavigationItemModel(label: 'Cart', icon: Icons.shopping_cart_rounded),
    NavigationItemModel(label: 'Account', icon: Icons.person_rounded),
  ];

  List<Widget> get pages => const <Widget>[
    HomeScreen(),
    ShopScreen(),
    FavoriteScreen(),
    CartScreen(),
    AccountScreen(),
  ];
}
