import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/book_model.dart';
import '../../../../models/category_model.dart';

import '../../../../providers/book_provider.dart';
import '../../../../providers/category_provider.dart';

import '../../../../services/cloudinary_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class BookForm extends StatefulWidget {
  final BookModel? book;

  const BookForm({
    super.key,
    this.book,
  });

  @override
  State<BookForm> createState() => _BookFormState();
}
class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();

  //--------------------------------------------------
  // Controllers
  //--------------------------------------------------

  final _titleController = TextEditingController();

  final _authorController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _priceController = TextEditingController();

  final _stockController = TextEditingController();

  final _publisherController = TextEditingController();

  final _languageController = TextEditingController();

  final _pagesController = TextEditingController();

  final _publishedDateController =
      TextEditingController();

  final _pdfController =
      TextEditingController();

  //--------------------------------------------------
  // Category
  //--------------------------------------------------

  String? _selectedCategory;

  //--------------------------------------------------
  // Switches
  //--------------------------------------------------

  bool _featured = false;

  bool _bestSeller = false;

  bool _newArrival = false;

  //--------------------------------------------------
  // Image
  //--------------------------------------------------

  Uint8List? _imageBytes;

  String _imageUrl = "";

  final ImagePicker _picker =
      ImagePicker();

  //--------------------------------------------------
  // Loading
  //--------------------------------------------------

  bool _saving = false;  //--------------------------------------------------
  // INIT
  //--------------------------------------------------

  @override
  void initState() {
    super.initState();

    if (widget.book != null) {
      final book = widget.book!;

      _titleController.text = book.title;
      _authorController.text = book.author;
      _descriptionController.text = book.description;

      _priceController.text = book.price.toString();
      _stockController.text = book.stock.toString();

      _publisherController.text = book.publisher;
      _languageController.text = book.language;
      _pagesController.text = book.pages.toString();

      _publishedDateController.text =
          book.publishedDate;

      _pdfController.text = book.pdf;

      _selectedCategory = book.category;

      _featured = book.featured;
      _bestSeller = book.bestSeller;
      _newArrival = book.newArrival;

      _imageUrl = book.imageUrl;
    }
  }

  //--------------------------------------------------
  // DISPOSE
  //--------------------------------------------------

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();

    _priceController.dispose();
    _stockController.dispose();

    _publisherController.dispose();
    _languageController.dispose();
    _pagesController.dispose();

    _publishedDateController.dispose();
    _pdfController.dispose();

    super.dispose();
  }

  //--------------------------------------------------
  // PICK IMAGE
  //--------------------------------------------------

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (file == null) return;

    _imageBytes = await file.readAsBytes();

    setState(() {});
  }  //--------------------------------------------------
  // SAVE BOOK
  //--------------------------------------------------

  Future<void> _saveBook() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select a category.",
          ),
        ),
      );
      return;
    }

    if (_imageBytes == null &&
        widget.book == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please upload book cover.",
          ),
        ),
      );
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      String image = _imageUrl;

      if (_imageBytes != null) {
        image =
            await CloudinaryService().uploadImage(
          imageBytes: _imageBytes!,
          fileName:
              _titleController.text.trim(),
        );
      }

      final book = BookModel(
        id: widget.book?.id ??
            const Uuid().v4(),

        title: _titleController.text.trim(),

        author:
            _authorController.text.trim(),

        category: _selectedCategory!,

        description:
            _descriptionController.text.trim(),

        price: double.tryParse(
              _priceController.text.trim(),
            ) ??
            0,

        stock: int.tryParse(
              _stockController.text.trim(),
            ) ??
            0,

        imageUrl: image,

        rating: widget.book?.rating ?? 0,

        pages: int.tryParse(
              _pagesController.text.trim(),
            ) ??
            0,

        language:
            _languageController.text.trim(),

        publisher:
            _publisherController.text.trim(),

        publishedDate:
            _publishedDateController.text.trim(),

        pdf: _pdfController.text.trim(),

        isApiBook: false,

        featured: _featured,

        bestSeller: _bestSeller,

        newArrival: _newArrival,
      );

      final provider =
          Provider.of<BookProvider>(
        context,
        listen: false,
      );

      if (widget.book == null) {
        await provider.addBook(book);
      } else {
        await provider.updateBook(book);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            widget.book == null
                ? "Book added successfully."
                : "Book updated successfully.",
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.toString(),
          ),
        ),
      );
    }

    if (mounted) {
      setState(() {
        _saving = false;
      });
    }
  }  //--------------------------------------------------
  // BUILD
  //--------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //--------------------------------------------------
            // BOOK COVER
            //--------------------------------------------------

            const Text(
              "Book Cover",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            InkWell(
              onTap: _pickImage,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius:
                      BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: _imageBytes != null
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.circular(18),
                        child: Image.memory(
                          _imageBytes!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : _imageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius:
                                BorderRadius.circular(18),
                            child: Image.network(
                              _imageUrl,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Center(
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [

                                Icon(
                                  Icons.cloud_upload,
                                  size: 60,
                                  color: Color(0xff6C4EF6),
                                ),

                                SizedBox(height: 10),

                                Text(
                                  "Click to upload book cover",
                                ),

                              ],
                            ),
                          ),
              ),
            ),

            const SizedBox(height: 25),

            //--------------------------------------------------
            // TITLE
            //--------------------------------------------------

            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Book Title",
                prefixIcon: Icon(Icons.book),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Enter book title";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // AUTHOR
            //--------------------------------------------------

            TextFormField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: "Author",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Enter author";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // CATEGORY
            //--------------------------------------------------

            Consumer<CategoryProvider>(
  builder: (context, provider, child) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: provider.service.getActiveCategories(),
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final categories = snapshot.data!.docs;

        if (categories.isEmpty) {
          return const Text("No Categories Found");
        }

        return DropdownButtonFormField<String>(
          value: _selectedCategory,

          decoration: const InputDecoration(
            labelText: "Category",
            prefixIcon: Icon(Icons.category),
            border: OutlineInputBorder(),
          ),

         items: categories.map<DropdownMenuItem<String>>((doc) {
            final data = doc.data();

            return DropdownMenuItem<String>(
              value: data["name"],
              child: Text(data["name"]),
            );
          }).toList(),

          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
        );
      },
    );
  },
),

            const SizedBox(height: 20),            //--------------------------------------------------
            // PRICE
            //--------------------------------------------------

            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Price",
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Enter price";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // STOCK
            //--------------------------------------------------

            TextFormField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Stock",
                prefixIcon: Icon(Icons.inventory),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Enter stock";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // PUBLISHER
            //--------------------------------------------------

            TextFormField(
              controller: _publisherController,
              decoration: const InputDecoration(
                labelText: "Publisher",
                prefixIcon: Icon(Icons.business),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // LANGUAGE
            //--------------------------------------------------

            TextFormField(
              controller: _languageController,
              decoration: const InputDecoration(
                labelText: "Language",
                prefixIcon: Icon(Icons.language),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // PAGES
            //--------------------------------------------------

            TextFormField(
              controller: _pagesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Pages",
                prefixIcon: Icon(Icons.menu_book),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // PUBLISHED DATE
            //--------------------------------------------------

            TextFormField(
              controller: _publishedDateController,
              decoration: const InputDecoration(
                labelText: "Published Date",
                hintText: "2026",
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // PDF URL
            //--------------------------------------------------

            TextFormField(
              controller: _pdfController,
              decoration: const InputDecoration(
                labelText: "PDF URL (Optional)",
                prefixIcon: Icon(Icons.picture_as_pdf),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // DESCRIPTION
            //--------------------------------------------------

            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Description",
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Enter description";
                }
                return null;
              },
            ),

            const SizedBox(height: 30),            //--------------------------------------------------
            // BOOK OPTIONS
            //--------------------------------------------------

            const Text(
              "Book Options",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: Column(
                children: [

                  SwitchListTile(
                    value: _featured,
                    title: const Text("Featured Book"),
                    subtitle: const Text(
                      "Show this book in Featured section",
                    ),
                    secondary: const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _featured = value;
                      });
                    },
                  ),

                  const Divider(height: 1),

                  SwitchListTile(
                    value: _bestSeller,
                    title: const Text("Best Seller"),
                    subtitle: const Text(
                      "Show this book in Best Seller section",
                    ),
                    secondary: const Icon(
                      Icons.local_fire_department,
                      color: Colors.red,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _bestSeller = value;
                      });
                    },
                  ),

                  const Divider(height: 1),

                  SwitchListTile(
                    value: _newArrival,
                    title: const Text("New Arrival"),
                    subtitle: const Text(
                      "Show this book in New Arrival section",
                    ),
                    secondary: const Icon(
                      Icons.fiber_new,
                      color: Colors.green,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _newArrival = value;
                      });
                    },
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            //--------------------------------------------------
            // SAVE BUTTON
            //--------------------------------------------------

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _saving ? null : _saveBook,
                icon: _saving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        widget.book == null
                            ? Icons.save
                            : Icons.edit,
                      ),
                label: Text(
                  _saving
                      ? "Please Wait..."
                      : widget.book == null
                          ? "Save Book"
                          : "Update Book",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6C4EF6),
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}