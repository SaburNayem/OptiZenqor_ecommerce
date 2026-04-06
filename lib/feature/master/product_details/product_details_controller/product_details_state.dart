import 'package:flutter/material.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

@immutable
class ReplyItem {
  const ReplyItem({required this.author, required this.message});

  final String author;
  final String message;
}

@immutable
class ReviewItem {
  const ReviewItem({
    required this.id,
    required this.author,
    required this.rating,
    required this.review,
    required this.timeAgo,
    this.replies = const <ReplyItem>[],
  });

  final String id;
  final String author;
  final double rating;
  final String review;
  final String timeAgo;
  final List<ReplyItem> replies;

  ReviewItem copyWith({
    String? id,
    String? author,
    double? rating,
    String? review,
    String? timeAgo,
    List<ReplyItem>? replies,
  }) {
    return ReviewItem(
      id: id ?? this.id,
      author: author ?? this.author,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      timeAgo: timeAgo ?? this.timeAgo,
      replies: replies ?? this.replies,
    );
  }
}

@immutable
class ProductDetailsState {
  const ProductDetailsState({
    this.quantity = 1,
    this.isFavorite = false,
    this.reviews = const <ReviewItem>[],
  });

  final int quantity;
  final bool isFavorite;
  final List<ReviewItem> reviews;

  double averageRating(ProductModel product) {
    if (reviews.isEmpty) {
      return product.rating;
    }
    final double total = reviews.fold<double>(
      0,
      (double sum, ReviewItem review) => sum + review.rating,
    );
    return total / reviews.length;
  }

  ProductDetailsState copyWith({
    int? quantity,
    bool? isFavorite,
    List<ReviewItem>? reviews,
  }) {
    return ProductDetailsState(
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
      reviews: reviews ?? this.reviews,
    );
  }
}
