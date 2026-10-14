// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// import '../../../models/book_model.dart';
// import '../../../providers/book_provider.dart';
// import '../../../services/cloudinary_service.dart';

// class EditBookScreen extends StatefulWidget {
//   final BookModel book;

//   const EditBookScreen({
//     super.key,
//     required this.book,
//   });

//   @override
//   State<EditBookScreen> createState() =>
//       _EditBookScreenState();
// }

// class _EditBookScreenState
//     extends State<EditBookScreen> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController _titleController;

//   late TextEditingController _authorController;

//   late TextEditingController _descriptionController;

//   late TextEditingController _priceController;

//   late TextEditingController _stockController;

//   late TextEditingController _publisherController;

//   late TextEditingController _languageController;

//   late TextEditingController _pagesController;

//   late TextEditingController _publishedDateController;

//   late TextEditingController _pdfController;

//   final ImagePicker _picker = ImagePicker();

//   Uint8List? _imageBytes;

//   String? _imageName;

//   late String _category;

//   late bool _featured;

//   late bool _bestSeller;

//   late bool _newArrival;

//   bool _loading = false;

//   final List<String> categories = const [
//     "Programming",
//     "Novel",
//     "Business",
//     "Science",
//     "History",
//     "Islamic",
//     "Children",
//     "Fantasy",
//   ];

//   @override
//   void initState() {
//     super.initState();

//     final book = widget.book;

//     _titleController =
//         TextEditingController(text: book.title);

//     _authorController =
//         TextEditingController(text: book.author);

//     _descriptionController =
//         TextEditingController(
//       text: book.description,
//     );

//     _priceController =
//         TextEditingController(
//       text: book.price.toString(),
//     );

//     _stockController =
//         TextEditingController(
//       text: book.stock.toString(),
//     );

//     _publisherController =
//         TextEditingController(
//       text: book.publisher,
//     );

//     _languageController =
//         TextEditingController(
//       text: book.language,
//     );

//     _pagesController =
//         TextEditingController(
//       text: book.pages.toString(),
//     );

//     _publishedDateController =
//         TextEditingController(
//       text: book.publishedDate,
//     );

//     _pdfController =
//         TextEditingController(
//       text: book.pdf,
//     );

//     _category = book.category;

//     _featured = book.featured;

//     _bestSeller = book.bestSeller;

//     _newArrival = book.newArrival;
//   }

//   Future<void> pickImage() async {
//     final image = await _picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 80,
//     );

//     if (image == null) return;

//     _imageBytes = await image.readAsBytes();

//     _imageName = image.name;

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();

//     _authorController.dispose();

//     _descriptionController.dispose();

//     _priceController.dispose();

//     _stockController.dispose();

//     _publisherController.dispose();

//     _languageController.dispose();

//     _pagesController.dispose();

//     _publishedDateController.dispose();

//     _pdfController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider =
//         Provider.of<BookProvider>(
//       context,
//       listen: false,
//     );

//     return Scaffold(
//       backgroundColor: const Color(0xffF6F7FB),

//       appBar: AppBar(
//         title: const Text(
//           "Edit Book",
//         ),
//         centerTitle: true,
//       ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),

//           child: Form(
//             key: _formKey,

