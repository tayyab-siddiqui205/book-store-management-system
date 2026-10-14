import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../models/book_model.dart';
import '../../../services/book_service.dart';
import 'premium_book_card.dart';

class BookSection extends StatelessWidget {
  const BookSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Best Selling",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "View All",
                style: TextStyle(color: Color(0xff6C4EF6), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ==================== TESTING STREAM ====================
          SizedBox(
            height: 420,
            child: StreamBuilder<QuerySnapshot>(
              stream: BookService().getBooks(),   // Sab books pehle la raha hai
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Firebase mein koi book nahi hai"));
                }

                final allDocs = snapshot.data!.docs;

                // Best Seller filter
                final bestSellerDocs = allDocs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return data['bestSeller'] == true;
                }).toList();

                print("Total Books: ${allDocs.length}");
                print("Best Sellers Found: ${bestSellerDocs.length}");

                if (bestSellerDocs.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No Best Selling Books Found"),
                        SizedBox(height: 10),
                        Text(
                          "Check Firebase:\n1. bestSeller field true hai?\n2. Field name sahi hai?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: bestSellerDocs.length,
                  itemBuilder: (_, index) {
                    final doc = bestSellerDocs[index];
                    final book = BookModel.fromJson(
                      doc.data() as Map<String, dynamic>,
                    ).copyWith(id: doc.id);

                    return PremiumBookCard(
                      book: book,
                      onTap: () {},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}