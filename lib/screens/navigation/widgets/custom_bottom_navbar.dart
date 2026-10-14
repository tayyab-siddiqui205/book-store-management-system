import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff6C4EF6);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 25,
              offset: Offset(0, 8),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [

            _item(Icons.home_rounded, "Home", 0),

            _item(Icons.grid_view_rounded, "Categories", 1),

            _item(Icons.favorite_border_rounded, "Wishlist", 2),

            _item(Icons.shopping_cart_outlined, "Cart", 3),

            _item(Icons.person_outline_rounded, "Profile", 4),

          ],
        ),
      ),
    );
  }

  Widget _item(
    IconData icon,
    String title,
    int index,
  ) {
    bool selected = currentIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => onTap(index),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff6C4EF6).withOpacity(.12)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [

            Icon(
              icon,
              color: selected
                  ? const Color(0xff6C4EF6)
                  : Colors.grey,
            ),

            const SizedBox(height: 4),

            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: selected
                    ? const Color(0xff6C4EF6)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}