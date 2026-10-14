import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [

        Expanded(child: Divider()),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "OR",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        Expanded(child: Divider()),
      ],
    );
  }
}