import 'dart:io';

import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

ImageProvider<Object> accountProfileImageProvider(String imagePath) {
  if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
    return NetworkImage(imagePath);
  }

  return FileImage(File(imagePath));
}

class AccountInfoCard extends StatelessWidget {
  const AccountInfoCard({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

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
          ...children,
        ],
      ),
    );
  }
}

class AccountLabeledRow extends StatelessWidget {
  const AccountLabeledRow({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: AppTextStyle.body.copyWith(color: Colors.black54),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountEditableField extends StatelessWidget {
  const AccountEditableField({
    required this.label,
    required this.controller,
    this.keyboardType,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: AppTextStyle.body.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
          ),
        ],
      ),
    );
  }
}

class AccountActionRow extends StatelessWidget {
  const AccountActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0x1420B2AA),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColor.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyle.body),
                ],
              ),
            ),
            if (onTap != null)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.chevron_right),
              ),
          ],
        ),
      ),
    );
  }
}

class AccountSwitchRow extends StatelessWidget {
  const AccountSwitchRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyle.body),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColor.primary,
          ),
        ],
      ),
    );
  }
}

class AccountPaymentCardTile extends StatelessWidget {
  const AccountPaymentCardTile({
    required this.title,
    required this.subtitle,
    required this.color,
    super.key,
  });

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.credit_card, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountAddressTile extends StatelessWidget {
  const AccountAddressTile({
    required this.label,
    required this.address,
    required this.note,
    super.key,
  });

  final String label;
  final String address;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.place_outlined, color: AppColor.primary),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          Text(address, style: AppTextStyle.body),
          const SizedBox(height: 6),
          Text(
            note,
            style: AppTextStyle.body.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class AccountMyOrderItem {
  const AccountMyOrderItem({
    required this.id,
    required this.product,
    required this.status,
    required this.date,
    required this.amount,
    required this.actionLabel,
  });

  final String id;
  final ProductModel product;
  final String status;
  final String date;
  final String amount;
  final String actionLabel;
}

class AccountProfileData {
  const AccountProfileData({
    required this.name,
    required this.email,
    required this.phone,
    required this.memberSince,
    required this.imageUrl,
  });

  final String name;
  final String email;
  final String phone;
  final String memberSince;
  final String imageUrl;
}

class AccountDetailSectionData {
  const AccountDetailSectionData({
    required this.heading,
    required this.body,
  });

  final String heading;
  final String body;
}
