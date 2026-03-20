import 'package:optizenqor/feature/master/product_details/product_details_model/category_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class CatalogService {
  const CatalogService();

  List<CategoryModel> getCategories() {
    return const <CategoryModel>[
      CategoryModel(
        id: 'fashion',
        name: 'Fashion',
        icon: 'checkroom',
        bannerTitle: 'Street style, elevated',
      ),
      CategoryModel(
        id: 'electronics',
        name: 'Electronics',
        icon: 'devices',
        bannerTitle: 'Daily tech essentials',
      ),
      CategoryModel(
        id: 'beauty',
        name: 'Beauty',
        icon: 'spa',
        bannerTitle: 'Skincare picks that travel well',
      ),
      CategoryModel(
        id: 'home',
        name: 'Home',
        icon: 'chair_alt',
        bannerTitle: 'Warm home upgrades',
      ),
    ];
  }

  List<ProductModel> getProducts() {
    return const <ProductModel>[
      ProductModel(
        id: 'p1',
        name: 'Aero Knit Jacket',
        categoryId: 'fashion',
        categoryName: 'Fashion',
        price: 86,
        rating: 4.8,
        imageUrl:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=900&q=80',
        description:
            'Lightweight layering piece for daily city wear with a tailored finish.',
      ),
      ProductModel(
        id: 'p2',
        name: 'Urban Noise Headphones',
        categoryId: 'electronics',
        categoryName: 'Electronics',
        price: 149,
        rating: 4.7,
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=900&q=80',
        description:
            'Balanced sound, soft ear cushions, and long battery life for all-day use.',
      ),
      ProductModel(
        id: 'p3',
        name: 'Glow Ritual Set',
        categoryId: 'beauty',
        categoryName: 'Beauty',
        price: 42,
        rating: 4.6,
        imageUrl:
            'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?auto=format&fit=crop&w=900&q=80',
        description:
            'Clean skincare trio focused on hydration, repair, and a healthy finish.',
      ),
      ProductModel(
        id: 'p4',
        name: 'Nordic Accent Chair',
        categoryId: 'home',
        categoryName: 'Home',
        price: 210,
        rating: 4.9,
        imageUrl:
            'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=900&q=80',
        description:
            'Minimal lounge chair with soft texture and strong statement silhouette.',
      ),
      ProductModel(
        id: 'p5',
        name: 'Transit Sneaker',
        categoryId: 'fashion',
        categoryName: 'Fashion',
        price: 74,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=900&q=80',
        description:
            'Everyday sneaker designed for comfort, movement, and a clean wardrobe fit.',
      ),
      ProductModel(
        id: 'p6',
        name: 'Studio Lamp',
        categoryId: 'home',
        categoryName: 'Home',
        price: 68,
        rating: 4.4,
        imageUrl:
            'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&w=900&q=80',
        description:
            'Compact table lamp with warm light and sculpted matte finish.',
      ),
    ];
  }

  List<ProductModel> getFeaturedProducts() {
    return getProducts().take(4).toList();
  }

  List<ProductModel> getProductsByCategory(String categoryId) {
    return getProducts()
        .where((ProductModel product) => product.categoryId == categoryId)
        .toList();
  }
}
