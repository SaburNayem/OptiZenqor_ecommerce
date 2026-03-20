import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/button_widget.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/product_details/product_details_controller/product_details_controller.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/cart_item_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({required this.product, super.key});

  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  bool _isFavorite = false;
  late final List<_ReviewItem> _reviews;

  @override
  void initState() {
    super.initState();
    _reviews = _buildInitialReviews(widget.product);
  }

  double get _averageRating {
    if (_reviews.isEmpty) {
      return widget.product.rating;
    }
    final double total = _reviews.fold<double>(
      0,
      (double sum, _ReviewItem review) => sum + review.rating,
    );
    return total / _reviews.length;
  }

  void _addReply(String reviewId, String message) {
    final int reviewIndex = _reviews.indexWhere(
      (_ReviewItem item) => item.id == reviewId,
    );
    if (reviewIndex == -1) {
      return;
    }
    _reviews[reviewIndex].replies.add(
      _ReplyItem(author: 'You', message: message),
    );
  }

  void _openReviewsSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => _ReviewsBottomSheet(
        productName: widget.product.name,
        averageRating: _averageRating,
        reviews: _reviews,
        onShareReview: (int rating, String message) {
          setState(() {
            _reviews.insert(
              0,
              _ReviewItem(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                author: 'You',
                rating: rating.toDouble(),
                review: message,
                timeAgo: 'Just now',
              ),
            );
          });
        },
        onReply: (String reviewId, String message) {
          setState(() {
            _addReply(reviewId, message);
          });
        },
      ),
    );
  }

  List<CartItemModel> get _checkoutItems => <CartItemModel>[
    CartItemModel(product: widget.product, quantity: _quantity),
  ];

  void _openCheckout() {
    Navigator.pushNamed(
      context,
      AppRoute.checkout,
      arguments: _checkoutItems,
    );
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.product.name} x$_quantity added to cart'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const ProductDetailsController controller = ProductDetailsController();
    final List<String> highlights = controller.getHighlights(widget.product);
    final double total = widget.product.price * _quantity;

    return Scaffold(
      appBar: AppCustomAppBar(
        title: 'Product Details',
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isFavorite
                        ? 'Added to favorites'
                        : 'Removed from favorites',
                  ),
                ),
              );
            },
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(widget.product.name, style: AppTextStyle.heading),
                ),
                Text(
                  '\$${widget.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColor.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(widget.product.categoryName, style: AppTextStyle.label),
            const SizedBox(height: 12),
            InkWell(
              onTap: _openReviewsSheet,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x1AFF6B35),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text('${_averageRating.toStringAsFixed(1)} ★'),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${_reviews.length} reviews',
                      style: AppTextStyle.body,
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: AppColor.primary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(widget.product.description, style: AppTextStyle.body),
            const SizedBox(height: 18),
            Row(
              children: <Widget>[
                const Text('Quantity', style: AppTextStyle.title),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: _quantity > 1
                      ? () {
                          setState(() {
                            _quantity--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$_quantity', style: AppTextStyle.title),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
                const Spacer(),
                Text(
                  'Total \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ...highlights.map(
              (String item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.check_circle,
                      color: AppColor.success,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(item, style: AppTextStyle.body)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 180),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColor.border),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Total',
                        style: AppTextStyle.body.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      title: 'Checkout',
                      onPressed: _openCheckout,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    child: AppButton(
                      title: 'Add Cart',
                      isOutlined: true,
                      onPressed: _addToCart,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      title: 'Buy',
                      onPressed: _openCheckout,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<_ReviewItem> _buildInitialReviews(ProductModel product) {
  return <_ReviewItem>[
    _ReviewItem(
      id: '${product.id}-1',
      author: 'Ariana',
      rating: 5,
      review:
          'The quality feels premium and it matched the product photos perfectly.',
      timeAgo: '2 days ago',
      replies: <_ReplyItem>[
        const _ReplyItem(
          author: 'Shop Support',
          message: 'Thanks for the lovely feedback.',
        ),
      ],
    ),
    _ReviewItem(
      id: '${product.id}-2',
      author: 'Nabil',
      rating: 4,
      review:
          'Really good ${product.categoryName.toLowerCase()} item. Delivery was quick and packaging was neat.',
      timeAgo: '5 days ago',
    ),
    _ReviewItem(
      id: '${product.id}-3',
      author: 'Sadia',
      rating: 5,
      review:
          'I would buy ${product.name} again. The finish and overall comfort are excellent.',
      timeAgo: '1 week ago',
    ),
  ];
}

class _ReviewItem {
  _ReviewItem({
    required this.id,
    required this.author,
    required this.rating,
    required this.review,
    required this.timeAgo,
    List<_ReplyItem>? replies,
  }) : replies = replies ?? <_ReplyItem>[];

  final String id;
  final String author;
  final double rating;
  final String review;
  final String timeAgo;
  final List<_ReplyItem> replies;
}

class _ReplyItem {
  const _ReplyItem({required this.author, required this.message});

  final String author;
  final String message;
}

class _ReviewsBottomSheet extends StatefulWidget {
  const _ReviewsBottomSheet({
    required this.productName,
    required this.averageRating,
    required this.reviews,
    required this.onShareReview,
    required this.onReply,
  });

  final String productName;
  final double averageRating;
  final List<_ReviewItem> reviews;
  final void Function(int rating, String message) onShareReview;
  final void Function(String reviewId, String message) onReply;

  @override
  State<_ReviewsBottomSheet> createState() => _ReviewsBottomSheetState();
}

class _ReviewsBottomSheetState extends State<_ReviewsBottomSheet> {
  final TextEditingController _reviewController = TextEditingController();
  final Map<String, TextEditingController> _replyControllers =
      <String, TextEditingController>{};
  int _selectedRating = 5;

  @override
  void didUpdateWidget(covariant _ReviewsBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    final Set<String> activeIds = widget.reviews
        .map((_ReviewItem review) => review.id)
        .toSet();
    final List<String> removedIds = _replyControllers.keys
        .where((String id) => !activeIds.contains(id))
        .toList();
    for (final String id in removedIds) {
      _replyControllers.remove(id)?.dispose();
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    for (final TextEditingController controller in _replyControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _replyControllerFor(String reviewId) {
    return _replyControllers.putIfAbsent(reviewId, TextEditingController.new);
  }

  void _handleShareReview() {
    final String message = _reviewController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write a review before sharing.'),
        ),
      );
      return;
    }

    widget.onShareReview(_selectedRating, message);
    _reviewController.clear();
    setState(() {
      _selectedRating = 5;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your rating and review have been shared.'),
      ),
    );
  }

  void _handleReply(_ReviewItem review) {
    final TextEditingController controller = _replyControllerFor(review.id);
    final String message = controller.text.trim();
    if (message.isEmpty) {
      return;
    }

    widget.onReply(review.id, message);
    controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.55,
      maxChildSize: 0.96,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColor.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 12),
                Container(
                  width: 56,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColor.border,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Ratings & Reviews',
                                  style: AppTextStyle.heading,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'See what people think and share your own experience.',
                                  style: AppTextStyle.body.copyWith(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0x1AFF6B35),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  widget.averageRating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: AppColor.accent,
                                  ),
                                ),
                                Text(
                                  '${widget.reviews.length} reviews',
                                  style: AppTextStyle.label,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColor.card,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColor.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Share your rating',
                              style: AppTextStyle.title,
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 6,
                              children: List<Widget>.generate(5, (int index) {
                                final int star = index + 1;
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedRating = star;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(999),
                                  child: Icon(
                                    star <= _selectedRating
                                        ? Icons.star_rounded
                                        : Icons.star_border_rounded,
                                    color: Colors.amber.shade700,
                                    size: 32,
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _reviewController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText:
                                    'Write your review about ${widget.productName}',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                    color: AppColor.border,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                    color: AppColor.border,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                    color: AppColor.primary,
                                    width: 1.4,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                title: 'Share Review',
                                onPressed: _handleShareReview,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'All reviews',
                        style: AppTextStyle.title,
                      ),
                      const SizedBox(height: 12),
                      ...widget.reviews.map((_ReviewItem review) {
                        final TextEditingController replyController =
                            _replyControllerFor(review.id);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: AppColor.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: const Color(0x1420B2AA),
                                      child: Text(
                                        review.author.characters.first
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: AppColor.primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            review.author,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            review.timeAgo,
                                            style: AppTextStyle.label.copyWith(
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: List<Widget>.generate(
                                        5,
                                        (int index) => Icon(
                                          index < review.rating.round()
                                              ? Icons.star_rounded
                                              : Icons.star_border_rounded,
                                          color: Colors.amber.shade700,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Text(review.review, style: AppTextStyle.body),
                                if (review.replies.isNotEmpty) ...<Widget>[
                                  const SizedBox(height: 14),
                                  ...review.replies.map(
                                    (_ReplyItem reply) => Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: AppColor.card,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${reply.author} replied',
                                            style: AppTextStyle.label,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            reply.message,
                                            style: AppTextStyle.body,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 14),
                                TextField(
                                  controller: replyController,
                                  textInputAction: TextInputAction.send,
                                  decoration: InputDecoration(
                                    hintText: 'Reply to ${review.author}',
                                    suffixIcon: TextButton(
                                      onPressed: () => _handleReply(review),
                                      child: const Text('Reply'),
                                    ),
                                    filled: true,
                                    fillColor: AppColor.card,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: AppColor.border,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: AppColor.border,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: AppColor.primary,
                                        width: 1.3,
                                      ),
                                    ),
                                  ),
                                  onSubmitted: (_) => _handleReply(review),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
