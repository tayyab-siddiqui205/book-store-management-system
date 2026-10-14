import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/book_model.dart';
import '../../../providers/book_provider.dart';

import 'add_book_screen.dart';
import 'edit_book_screen.dart';


class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({super.key});

  @override
  State<AllBooksScreen> createState() =>
      _AllBooksScreenState();
}

class _AllBooksScreenState
    extends State<AllBooksScreen> {
  final TextEditingController searchController =
      TextEditingController();

  String category = "All";

  final List<String> categories = [
    "All",
    "Programming",
    "Novel",
    "Science",
    "History",
    "Business",
    "Islamic",
  ];

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<BookProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff6C4EF6),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Book"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddBookScreen(),
            ),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Books Management",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Manage your bookstore inventory",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: searchController,

                    decoration: InputDecoration(
                      hintText: "Search books...",

                      prefixIcon: const Icon(
                        Icons.search,
                      ),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                        borderSide:
                            BorderSide.none,
                      ),
                    ),

                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),

                const SizedBox(width: 20),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(14),
                  ),

                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: category,

                      items: categories.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),

                      onChanged: (value) {
                        setState(() {
                          category = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(18),

                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withOpacity(.05),
                      blurRadius: 20,
                      offset:
                          const Offset(0, 5),
                    ),
                  ],
                ),

                child: Padding(
                  padding:
                      const EdgeInsets.all(20),

                  child:
                      StreamBuilder<
                          QuerySnapshot<
                              Map<String, dynamic>>>(
                    stream: provider.allBooks,builder: (context, snapshot) {
  if (snapshot.connectionState ==
      ConnectionState.waiting) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if (snapshot.hasError) {
    return Center(
      child: Text(snapshot.error.toString()),
    );
  }

  if (!snapshot.hasData ||
      snapshot.data!.docs.isEmpty) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_rounded,
            size: 70,
            color: Colors.grey,
          ),
          SizedBox(height: 15),
          Text(
            "No Books Found",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> books =
      snapshot.data!.docs;

  if (category != "All") {
    books = books.where((e) {
      return e["category"] == category;
    }).toList();
  }

  if (searchController.text.trim().isNotEmpty) {
    books = books.where((e) {
      final title =
          e["title"].toString().toLowerCase();

      return title.contains(
        searchController.text.toLowerCase(),
      );
    }).toList();
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 35,
        headingRowHeight: 60,
        dataRowHeight: 85,

        headingRowColor:
            WidgetStateProperty.all(
          const Color(0xffF3F0FF),
        ),

        columns: const [

          DataColumn(
            label: Text(
              "Cover",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          DataColumn(
            label: Text(
              "Book",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          DataColumn(
            label: Text(
              "Author",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          DataColumn(
            label: Text(
              "Category",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          DataColumn(
            label: Text(
              "Price",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          DataColumn(
            label: Text(
              "Stock",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          DataColumn(
            label: Text(
              "Status",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          DataColumn(
            label: Text(
              "Actions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],

        rows: books.map((doc) {
          final book = BookModel.fromJson(
            doc.data(),
            documentId: doc.id,
          );return DataRow(
  cells: [

    //================ IMAGE =================

    DataCell(
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          book.imageUrl,
          width: 55,
          height: 75,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              width: 55,
              height: 75,
              color: Colors.grey.shade200,
              child: const Icon(
                Icons.menu_book,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    ),

    //================ BOOK =================

    DataCell(
      SizedBox(
        width: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              book.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 5),

            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [

                if (book.featured)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Featured",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                if (book.bestSeller)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Best Seller",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                if (book.newArrival)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "New",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

              ],
            ),

          ],
        ),
      ),
    ),

    //================ AUTHOR =================

    DataCell(
      Text(
        book.author,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    //================ CATEGORY =================

    DataCell(
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius:
              BorderRadius.circular(20),
        ),
        child: Text(
          book.category,
          style: TextStyle(
            color: Colors.blue.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),

    //================ PRICE =================

    DataCell(
      Text(
        "\$${book.price.toStringAsFixed(2)}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    ),

    //================ STOCK =================

    DataCell(
      Text(
        "${book.stock}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    //================ STATUS =================

    DataCell(
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: book.stock > 0
              ? Colors.green.shade100
              : Colors.red.shade100,
          borderRadius:
              BorderRadius.circular(20),
        ),
        child: Text(
          book.stock > 0
              ? "In Stock"
              : "Out of Stock",
          style: TextStyle(
            color: book.stock > 0
                ? Colors.green
                : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),    //================ ACTIONS =================

    DataCell(
      Row(
        children: [

          //================ EDIT =================

          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              tooltip: "Edit Book",
              icon: const Icon(
                Icons.edit_rounded,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        EditBookScreen(book: book),
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 10),

          //================ DELETE =================

          Container(
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              tooltip: "Delete Book",
              icon: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
              ),
              onPressed: () async {

                final result =
                    await showDialog<bool>(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),

                      title: const Text(
                        "Delete Book",
                      ),

                      content: Text(
                        "Are you sure you want to delete '${book.title}' ?",
                      ),

                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              false,
                            );
                          },
                          child: const Text(
                            "Cancel",
                          ),
                        ),

                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.red,
                            foregroundColor:
                                Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(
                              context,
                              true,
                            );
                          },
                          child: const Text(
                            "Delete",
                          ),
                        ),

                      ],
                    );
                  },
                );

                if (result == true) {

                  await provider.deleteBook(
                    book.id,
                  );

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      backgroundColor:
                          Colors.green.shade600,
                      content: Text(
                        "${book.title} deleted successfully.",
                      ),
                    ),
                  );
                }
              },
            ),
          ),

        ],
      ),
    ),

  ],
);

}).toList(),
      ),
    ),
  );
},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}