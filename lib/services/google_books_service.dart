import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class GoogleBooksService {
  // ✅ Google Books API
  static const String _googleBaseUrl =
      "https://www.googleapis.com/books/v1/volumes";

  static const String _apiKey =
      "AIzaSyAHcBCxMRiTOEZlFMaCAu8JCJjB49rrxyA";

  Future<List<BookModel>> searchBooks(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
          "$_googleBaseUrl?q=${Uri.encodeComponent(query)}&maxResults=20&key=$_apiKey",
        ),
      );

      if (response.statusCode != 200) {
        print("API Error: ${response.statusCode}");
        return [];
      }

      final data = jsonDecode(response.body);

      if (data["items"] == null) {
        return [];
      }

      return (data["items"] as List)
          .map((item) =>
              _fromGoogle(item as Map<String, dynamic>))
          .toList();

    } catch (e) {
      print("Hybrid API Error: $e");
      return [];
    }
  }

  BookModel _fromGoogle(Map<String, dynamic> json) {
    final volumeInfo =
        json["volumeInfo"] as Map<String, dynamic>? ?? {};

    final authorsList =
        volumeInfo["authors"] as List?;

    final categoriesList =
        volumeInfo["categories"] as List?;

    String image = "";

    // ✅ 1️⃣ Try OpenLibrary via ISBN
    if (volumeInfo["industryIdentifiers"] != null) {
      List identifiers =
          volumeInfo["industryIdentifiers"];

      for (var id in identifiers) {
        if (id["type"] == "ISBN_13" ||
            id["type"] == "ISBN_10") {
          String isbn = id["identifier"];

          image =
              "https://covers.openlibrary.org/b/isbn/$isbn-L.jpg";

          break;
        }
      }
    }

    // ✅ 2️⃣ If no ISBN cover → Try Google thumbnail
    if (image.isEmpty &&
        volumeInfo["imageLinks"] != null) {
      final imageLinks =
          volumeInfo["imageLinks"];

      image =
          imageLinks["thumbnail"] ??
          imageLinks["smallThumbnail"] ??
          "";

      if (image.isNotEmpty) {
        image =
            image.replaceAll("http://", "https://");
      }
    }

    return BookModel(
      id: json["id"] ?? "",
      title: volumeInfo["title"] ?? "No Title",
      author: authorsList != null &&
              authorsList.isNotEmpty
          ? authorsList.join(", ")
          : "Unknown",
      category: categoriesList != null &&
              categoriesList.isNotEmpty
          ? categoriesList.first.toString()
          : "General",
      description:
          volumeInfo["description"] ?? "",
      price: 0,
      stock: 0,
      imageUrl: image,
      rating: volumeInfo["averageRating"] != null
          ? (volumeInfo["averageRating"] as num)
              .toDouble()
          : 0.0,
      pages: volumeInfo["pageCount"] ?? 0,
      language: volumeInfo["language"] ?? "",
      publisher: volumeInfo["publisher"] ?? "",
      publishedDate:
          volumeInfo["publishedDate"] ?? "",
      pdf: "",
      isApiBook: true,
    );
  }
}