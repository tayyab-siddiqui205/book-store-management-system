class CartModel {
  final String cartId;
  final String userId;
  final String bookId;
  final int quantity;

  CartModel({
    required this.cartId,
    required this.userId,
    required this.bookId,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: json["cartId"] ?? "",
      userId: json["userId"] ?? "",
      bookId: json["bookId"] ?? "",
      quantity: json["quantity"] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cartId": cartId,
      "userId": userId,
      "bookId": bookId,
      "quantity": quantity,
    };
  }
}