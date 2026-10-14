import 'package:flutter/material.dart';

import '../../../models/category_model.dart';
import 'widgets/category_form.dart';

class EditCategoryScreen extends StatelessWidget {
  final CategoryModel category;

  const EditCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        title: const Text(
          "Edit Category",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(30),
                  child: CategoryForm(
                    category: category,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}