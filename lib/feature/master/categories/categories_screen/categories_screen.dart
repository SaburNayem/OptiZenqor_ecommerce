import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/feature/master/categories/categories_controller/categories_controller.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = const CategoriesController().data;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Categories'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        itemCount: data.items.length,
        itemBuilder: (BuildContext context, int index) {
          final String item = data.items[index];

          return Card(
            color: AppColor.primary,
            elevation: 8,
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              height: 64,
              child: ListTile(
                title: Text(item, style: const TextStyle(color: Colors.white)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$item page is ready to add next')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
