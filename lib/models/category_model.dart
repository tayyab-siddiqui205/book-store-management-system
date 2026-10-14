class CategoryModel {
  final String id;

  final String name;

  final String description;

  final String imageUrl;

  final int totalBooks;

  final bool active;

  final DateTime? createdAt;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.totalBooks = 0,
    this.active = true,
    this.createdAt,
  });

  factory CategoryModel.fromJson(
    Map<String, dynamic> json, {
    String? documentId,
  }) {
    return CategoryModel(
      id: documentId ?? json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      totalBooks: json["totalBooks"] ?? 0,
      active: json["active"] ?? true,
      createdAt: json["createdAt"] == null
          ? null
          : json["createdAt"].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "imageUrl": imageUrl,
      "totalBooks": totalBooks,
      "active": active,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    int? totalBooks,
    bool? active,
    DateTime? createdAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      totalBooks: totalBooks ?? this.totalBooks,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}