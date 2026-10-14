import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {

    final width=MediaQuery.of(context).size.width;

    return Padding(

      padding: EdgeInsets.symmetric(
        horizontal: width*.05,
      ),

      child: Row(

        children: [

          Expanded(

            flex: 5,

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: const [

                Text(
                  "Welcome to",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),

                SizedBox(height:8),

                Text(
                  "Book\nStore",
                  style: TextStyle(
                    height: .95,
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height:18),

                Text(
                  "Discover • Read • Grow",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 21,
                  ),
                )

              ],
            ),
          ),

          Expanded(

            flex:4,

            child: Image.asset(
              AppAssets.banner,
              height: width>900
                  ?260
                  :170,
            ),

          )

        ],
      ),
    );
  }
}