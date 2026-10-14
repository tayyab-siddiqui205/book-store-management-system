class OrderModel {
  final String orderId;
  final String userId;
  final double total;
  final String status;
  final String paymentMethod;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.total,
    required this.status,
    required this.paymentMethod,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json["orderId"] ?? "",
      userId: json["userId"] ?? "",
      total: (json["total"] ?? 0).toDouble(),
      status: json["status"] ?? "Pending",
      paymentMethod: json["paymentMethod"] ?? "COD",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "userId": userId,
      "total": total,
      "status": status,
      "paymentMethod": paymentMethod,
    };
  }
}