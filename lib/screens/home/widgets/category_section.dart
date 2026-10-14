import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/book_model.dart';
import '../../../providers/book_provider.dart';
import '../../../services/book_service.dart';
import 'book_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: BookService().getBooksByCategory(
        provider.selectedCategory,
      ),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final books = snapshot.data!.docs;

        return SizedBox(
          height: 360,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (_, index) {
              final book = BookModel.fromJson(
                books[index].data()
                    as Map<String, dynamic>,
              );

              return BookCard(book: book);
            },
          ),
        );
      },
    );
  }
}