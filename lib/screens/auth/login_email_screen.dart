import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../navigation/bottom_nav_screen.dart';
import 'password_screen.dart';
import 'signup_screen.dart';

import 'widgets/auth_background.dart';
import 'widgets/auth_logo.dart';
import 'widgets/auth_textfield.dart';
import 'widgets/auth_button.dart';
import 'widgets/social_button.dart';
import 'widgets/or_divider.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() =>
      _LoginEmailScreenState();
}

class _LoginEmailScreenState
    extends State<LoginEmailScreen> {
  final TextEditingController emailController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> continuePressed() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter your email"),
        ),
      );
      return;
    }

    final authProvider =
        Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final exists =
        await authProvider.continueWithEmail(email);

    if (!mounted) return;

    if (exists) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PasswordScreen(
            email: email,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SignupScreen(
            email: email,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthProvider>(context);

    return AuthBackground(
      child: SingleChildScrollView(
        physics:
            const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),
        child: Column(
          children: [

            const SizedBox(height: 60),

            const AuthLogo(),

            const SizedBox(height: 50),

            AuthTextField(
              controller: emailController,
              hint: "Phone number or email",
              icon: Icons.email_outlined,
              keyboardType:
                  TextInputType.emailAddress,
            ),

            const SizedBox(height: 25),

            AuthButton(
              title: authProvider.loading
                  ? "Please Wait..."
                  : "Continue",
              onPressed: authProvider.loading
                  ? null
                  : continuePressed,
            ),

            const SizedBox(height: 25),

            const Text(
              "We'll send a confirmation code by text or email.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 35),

            const OrDivider(),

            const SizedBox(height: 35),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [

                SocialButton(
                  onTap: () async {

                    final success =
                        await authProvider.googleLogin();

                    if (!mounted) return;

                    if (success) {

                      if (authProvider.role ==
                          "admin") {

                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                const BottomNavScreen(),

                          ),

                        );

                      } else {

                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                const BottomNavScreen(),

                          ),

                        );

                      }

                    } else {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        SnackBar(
                          content: Text(
                            authProvider.error ??
                                "Google Login Failed",
                          ),
                        ),

                      );

                    }
                  },
                  child: Image.asset(
                    "assets/images/google.png",
                    height: 32,
                  ),
                ),

                const SizedBox(width: 20),

                SocialButton(
                  onTap: () {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          "Facebook Login Coming Soon",
                        ),
                      ),

                    );

                  },
                  child: const Icon(
                    Icons.facebook,
                    size: 35,
                    color: Colors.blue,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}