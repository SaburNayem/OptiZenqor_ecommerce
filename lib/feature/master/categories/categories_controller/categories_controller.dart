import 'package:optizenqor/feature/master/categories/categories_model/categories_model.dart';

class CategoriesController {
  const CategoriesController();

  CategoriesModel get data => const CategoriesModel(
    items: <String>[
      'Beauty & Personal Care',
      'Books & Stationary',
      'Electronics & Gadget',
      'Fashion & Clothing',
      'Groceries & Food',
      'Health & Wellness',
      'Home & Living',
      'Sports & Outdoor',
      'Toy & Babies',
    ],
  );
}
