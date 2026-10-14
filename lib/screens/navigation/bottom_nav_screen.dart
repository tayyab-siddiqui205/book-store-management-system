import 'package:flutter/material.dart';
import 'widgets/custom_bottom_navbar.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 0;

  final pages = const [
    HomeScreen(),

    Center(child: Text("Categories")),

    Center(child: Text("Wishlist")),

    Center(child: Text("Cart")),

    // Center(child: Text("Profile")),
      ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}