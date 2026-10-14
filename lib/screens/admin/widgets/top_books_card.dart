import 'package:flutter/material.dart';

class TopBooksCard extends StatelessWidget {
  const TopBooksCard({super.key});

  Widget bookItem({
    required String title,
    required String author,
    required String sold,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),

      child: Row(
        children: [

          Container(
            width: 52,
            height: 52,

            decoration: BoxDecoration(
              color: color.withOpacity(.15),
              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(
              Icons.menu_book_rounded,
              color: color,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  author,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [

              const Text(
                "Sold",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                sold,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.08),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Top Selling Books",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Expanded(
          child: ListView(
            children: [
              bookItem(
                title: "Atomic Habits",
                author: "James Clear",
                sold: "350",
                color: Colors.deepPurple,
              ),

              const Divider(),

              bookItem(
                title: "Clean Code",
                author: "Robert C. Martin",
                sold: "280",
                color: Colors.green,
              ),

              const Divider(),

              bookItem(
                title: "Flutter Cookbook",
                author: "Google",
                sold: "240",
                color: Colors.blue,
              ),

              const Divider(),

              bookItem(
                title: "Psychology of Money",
                author: "Morgan Housel",
                sold: "220",
                color: Colors.orange,
              ),

              const Divider(),

              bookItem(
                title: "Rich Dad Poor Dad",
                author: "Robert Kiyosaki",
                sold: "180",
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}