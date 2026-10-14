import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/category_model.dart';
import '../../../../providers/category_provider.dart';
import '../../../../services/cloudinary_service.dart';

class CategoryForm extends StatefulWidget {
  final CategoryModel? category;

  const CategoryForm({
    super.key,
    this.category,
  });

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _descriptionController =
      TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Uint8List? _imageBytes;

  String _imageUrl = "";

  bool _active = true;

  bool _uploading = false;

  @override
  void initState() {
    super.initState();

    if (widget.category != null) {
      _nameController.text = widget.category!.name;

      _descriptionController.text =
          widget.category!.description;

      _imageUrl = widget.category!.imageUrl;

      _active = widget.category!.active;
    }
  }  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (file == null) return;

    _imageBytes = await file.readAsBytes();

    setState(() {});
  }

  Future<void> saveCategory() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_imageBytes == null && widget.category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select category image.",
          ),
        ),
      );
      return;
    }

    setState(() {
      _uploading = true;
    });

    try {
      String imageUrl = _imageUrl;

      if (_imageBytes != null) {
        imageUrl = await CloudinaryService().uploadImage(
          imageBytes: _imageBytes!,
          fileName: _nameController.text.trim(),
        );
      }

      final category = CategoryModel(
        id: widget.category?.id ?? const Uuid().v4(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: imageUrl,
        active: _active,
        totalBooks: widget.category?.totalBooks ?? 0,
      );

      final provider = context.read<CategoryProvider>();

      if (widget.category == null) {
        await provider.addCategory(category);
      } else {
        await provider.updateCategory(category);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            widget.category == null
                ? "Category added successfully."
                : "Category updated successfully.",
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
    }

    if (mounted) {
      setState(() {
        _uploading = false;
      });
    }
  }  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //-----------------------------------------
          // IMAGE
          //-----------------------------------------

          const Text(
            "Category Image",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          InkWell(
            onTap: pickImage,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),

              child: _imageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.memory(
                        _imageBytes!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : _imageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            _imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 60,
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [

                              Icon(
                                Icons.cloud_upload_rounded,
                                size: 60,
                                color: Color(0xff6C4EF6),
                              ),

                              SizedBox(height: 12),

                              Text(
                                "Click to upload image",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),

                            ],
                          ),
                        ),
            ),
          ),

          const SizedBox(height: 30),

          //-----------------------------------------
          // CATEGORY NAME
          //-----------------------------------------

          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Category Name",
              prefixIcon: const Icon(
                Icons.category,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(14),
              ),
            ),
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty) {
                return "Enter category name";
              }
              return null;
            },
          ),

          const SizedBox(height: 22),

          //-----------------------------------------
          // DESCRIPTION
          //-----------------------------------------

          TextFormField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: "Description",
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(14),
              ),
            ),
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty) {
                return "Enter description";
              }
              return null;
            },
          ),

          const SizedBox(height: 25),          //--------------------------------------------------
          // ACTIVE SWITCH
          //--------------------------------------------------

          SwitchListTile(
            value: _active,
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xff6C4EF6),
            title: const Text(
              "Active Category",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              "Inactive categories will not appear in the app.",
            ),
            onChanged: (value) {
              setState(() {
                _active = value;
              });
            },
          ),

          const SizedBox(height: 35),

          //--------------------------------------------------
          // SAVE BUTTON
          //--------------------------------------------------

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: _uploading
                  ? null
                  : saveCategory,

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6C4EF6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              icon: _uploading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      widget.category == null
                          ? Icons.save
                          : Icons.edit,
                    ),

              label: Text(
                _uploading
                    ? "Please Wait..."
                    : widget.category == null
                        ? "Save Category"
                        : "Update Category",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),        ],
      ),
    );
  }
}