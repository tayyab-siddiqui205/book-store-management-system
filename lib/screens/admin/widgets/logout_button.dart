import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 52,

      child: ElevatedButton.icon(
        onPressed: onTap,

        icon: const Icon(Icons.logout),

        label: const Text(
          "Logout",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        style: ElevatedButton.styleFrom(
          elevation: 0,

          backgroundColor: Colors.white,

          foregroundColor: Colors.black87,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),

          side: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}