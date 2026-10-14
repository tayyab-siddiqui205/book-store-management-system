import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    final isDesktop = width > 900;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * .04,
      ),
      child: Container(

        padding: EdgeInsets.all(
          isDesktop ? 32 : 22,
        ),

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(28),

          gradient: const LinearGradient(

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [

              Color(0xffF7F3FF),
              Color(0xffECE3FF),

            ],

          ),

          boxShadow: [

            BoxShadow(

              color: Colors.deepPurple.withOpacity(.12),

              blurRadius: 20,

              offset: const Offset(0,8),

            )

          ],

        ),

        child: Row(

          children: [

            //----------------------------------
            // LEFT
            //----------------------------------

            Expanded(

              flex: 5,

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Get 20% OFF",

                    style: TextStyle(

                      fontSize: 30,

                      fontWeight: FontWeight.bold,

                      color: AppColors.primary,

                    ),

                  ),

                  const SizedBox(height:8),

                  const Text(

                    "On your first order",

                    style: TextStyle(
                      fontSize: 20,
                    ),

                  ),

                  const SizedBox(height:20),

                  const Text(

                    "Use code",

                    style: TextStyle(
                      color: Colors.grey,
                    ),

                  ),

                  const SizedBox(height:10),

                  Container(

                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(30),

                    ),

                    child: const Text(

                      "WELCOME20",

                      style: TextStyle(

                        color: AppColors.primary,

                        fontWeight: FontWeight.bold,

                        fontSize: 15,

                      ),

                    ),

                  ),

                  const SizedBox(height:25),

                  SizedBox(

                    width: 160,

                    height: 52,

                    child: ElevatedButton(

                      onPressed: (){},

                      style: ElevatedButton.styleFrom(

                        backgroundColor:
                            AppColors.primary,

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(16),

                        ),

                      ),

                      child: const Text(

                        "Shop Now",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),

                      ),

                    ),

                  )

                ],
              ),
            ),

            //----------------------------------
            // IMAGE
            //----------------------------------

            Expanded(

              flex:4,

              child: Stack(

                alignment: Alignment.center,

                children: [

                  Image.asset(

                    AppAssets.offer,

                    height:
                        isDesktop
                            ?260
                            :180,

                  ),

                  Positioned(

                    bottom:20,

                    right:8,

                    child: Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal:14,

                        vertical:8,

                      ),

                      decoration: BoxDecoration(

                        color: Colors.deepOrange,

                        borderRadius:
                            BorderRadius.circular(14),

                      ),

                      child: const Text(

                        "20% OFF",

                        style: TextStyle(

                          color: Colors.white,

                          fontWeight: FontWeight.bold,

                        ),

                      ),

                    ),

                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}