import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book_model.dart';
import 'firestore_service.dart';

class BookService {
  final FirestoreService _firestoreService = FirestoreService();

  FirebaseFirestore get firestore => _firestoreService.firestore;

  CollectionReference<Map<String, dynamic>> get booksRef =>
      firestore.collection("books");

  //====================================================
  // ADD BOOK
  //====================================================

  Future<void> addBook(BookModel book) async {
    try {
      await booksRef.doc(book.id).set({
        ...book.toJson(),
        "createdAt": FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? "Unable to add book.");
    } catch (e) {
      throw Exception("Something went wrong while adding the book.");
    }
  }

  //====================================================
  // UPDATE BOOK
  //====================================================

  Future<void> updateBook(BookModel book) async {
    try {
      await booksRef.doc(book.id).update(book.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? "Unable to update book.");
    } catch (e) {
      throw Exception("Something went wrong while updating the book.");
    }
  }

  //====================================================
  // DELETE BOOK
  //====================================================

  Future<void> deleteBook(String id) async {
    try {
      await booksRef.doc(id).delete();
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? "Unable to delete book.");
    } catch (e) {
      throw Exception("Something went wrong while deleting the book.");
    }
  }

  //====================================================
  // GET ALL BOOKS
  //====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>> getBooks() {
    return booksRef
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  //====================================================
  // FEATURED BOOKS
  //====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>> getFeaturedBooks() {
    return booksRef
        .where("featured", isEqualTo: true)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  //====================================================
  // BEST SELLER BOOKS
  //====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>> getBestSellingBooks() {
    return booksRef
        .where("bestSeller", isEqualTo: true)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  //====================================================
  // NEW ARRIVAL BOOKS
  //====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>> getNewArrivalBooks() {
    return booksRef
        .where("newArrival", isEqualTo: true)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  //====================================================
  // CATEGORY
  //====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>> getBooksByCategory(
    String category,
  ) {
    if (category == "All") {
      return getBooks();
    }

    return booksRef
        .where("category", isEqualTo: category)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  //====================================================
  // SEARCH BOOKS
  //====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>> searchBooks(
    String keyword,
  ) {
    if (keyword.trim().isEmpty) {
      return getBooks();
    }

    return booksRef
        .orderBy("title")
        .startAt([keyword])
        .endAt(["$keyword\uf8ff"])
        .snapshots();
  }

  //====================================================
  // GET SINGLE BOOK
  //====================================================

  Future<DocumentSnapshot<Map<String, dynamic>>> getBookById(
    String id,
  ) async {
    return await booksRef.doc(id).get();
  }

  //====================================================
  // CHECK BOOK EXISTS
  //====================================================

  Future<bool> bookExists(String id) async {
    final doc = await booksRef.doc(id).get();
    return doc.exists;
  }

  //====================================================
  // TOTAL BOOKS
  //====================================================

  Future<int> getTotalBooks() async {
    final snapshot = await booksRef.get();
    return snapshot.docs.length;
  }
}