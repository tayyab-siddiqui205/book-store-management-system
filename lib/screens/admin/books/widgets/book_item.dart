import 'package:flutter/material.dart';

import '../../../../models/book_model.dart';

class BookItem extends StatelessWidget {
  final BookModel book;

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BookItem({
    super.key,
    required this.book,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //----------------------------------------------------
            // IMAGE
            //----------------------------------------------------

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: book.imageUrl.isEmpty
                  ? Container(
                      width: 90,
                      height: 120,
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.menu_book,
                        size: 40,
                        color: Colors.grey,
                      ),
                    )
                  : Image.network(
                      book.imageUrl,
                      width: 90,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          width: 90,
                          height: 120,
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.menu_book,
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(width: 18),

            //----------------------------------------------------
            // DETAILS
            //----------------------------------------------------

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Author : ${book.author}",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Category : ${book.category}",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "\$${book.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6C4EF6),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [

                      Chip(
                        label: Text("Stock : ${book.stock}"),
                        backgroundColor: Colors.green.shade100,
                      ),

                      if (book.featured)
                        Chip(
                          label: const Text("Featured"),
                          backgroundColor: Colors.orange.shade100,
                        ),

                      if (book.bestSeller)
                        Chip(
                          label: const Text("Best Seller"),
                          backgroundColor: Colors.blue.shade100,
                        ),

                      if (book.newArrival)
                        Chip(
                          label: const Text("New"),
                          backgroundColor: Colors.purple.shade100,
                        ),
                    ],
                  ),
                ],
              ),
            ),

            //----------------------------------------------------
            // BUTTONS
            //----------------------------------------------------

            Column(
              children: [

                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),

                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}