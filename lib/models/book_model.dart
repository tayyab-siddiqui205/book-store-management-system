class BookModel {
  final String id;

  final String title;
  final String author;
  final String category;
  final String description;

  final double price;
  final int stock;

  final String imageUrl;

  final double rating;

  // Google Books
  final int pages;
  final String language;
  final String publisher;
  final String publishedDate;
  final String pdf;
  final bool isApiBook;

  // Admin
  final bool featured;
  final bool bestSeller;
  final bool newArrival;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.rating,
    this.pages = 0,
    this.language = "",
    this.publisher = "",
    this.publishedDate = "",
    this.pdf = "",
    this.isApiBook = false,
    this.featured = false,
    this.bestSeller = false,
    this.newArrival = false,
  });

  factory BookModel.fromJson(
    Map<String, dynamic> json, {
    String? documentId,
  }) {
    return BookModel(
      id: documentId ?? json["id"] ?? "",

      title: json["title"] ?? "",

      author: json["author"] ?? "",

      category: json["category"] ?? "",

      description: json["description"] ?? "",

      price: (json["price"] ?? 0).toDouble(),

      stock: json["stock"] ?? 0,

      imageUrl: json["imageUrl"] ?? "",

      rating: (json["rating"] ?? 0).toDouble(),

      pages: json["pages"] ?? 0,

      language: json["language"] ?? "",

      publisher: json["publisher"] ?? "",

      publishedDate: json["publishedDate"] ?? "",

      pdf: json["pdf"] ?? "",

      isApiBook: json["isApiBook"] ?? false,

      featured: json["featured"] ?? false,

      bestSeller: json["bestSeller"] ?? false,

      newArrival: json["newArrival"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "author": author,
      "category": category,
      "description": description,
      "price": price,
      "stock": stock,
      "imageUrl": imageUrl,
      "rating": rating,
      "pages": pages,
      "language": language,
      "publisher": publisher,
      "publishedDate": publishedDate,
      "pdf": pdf,
      "isApiBook": isApiBook,
      "featured": featured,
      "bestSeller": bestSeller,
      "newArrival": newArrival,
    };
  }

  BookModel copyWith({
    String? id,
    String? title,
    String? author,
    String? category,
    String? description,
    double? price,
    int? stock,
    String? imageUrl,
    double? rating,
    int? pages,
    String? language,
    String? publisher,
    String? publishedDate,
    String? pdf,
    bool? isApiBook,
    bool? featured,
    bool? bestSeller,
    bool? newArrival,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      pages: pages ?? this.pages,
      language: language ?? this.language,
      publisher: publisher ?? this.publisher,
      publishedDate: publishedDate ?? this.publishedDate,
      pdf: pdf ?? this.pdf,
      isApiBook: isApiBook ?? this.isApiBook,
      featured: featured ?? this.featured,
      bestSeller: bestSeller ?? this.bestSeller,
      newArrival: newArrival ?? this.newArrival,
    );
  }
}