import 'package:flutter/material.dart';

class AdminMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const AdminMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),

            height: 60,

            padding: const EdgeInsets.symmetric(horizontal: 20),

            decoration: BoxDecoration(
              color: selected
                  ? Colors.white.withOpacity(.15)
                  : Colors.transparent,

              borderRadius: BorderRadius.circular(18),
            ),

            child: Row(
              children: [

                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}