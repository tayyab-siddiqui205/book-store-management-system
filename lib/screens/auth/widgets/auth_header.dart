import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // Logo
        Center(
          child: Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xff6C4EF6),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 45,
            ),
          ),
        ),

        const SizedBox(height: 35),

        // Dynamic Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        // Dynamic Subtitle
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}