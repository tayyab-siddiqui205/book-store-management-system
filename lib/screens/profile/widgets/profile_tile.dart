import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  final Color iconColor;
  final Color textColor;
  final bool showArrow;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor = const Color(0xff6C4EF6),
    this.textColor = Colors.black,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: Material(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        elevation: 1.2,

        shadowColor: Colors.black12,

        child: InkWell(

          borderRadius: BorderRadius.circular(22),

          onTap: onTap,

          child: Padding(

            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),

            child: Row(

              children: [

                Container(

                  width: 56,
                  height: 56,

                  decoration: BoxDecoration(

                    color: iconColor.withOpacity(.12),

                    borderRadius: BorderRadius.circular(18),

                  ),

                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 28,
                  ),

                ),

                const SizedBox(width: 18),

                Expanded(

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(

                        title,

                        style: TextStyle(

                          fontSize: 17,

                          color: textColor,

                          fontWeight: FontWeight.bold,

                        ),

                      ),

                      const SizedBox(height: 5),

                      Text(

                        subtitle,

                        style: const TextStyle(

                          color: Colors.grey,

                          fontSize: 14,

                        ),

                      ),

                    ],

                  ),

                ),

                if (showArrow)

                  const Icon(

                    Icons.arrow_forward_ios_rounded,

                    size: 18,

                    color: Colors.grey,

                  ),

              ],

            ),

          ),

        ),

      ),

    );
  }
}