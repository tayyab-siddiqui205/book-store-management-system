class ReviewModel {
  final String reviewId;
  final String userId;
  final String bookId;
  final String review;
  final double rating;

  ReviewModel({
    required this.reviewId,
    required this.userId,
    required this.bookId,
    required this.review,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json["reviewId"] ?? "",
      userId: json["userId"] ?? "",
      bookId: json["bookId"] ?? "",
      review: json["review"] ?? "",
      rating: (json["rating"] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "reviewId": reviewId,
      "userId": userId,
      "bookId": bookId,
      "review": review,
      "rating": rating,
    };
  }
}