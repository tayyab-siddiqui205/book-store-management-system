import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [

        Icon(
          Icons.menu_book_rounded,
          size: 85,
          color: Color(0xff6C4EF6),
        ),

        SizedBox(height: 15),

        Text(
          "Log in or Sign up",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 10),

        Text(
          "Welcome to Book Store",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}