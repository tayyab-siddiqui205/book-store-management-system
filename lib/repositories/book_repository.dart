import '../models/book_model.dart';
import '../services/google_books_service.dart';

class BookRepository {
  final GoogleBooksService _googleBooksService =
      GoogleBooksService();

  Future<List<BookModel>> searchBooks(
      String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    // ✅ Only Google Books for now
    return await _googleBooksService
        .searchBooks(query.trim());
  }
}