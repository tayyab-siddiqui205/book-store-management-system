import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String name;
  final double radius;

  const AvatarWidget({
    super.key,
    required this.name,
    this.radius = 40,
  });

  @override
  Widget build(BuildContext context) {
    final String letter =
        name.isNotEmpty ? name[0].toUpperCase() : "U";

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,

      child: CircleAvatar(
        radius: radius - 3,
        backgroundColor: const Color(0xff6C4EF6),

        child: Text(
          letter,
          style: TextStyle(
            color: Colors.white,
            fontSize: radius * .9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}