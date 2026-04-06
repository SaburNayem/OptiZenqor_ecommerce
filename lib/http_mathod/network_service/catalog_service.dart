import 'package:optizenqor/feature/master/product_details/product_details_model/category_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class CatalogService {
  const CatalogService();

  List<CategoryModel> getCategories() {
    return const <CategoryModel>[
      CategoryModel(
        id: 'beauty_personal_care',
        name: 'Beauty & Personal Care',
        icon: 'spa',
        bannerTitle: 'Beauty & Personal Care',
      ),
      CategoryModel(
        id: 'books_stationary',
        name: 'Books & Stationary',
        icon: 'menu_book',
        bannerTitle: 'Books & Stationary',
      ),
      CategoryModel(
        id: 'electronics_gadget',
        name: 'Electronics & Gadget',
        icon: 'devices',
        bannerTitle: 'Electronics & Gadget',
      ),
      CategoryModel(
        id: 'fashion_clothing',
        name: 'Fashion & Clothing',
        icon: 'checkroom',
        bannerTitle: 'Fashion & Clothing',
      ),
      CategoryModel(
        id: 'groceries_food',
        name: 'Groceries & Food',
        icon: 'fastfood',
        bannerTitle: 'Groceries & Food',
      ),
      CategoryModel(
        id: 'health_wellness',
        name: 'Health & Wealth',
        icon: 'health_and_safety',
        bannerTitle: 'Health & Wellness',
      ),
      CategoryModel(
        id: 'home_living',
        name: 'Home & Living',
        icon: 'chair_alt',
        bannerTitle: 'Home & Living',
      ),
      CategoryModel(
        id: 'sports_outdoor',
        name: 'Sports & Outdoor',
        icon: 'sports_basketball',
        bannerTitle: 'Sports & Outdoor',
      ),
      CategoryModel(
        id: 'toy_babies_product',
        name: 'Toy & Babies',
        icon: 'toys',
        bannerTitle: 'Toy & Babies Product',
      ),
    ];
  }

  List<ProductModel> getProducts() {
    return const <ProductModel>[
      ProductModel(
        id: 'p1',
        name: 'Product 1',
        categoryId: 'featured',
        categoryName: 'Featured',
        price: 20,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?auto=format&fit=crop&w=900&q=80',
        description: 'Featured product from the Optizenqor Store shop section.',
      ),
      ProductModel(
        id: 'p2',
        name: 'Product 2',
        categoryId: 'featured',
        categoryName: 'Featured',
        price: 25,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=900&q=80',
        description: 'Featured product from the Optizenqor Store shop section.',
      ),
      ProductModel(
        id: 'p3',
        name: 'Product 3',
        categoryId: 'featured',
        categoryName: 'Featured',
        price: 30,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=900&q=80',
        description: 'Featured product from the Optizenqor Store shop section.',
      ),
      ProductModel(
        id: 'p4',
        name: 'Face Cleanser',
        categoryId: 'beauty_personal_care',
        categoryName: 'Beauty & Personal Care',
        price: 15,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1556228578-8c89e6adf883?auto=format&fit=crop&w=900&q=80',
        description:
            'Category product reused across multiple category pages in the repo.',
      ),
      ProductModel(
        id: 'p5',
        name: 'Shampoo',
        categoryId: 'beauty_personal_care',
        categoryName: 'Beauty & Personal Care',
        price: 20,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1522337660859-02fbefca4702?auto=format&fit=crop&w=900&q=80',
        description:
            'Category product reused across multiple category pages in the repo.',
      ),
      ProductModel(
        id: 'p6',
        name: 'Lipstick',
        categoryId: 'beauty_personal_care',
        categoryName: 'Beauty & Personal Care',
        price: 10,
        rating: 4.4,
        imageUrl:
            'https://images.unsplash.com/photo-1586495777744-4413f21062fa?auto=format&fit=crop&w=900&q=80',
        description:
            'Category product reused across multiple category pages in the repo.',
      ),
      ProductModel(
        id: 'p7',
        name: 'Perfume',
        categoryId: 'beauty_personal_care',
        categoryName: 'Beauty & Personal Care',
        price: 35,
        rating: 4.4,
        imageUrl:
            'https://images.unsplash.com/photo-1541643600914-78b084683601?auto=format&fit=crop&w=900&q=80',
        description:
            'Category product reused across multiple category pages in the repo.',
      ),
    ];
  }

  List<ProductModel> getFeaturedProducts() {
    return getProducts().take(3).toList();
  }

  List<ProductModel> getProductsByCategory(String categoryId) {
    if (categoryId == 'featured') {
      return getFeaturedProducts();
    }

    CategoryModel? category;
    for (final CategoryModel item in getCategories()) {
      if (item.id == categoryId) {
        category = item;
        break;
      }
    }

    return const <ProductModel>[
      ProductModel(
        id: 'cp1',
        name: 'Face Cleanser',
        categoryId: 'category',
        categoryName: 'Category',
        price: 15,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1556228578-8c89e6adf883?auto=format&fit=crop&w=900&q=80',
        description: 'Category product from the original repo.',
      ),
      ProductModel(
        id: 'cp2',
        name: 'Shampoo',
        categoryId: 'category',
        categoryName: 'Category',
        price: 20,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1522337660859-02fbefca4702?auto=format&fit=crop&w=900&q=80',
        description: 'Category product from the original repo.',
      ),
      ProductModel(
        id: 'cp3',
        name: 'Lipstick',
        categoryId: 'category',
        categoryName: 'Category',
        price: 10,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1586495777744-4413f21062fa?auto=format&fit=crop&w=900&q=80',
        description: 'Category product from the original repo.',
      ),
      ProductModel(
        id: 'cp4',
        name: 'Perfume',
        categoryId: 'category',
        categoryName: 'Category',
        price: 35,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1541643600914-78b084683601?auto=format&fit=crop&w=900&q=80',
        description: 'Category product from the original repo.',
      ),
    ].map((ProductModel product) {
      return ProductModel(
        id: '${categoryId}_${product.id}',
        name: product.name,
        categoryId: categoryId,
        categoryName: category?.bannerTitle ?? 'Category',
        price: product.price,
        rating: product.rating,
        imageUrl: product.imageUrl,
        description: product.description,
      );
    }).toList();
  }
}