//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//               children: [                InkWell(
//                   onTap: pickImage,
//                   borderRadius: BorderRadius.circular(15),
//                   child: Container(
//                     height: 200,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(
//                         color: Colors.grey.shade300,
//                       ),
//                     ),
//                     child: _imageBytes != null
//                         ? ClipRRect(
//                             borderRadius:
//                                 BorderRadius.circular(15),
//                             child: Image.memory(
//                               _imageBytes!,
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                         : ClipRRect(
//                             borderRadius:
//                                 BorderRadius.circular(15),
//                             child: Image.network(
//                               widget.book.imageUrl,
//                               fit: BoxFit.cover,
//                               errorBuilder:
//                                   (_, __, ___) {
//                                 return const Center(
//                                   child: Icon(
//                                     Icons.menu_book,
//                                     size: 70,
//                                     color: Colors.grey,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 TextFormField(
//                   controller: _titleController,
//                   decoration: const InputDecoration(
//                     labelText: "Book Title",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null ||
//                         value.trim().isEmpty) {
//                       return "Enter title";
//                     }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 18),

//                 TextFormField(
//                   controller: _authorController,
//                   decoration: const InputDecoration(
//                     labelText: "Author",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null ||
//                         value.trim().isEmpty) {
//                       return "Enter author";
//                     }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 18),

//                 DropdownButtonFormField<String>(
//                   value: _category,
//                   decoration: const InputDecoration(
//                     labelText: "Category",
//                     border: OutlineInputBorder(),
//                   ),
//                   items: categories
//                       .map(
//                         (e) =>
//                             DropdownMenuItem(
//                           value: e,
//                           child: Text(e),
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _category = value!;
//                     });
//                   },
//                 ),

//                 const SizedBox(height: 18),

//                 TextFormField(
//                   controller: _priceController,
//                   keyboardType:
//                       const TextInputType
//                           .numberWithOptions(
//                     decimal: true,
//                   ),
//                   decoration: const InputDecoration(
//                     labelText: "Price",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 TextFormField(
//                   controller: _stockController,
//                   keyboardType:
//                       TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: "Stock",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 TextFormField(
//                   controller:
//                       _publisherController,
//                   decoration:
//                       const InputDecoration(
//                     labelText: "Publisher",
//                     border:
//                         OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 TextFormField(
//                   controller:
//                       _languageController,
//                   decoration:
//                       const InputDecoration(
//                     labelText: "Language",
//                     border:
//                         OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 TextFormField(
//                   controller:
//                       _pagesController,
//                   keyboardType:
//                       TextInputType.number,
//                   decoration:
//                       const InputDecoration(
//                     labelText: "Pages",
//                     border:
//                         OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 TextFormField(
//                   controller:
//                       _publishedDateController,
//                   decoration:
//                       const InputDecoration(
//                     labelText:
//                         "Published Date",
//                     border:
//                         OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 TextFormField(
//                   controller: _pdfController,
//                   decoration:
//                       const InputDecoration(
//                     labelText: "PDF URL",
//                     border:
//                         OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 TextFormField(
//                   controller:
//                       _descriptionController,
//                   maxLines: 5,
//                   decoration:
//                       const InputDecoration(
//                     labelText:
//                         "Description",
//                     border:
//                         OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 25),                const Text(
//                   "Book Options",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 SwitchListTile(
//                   title: const Text("Featured Book"),
//                   value: _featured,
//                   activeColor: Colors.deepPurple,
//                   onChanged: (value) {
//                     setState(() {
//                       _featured = value;
//                     });
//                   },
//                 ),

//                 SwitchListTile(
//                   title: const Text("Best Seller"),
//                   value: _bestSeller,
//                   activeColor: Colors.deepPurple,
//                   onChanged: (value) {
//                     setState(() {
//                       _bestSeller = value;
//                     });
//                   },
//                 ),

//                 SwitchListTile(
//                   title: const Text("New Arrival"),
//                   value: _newArrival,
//                   activeColor: Colors.deepPurple,
//                   onChanged: (value) {
//                     setState(() {
//                       _newArrival = value;
//                     });
//                   },
//                 ),

//                 const SizedBox(height: 30),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 55,
//                   child: ElevatedButton.icon(
//                     icon: _loading
//                         ? const SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Colors.white,
//                             ),
//                           )
//                         : const Icon(Icons.save),

//                     label: Text(
//                       _loading
//                           ? "Updating..."
//                           : "Update Book",
//                     ),

//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           const Color(0xff6C4EF6),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.circular(12),
//                       ),
//                     ),

//                     onPressed: _loading
//                         ? null
//                         : () async {
//                             if (!_formKey.currentState!
//                                 .validate()) {
//                               return;
//                             }

//                             setState(() {
//                               _loading = true;
//                             });

//                             try {
//                               String imageUrl =
//                                   widget.book.imageUrl;

//                               if (_imageBytes != null) {
//                                 imageUrl =
//                                     await CloudinaryService()
//                                         .uploadImage(
//                                   imageBytes:
//                                       _imageBytes!,
//                                   fileName:
//                                       _imageName!,
//                                 );
//                               }

//                               final updatedBook =
//                                   widget.book.copyWith(
//                                 title:
//                                     _titleController.text
//                                         .trim(),
//                                 author:
//                                     _authorController.text
//                                         .trim(),
//                                 category: _category,
//                                 description:
//                                     _descriptionController
//                                         .text
//                                         .trim(),
//                                 price: double.parse(
//                                   _priceController.text,
//                                 ),
//                                 stock: int.parse(
//                                   _stockController.text,
//                                 ),
//                                 imageUrl: imageUrl,
//                                 pages: int.tryParse(
//                                       _pagesController
//                                           .text,
//                                     ) ??
//                                     0,
//                                 language:
//                                     _languageController
//                                         .text
//                                         .trim(),
//                                 publisher:
//                                     _publisherController
//                                         .text
//                                         .trim(),
//                                 publishedDate:
//                                     _publishedDateController
//                                         .text
//                                         .trim(),
//                                 pdf: _pdfController.text
//                                     .trim(),
//                                 featured: _featured,
//                                 bestSeller:
//                                     _bestSeller,
//                                 newArrival:
//                                     _newArrival,
//                               );

//                               await provider.updateBook(
//                                 updatedBook,
//                               );

//                               if (!mounted) return;

//                               ScaffoldMessenger.of(
//                                       context)
//                                   .showSnackBar(
//                                 const SnackBar(
//                                   backgroundColor:
//                                       Colors.green,
//                                   content: Text(
//                                     "Book updated successfully.",
//                                   ),
//                                 ),
//                               );

//                               Navigator.pop(context);
//                             } catch (e) {
//                               if (!mounted) return;

//                               ScaffoldMessenger.of(
//                                       context)
//                                   .showSnackBar(
//                                 SnackBar(
//                                   backgroundColor:
//                                       Colors.red,
//                                   content: Text(
//                                     e.toString(),
//                                   ),
//                                 ),
//                               );
//                             }

//                             if (mounted) {
//                               setState(() {
//                                 _loading = false;
//                               });
//                             }
//                           },
//                   ),
//                 ),

//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

import '../../../models/book_model.dart';
import 'widgets/book_form.dart';

class EditBookScreen extends StatelessWidget {
  final BookModel book;

  const EditBookScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        title: const Text("Edit Book"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: BookForm(book: book),
      ),
    );
  }
}