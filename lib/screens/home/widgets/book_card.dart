import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/book_model.dart';class BookCard extends StatelessWidget {
  final BookModel book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      margin: const EdgeInsets.only(right: 20),

      child: Material(
        color: Colors.white,

        elevation: 8,

        shadowColor: Colors.black12,

        borderRadius: BorderRadius.circular(28),

        child: InkWell(
          borderRadius: BorderRadius.circular(28),

          onTap: () {

            // Book Details Screen

          },

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [              //----------------------------------
              // IMAGE
              //----------------------------------

              Expanded(
                flex: 7,

                child: Stack(

                  children: [

                    Positioned.fill(

                      child: ClipRRect(

                        borderRadius:
                            const BorderRadius.only(

                          topLeft:
                              Radius.circular(28),

                          topRight:
                              Radius.circular(28),

                        ),

                        child: book.imageUrl.isEmpty

                            ? _placeholder()

                            : CachedNetworkImage(

                                imageUrl:
                                    book.imageUrl,

                                fit: BoxFit.cover,

                                placeholder:
                                    (_, __) =>
                                        _placeholder(),

                                errorWidget:
                                    (_, __, ___) =>
                                        _placeholder(),

                              ),
                      ),
                    ),                    //----------------------------------
                    // WISHLIST
                    //----------------------------------

                    Positioned(

                      top: 12,

                      right: 12,

                      child: Container(

                        width: 42,

                        height: 42,

                        decoration: BoxDecoration(

                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(50),

                        ),

                        child: IconButton(

                          splashRadius: 20,

                          onPressed: () {

                            // Wishlist Later

                          },

                          icon: const Icon(

                            Icons.favorite_border,

                            color: Colors.red,

                            size: 22,

                          ),

                        ),

                      ),

                    ),                    //----------------------------------
                    // FEATURED BADGE
                    //----------------------------------

                    if (book.featured)
                      Positioned(
                        top: 14,
                        left: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius:
                                BorderRadius.circular(30),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Featured",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),                    //----------------------------------
                    // BEST SELLER
                    //----------------------------------

                    if (book.bestSeller)
                      Positioned(
                        bottom: 18,
                        left: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "🔥 Best Seller",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),                    //----------------------------------
                    // NEW ARRIVAL
                    //----------------------------------

                    if (book.newArrival)
                      Positioned(
                        bottom: 18,
                        right: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "NEW",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),                  ],
                ),
              ),              //----------------------------------
              // DETAILS
              //----------------------------------

              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    14,
                    14,
                    14,
                    14,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      // CATEGORY

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary
                              .withOpacity(.10),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: Text(
                          book.category,
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // TITLE

                      Text(
                        book.title,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // AUTHOR

                      Text(
                        "by ${book.author}",
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),

                      const Spacer(),

                      //----------------------------------
                      // RATING
                      //----------------------------------

                      Row(
                        children: [

                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),

                          const SizedBox(width: 5),

                          Text(
                            book.rating
                                .toStringAsFixed(1),
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const Spacer(),

                          Text(
                            "\$${book.price.toStringAsFixed(2)}",
                            style:
                                const TextStyle(
                              color:
                                  AppColors.primary,
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      //----------------------------------
                      // ADD TO CART BUTTON
                      //----------------------------------

                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton.icon(
                          onPressed: () {

                            // Cart Later

                          },
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 18,
                          ),
                          label: const Text(
                            "Add to Cart",
                          ),
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.primary,
                            foregroundColor:
                                Colors.white,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }  //--------------------------------------------------
  // PLACEHOLDER
  //--------------------------------------------------

  Widget _placeholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff6C4EF6),
            Color(0xff8B6CFF),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
                size: 55,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "No Cover",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Book Store",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}