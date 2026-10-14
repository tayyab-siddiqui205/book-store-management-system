import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../auth/login_email_screen.dart';

import 'widgets/profile_header.dart';
import 'widgets/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    final user = auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Row(
                children: [

                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 30),

              ProfileHeader(
                name: user?.displayName?.isNotEmpty == true
                    ? user!.displayName!
                    : (user?.email?.split("@").first ?? "Book Store User"),

                email: user?.email ?? "",

                memberSince: "Member Since 2026",

                onNotification: () {},
              ),

              const SizedBox(height: 30),
                            //===========================
              // ACCOUNT
              //===========================

              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              ProfileTile(
                icon: Icons.shopping_bag_outlined,
                title: "My Orders",
                subtitle: "Track your orders",
                onTap: () {},
              ),

              ProfileTile(
                icon: Icons.favorite_outline,
                title: "Wishlist",
                subtitle: "Books you saved",
                onTap: () {},
              ),

              ProfileTile(
                icon: Icons.location_on_outlined,
                title: "Saved Addresses",
                subtitle: "Manage delivery address",
                onTap: () {},
              ),

              ProfileTile(
                icon: Icons.person_outline,
                title: "Edit Profile",
                subtitle: "Update your personal information",
                onTap: () {},
              ),

              const SizedBox(height: 28),

              //===========================
              // SETTINGS
              //===========================

              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              ProfileTile(
                icon: Icons.lock_outline_rounded,
                title: "Security",
                subtitle: "Password & account settings",
                onTap: () {},
              ),

              ProfileTile(
                icon: Icons.notifications_none_rounded,
                title: "Notifications",
                subtitle: "Manage notifications",
                onTap: () {},
              ),

              ProfileTile(
                icon: Icons.help_outline_rounded,
                title: "Help Center",
                subtitle: "Support & FAQs",
                onTap: () {},
              ),

              ProfileTile(
                icon: Icons.info_outline_rounded,
                title: "About App",
                subtitle: "Version 1.0.0",
                onTap: () {},
              ),

              const SizedBox(height: 30),
            //===========================
// LOGOUT
//===========================

ProfileTile(
  icon: Icons.logout_rounded,
  title: "Logout",
  subtitle: "Sign out from your account",
  iconColor: Colors.red,
  textColor: Colors.red,
  showArrow: false,
  onTap: () async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Logout"),
          content: const Text(
            "Are you sure you want to logout?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );

    if (result != true) return;

    try {
      await auth.logout();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Logout Successful"),
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LoginEmailScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      debugPrint("Logout Error: $e");

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Logout Failed\n$e"),
        ),
      );
    }
  },
),

              const SizedBox(height: 40),

            ],
          ),
        ),
      ),
    );
  }
}