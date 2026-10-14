import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/book_model.dart';
import '../../../services/book_service.dart';
import 'book_card.dart';   // agar BookCard use kar rahe ho

class NewArrivalSection extends StatelessWidget {
  const NewArrivalSection({super.key});

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
                "New Arrivals",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  color: Color(0xff6C4EF6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 380,
            child: StreamBuilder<QuerySnapshot>(
              stream: BookService().booksRef
                  .where("newArrival", isEqualTo: true)
                  .snapshots(),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No New Arrivals Found"));
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (_, index) {
                    final book = BookModel.fromJson(
                      docs[index].data() as Map<String, dynamic>,
                    ).copyWith(id: docs[index].id);

                    return BookCard(book: book);
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