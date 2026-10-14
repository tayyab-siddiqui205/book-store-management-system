// import 'package:flutter/material.dart';

// import 'admin_logo.dart';
// import 'admin_menu_item.dart';

// class AdminSidebar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onChanged;

//   const AdminSidebar({
//     super.key,
//     required this.selectedIndex,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color(0xff5F35F5),
//             Color(0xff4527D8),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 20,
//           ),
//           child: Column(
//             children: [
//               const AdminLogo(),

//               const SizedBox(height: 30),

//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       AdminMenuItem(
//                         icon: Icons.home_rounded,
//                         title: "Dashboard",
//                         selected: selectedIndex == 0,
//                         onTap: () => onChanged(0),
//                       ),

//                       const SizedBox(height: 8),

//                       AdminMenuItem(
//                         icon: Icons.menu_book_rounded,
//                         title: "Books",
//                         selected: selectedIndex == 1,
//                         onTap: () => onChanged(1),
//                       ),

//                       const SizedBox(height: 8),

//                       AdminMenuItem(
//                         icon: Icons.category_rounded,
//                         title: "Categories",
//                         selected: selectedIndex == 2,
//                         onTap: () => onChanged(2),
//                       ),

//                       const SizedBox(height: 8),

//                       AdminMenuItem(
//                         icon: Icons.shopping_cart_rounded,
//                         title: "Orders",
//                         selected: selectedIndex == 3,
//                         onTap: () => onChanged(3),
//                       ),

//                       const SizedBox(height: 8),

//                       AdminMenuItem(
//                         icon: Icons.people_alt_rounded,
//                         title: "Users",
//                         selected: selectedIndex == 4,
//                         onTap: () => onChanged(4),
//                       ),

//                       const SizedBox(height: 8),

//                       AdminMenuItem(
//                         icon: Icons.star_rounded,
//                         title: "Reviews",
//                         selected: selectedIndex == 5,
//                         onTap: () => onChanged(5),
//                       ),

//                       const SizedBox(height: 8),

//                       AdminMenuItem(
//                         icon: Icons.discount_rounded,
//                         title: "Coupons",
//                         selected: selectedIndex == 6,
//                         onTap: () => onChanged(6),
//                       ),

//                       const SizedBox(height: 8),

//                       AdminMenuItem(
//                         icon: Icons.bar_chart_rounded,
//                         title: "Reports",
//                         selected: selectedIndex == 7,
//                         onTap: () => onChanged(7),
//                       ),

//                       const SizedBox(height: 8),

//                       AdminMenuItem(
//                         icon: Icons.settings_rounded,
//                         title: "Settings",
//                         selected: selectedIndex == 8,
//                         onTap: () => onChanged(8),
//                       ),

//                       const SizedBox(height: 30),

//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(.12),
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: const Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 20,
//                               backgroundColor: Colors.white,
//                               child: Icon(
//                                 Icons.person,
//                                 color: Color(0xff5F35F5),
//                               ),
//                             ),

//                             SizedBox(width: 10),

//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Admin",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 14,
//                                     ),
//                                   ),

//                                   SizedBox(height: 2),

//                                   Text(
//                                     "admin@bookstore.com",
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.white70,
//                                       fontSize: 11,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             Icon(
//                               Icons.keyboard_arrow_down,
//                               color: Colors.white,
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'admin_logo.dart';
import 'admin_menu_item.dart';

class AdminSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const AdminSidebar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final menus = [
      {"icon": Icons.home_rounded, "title": "Dashboard"},
      {"icon": Icons.menu_book_rounded, "title": "Books"},
      {"icon": Icons.category_rounded, "title": "Categories"},
      {"icon": Icons.shopping_cart_rounded, "title": "Orders"},
      {"icon": Icons.people_alt_rounded, "title": "Users"},
      {"icon": Icons.star_rounded, "title": "Reviews"},
      {"icon": Icons.discount_rounded, "title": "Coupons"},
      {"icon": Icons.bar_chart_rounded, "title": "Reports"},
      {"icon": Icons.settings_rounded, "title": "Settings"},
    ];

    return Container(
      width: 280,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff5F35F5),
            Color(0xff4527D8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AdminLogo(),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: menus.length,
                itemBuilder: (context, index) {
                  return AdminMenuItem(
                    icon: menus[index]["icon"] as IconData,
                    title: menus[index]["title"] as String,
                    selected: selectedIndex == index,
                    onTap: () {
                      debugPrint("Sidebar Click : $index");
                      onChanged(index);
                    },
                  );
                },
              ),
            ),

            const Divider(
              color: Colors.white24,
              height: 1,
            ),

            Container(
              padding: const EdgeInsets.all(16),
              child: const Row(
                children: [

                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Color(0xff5F35F5),
                    ),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Admin",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 2),

                        Text(
                          "admin@bookstore.com",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}