import 'package:flutter/material.dart';

class AccountModel {
  const AccountModel({
    required this.name,
    required this.email,
    required this.actions,
  });

  final String name;
  final String email;
  final List<AccountActionModel> actions;
}

class AccountActionModel {
  const AccountActionModel({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}
