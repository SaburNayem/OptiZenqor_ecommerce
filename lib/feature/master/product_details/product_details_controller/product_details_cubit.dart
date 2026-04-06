import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optizenqor/feature/master/product_details/product_details_controller/product_details_state.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(ProductModel product)
    : super(ProductDetailsState(reviews: buildInitialReviews(product)));

  void toggleFavorite() {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  void incrementQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decrementQuantity() {
    if (state.quantity <= 1) {
      return;
    }
    emit(state.copyWith(quantity: state.quantity - 1));
  }

  void shareReview(int rating, String message) {
    final List<ReviewItem> updatedReviews = <ReviewItem>[
      ReviewItem(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        author: 'You',
        rating: rating.toDouble(),
        review: message,
        timeAgo: 'Just now',
      ),
      ...state.reviews,
    ];
    emit(state.copyWith(reviews: updatedReviews));
  }

  void addReply(String reviewId, String message) {
    final List<ReviewItem> updatedReviews = state.reviews
        .map((ReviewItem review) {
          if (review.id != reviewId) {
            return review;
          }
          return review.copyWith(
            replies: <ReplyItem>[
              ...review.replies,
              ReplyItem(author: 'You', message: message),
            ],
          );
        })
        .toList();

    emit(state.copyWith(reviews: updatedReviews));
  }
}

List<ReviewItem> buildInitialReviews(ProductModel product) {
  return <ReviewItem>[
    ReviewItem(
      id: '${product.id}-1',
      author: 'Ariana',
      rating: 5,
      review:
          'The quality feels premium and it matched the product photos perfectly.',
      timeAgo: '2 days ago',
      replies: const <ReplyItem>[
        ReplyItem(
          author: 'Shop Support',
          message: 'Thanks for the lovely feedback.',
        ),
      ],
    ),
    ReviewItem(
      id: '${product.id}-2',
      author: 'Nabil',
      rating: 4,
      review:
          'Really good ${product.categoryName.toLowerCase()} item. Delivery was quick and packaging was neat.',
      timeAgo: '5 days ago',
    ),
    ReviewItem(
      id: '${product.id}-3',
      author: 'Sadia',
      rating: 5,
      review:
          'I would buy ${product.name} again. The finish and overall comfort are excellent.',
      timeAgo: '1 week ago',
    ),
  ];
}
