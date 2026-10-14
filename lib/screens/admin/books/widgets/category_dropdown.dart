import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final String value;
  final Function(String?) onChanged;

  const CategoryDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  static const List<String> categories = [
    "Programming",
    "Novel",
    "Science",
    "Technology",
    "Business",
    "Education",
    "History",
    "Biography",
    "Islamic",
    "Kids",
    "General",
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,

      decoration: InputDecoration(
        labelText: "Category",

        prefixIcon: const Icon(Icons.category),

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      items: categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),

      onChanged: onChanged,
    );
  }
}