import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    final isDesktop = width > 900;
    final isTablet = width > 600;

    final itemWidth = isDesktop
        ? 160.0
        : isTablet
            ? 130.0
            : 95.0;

    final iconSize = isDesktop
        ? 34.0
        : isTablet
            ? 30.0
            : 26.0;

    final fontSize = isDesktop
        ? 17.0
        : isTablet
            ? 15.0
            : 13.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * .04,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
          children: [

            _item(
              true,
              Icons.grid_view_rounded,
              "Categories",
              iconSize,
              fontSize,
              itemWidth,
            ),

            _item(
              false,
              Icons.workspace_premium_outlined,
              "Best Seller",
              iconSize,
              fontSize,
              itemWidth,
            ),

            _item(
              false,
              Icons.new_releases_outlined,
              "New Arrival",
              iconSize,
              fontSize,
              itemWidth,
            ),

            _item(
              false,
              Icons.star_outline_rounded,
              "Featured",
              iconSize,
              fontSize,
              itemWidth,
            ),

            _item(
              false,
              Icons.person_outline,
              "Authors",
              iconSize,
              fontSize,
              itemWidth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    bool selected,
    IconData icon,
    String title,
    double iconSize,
    double fontSize,
    double width,
  ) {
    return SizedBox(
      width: width,
      child: Column(
        children: [

          Container(
            height: iconSize + 18,
            width: iconSize + 18,
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary
                  : Colors.transparent,
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              size: iconSize,
              color: selected
                  ? Colors.white
                  : Colors.black87,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: selected
                  ? FontWeight.bold
                  : FontWeight.w500,
              color: selected
                  ? AppColors.primary
                  : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}