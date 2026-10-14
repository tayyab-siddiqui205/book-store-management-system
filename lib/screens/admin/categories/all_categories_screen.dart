import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/category_model.dart';
import '../../../providers/category_provider.dart';

import 'add_category_screen.dart';
import 'edit_category_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff6C4EF6),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Category"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddCategoryScreen(),
            ),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            //--------------------------------------------------
            // HEADER
            //--------------------------------------------------

            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 20,
              spacing: 20,
              children: [

                const SizedBox(
                  width: 500,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        "Manage all book categories",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(
                  height: 45,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xff6C4EF6),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const AddCategoryScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("New Category"),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30),

            Expanded(
              child: StreamBuilder<
                  QuerySnapshot<Map<String, dynamic>>>(
                stream: provider.allCategories,
                builder: (context, snapshot) {                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [

                          Icon(
                            Icons.category_outlined,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "No Categories Found",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "Click 'New Category' to add your first category.",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),

                        ],
                      ),
                    );
                  }

                  final categories = snapshot.data!.docs;

                  return GridView.builder(
                    itemCount: categories.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.82,
                    ),

                    itemBuilder: (context, index) {

                      final category =
                          CategoryModel.fromJson(
                        categories[index].data(),
                        documentId: categories[index].id,
                      );

                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [                            //--------------------------------------------------
                            // IMAGE
                            //--------------------------------------------------

                            SizedBox(
                              height: 170,
                              width: double.infinity,
                              child: Image.network(
                                category.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (_, __, ___) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Icon(
                                        Icons.category,
                                        size: 60,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      children: [

                                        Expanded(
                                          child: Text(
                                            category.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: category.active
                                                ? Colors.green.shade100
                                                : Colors.red.shade100,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Text(
                                            category.active
                                                ? "Active"
                                                : "Inactive",
                                            style: TextStyle(
                                              color: category.active
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),

                                    const SizedBox(height: 12),

                                    Text(
                                      category.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),

                                    const Spacer(),

                                    Row(
                                      children: [

                                        const Icon(
                                          Icons.menu_book,
                                          size: 18,
                                          color: Color(0xff6C4EF6),
                                        ),

                                        const SizedBox(width: 6),

                                        Text(
                                          "${category.totalBooks} Books",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                      ],
                                    ),

                                    const SizedBox(height: 16),                                    Row(
                                      children: [

                                        Expanded(
                                          child: OutlinedButton.icon(
                                            style:
                                                OutlinedButton.styleFrom(
                                              foregroundColor:
                                                  Colors.blue,
                                              side: const BorderSide(
                                                color: Colors.blue,
                                              ),
                                              shape:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      EditCategoryScreen(
                                                    category: category,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              size: 18,
                                            ),
                                            label: const Text(
                                              "Edit",
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 10),

                                        Expanded(
                                          child: ElevatedButton.icon(
                                            style:
                                                ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.red,
                                              foregroundColor:
                                                  Colors.white,
                                              shape:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () async {

                                              final result =
                                                  await showDialog<bool>(
                                                context: context,
                                                builder: (_) =>
                                                    AlertDialog(
                                                  title: const Text(
                                                    "Delete Category",
                                                  ),
                                                  content: Text(
                                                    "Delete '${category.name}' ?",
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
                                                ),
                                              );

                                              if (result == true) {
                                                await provider
                                                    .deleteCategory(
                                                  category.id,
                                                );

                                                if (!context.mounted) {
                                                  return;
                                                }

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      "${category.name} deleted successfully.",
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 18,
                                            ),
                                            label: const Text(
                                              "Delete",
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}