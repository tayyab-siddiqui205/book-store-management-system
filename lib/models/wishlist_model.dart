class WishlistModel {
  final String wishlistId;
  final String userId;
  final String bookId;

  WishlistModel({
    required this.wishlistId,
    required this.userId,
    required this.bookId,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      wishlistId: json["wishlistId"] ?? "",
      userId: json["userId"] ?? "",
      bookId: json["bookId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "wishlistId": wishlistId,
      "userId": userId,
      "bookId": bookId,
    };
  }
}