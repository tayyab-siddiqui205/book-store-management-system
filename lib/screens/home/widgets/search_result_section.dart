import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/book_provider.dart';
import 'book_card.dart';

class SearchResultSection extends StatelessWidget {
  const SearchResultSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, provider, child) {
        // ==========================
        // LOADING
        // ==========================

        if (provider.loading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // ==========================
        // NO BOOKS
        // ==========================

        if (provider.googleBooks.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text(
                "No books found.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }

        // ==========================
        // SEARCH RESULT
        // ==========================

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search Results (${provider.googleBooks.length})",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 360,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.googleBooks.length,
                  itemBuilder: (context, index) {
                    return BookCard(
                      book: provider.googleBooks[index],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}