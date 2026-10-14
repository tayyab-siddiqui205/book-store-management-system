import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../admin/admin_dashboard.dart';
import '../navigation/bottom_nav_screen.dart';

import 'widgets/auth_background.dart';
import 'widgets/auth_logo.dart';
import 'widgets/auth_textfield.dart';
import 'widgets/auth_button.dart';

class PasswordScreen extends StatefulWidget {
  final String email;

  const PasswordScreen({
    super.key,
    required this.email,
  });

  @override
  State<PasswordScreen> createState() =>
      _PasswordScreenState();
}

class _PasswordScreenState
    extends State<PasswordScreen> {

  final passwordController =
      TextEditingController();

  bool obscure = true;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {

    final authProvider =
        Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final success =
        await authProvider.login(
      email: widget.email,
      password:
          passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {

      if (authProvider.role == "admin") {

        Navigator.pushAndRemoveUntil(

          context,

          MaterialPageRoute(

            builder: (_) =>
                const AdminDashboard(),

          ),

          (route) => false,

        );

      } else {

        Navigator.pushAndRemoveUntil(

          context,

          MaterialPageRoute(

            builder: (_) =>
                const BottomNavScreen(),

          ),

          (route) => false,

        );

      }

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(

            authProvider.error ??
                "Login Failed",

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

        padding:
            const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),

        child: Column(

          children: [

            const SizedBox(height: 60),

            const AuthLogo(),

            const SizedBox(height: 40),

            Container(

              width: double.infinity,

              padding:
                  const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(18),

              ),

              child: Text(

                widget.email,

                style: const TextStyle(

                  fontSize: 16,

                  color: Colors.black87,

                  fontWeight:
                      FontWeight.w600,

                ),

              ),

            ),

            const SizedBox(height: 25),

            AuthTextField(

              controller:
                  passwordController,

              hint: "Password",

              icon: Icons.lock_outline,

              obscureText: obscure,

              suffixIcon: IconButton(

                onPressed: () {

                  setState(() {

                    obscure = !obscure;

                  });

                },

                icon: Icon(

                  obscure
                      ? Icons.visibility_off
                      : Icons.visibility,

                ),

              ),

            ),

            const SizedBox(height: 15),

            Align(

              alignment:
                  Alignment.centerRight,

              child: TextButton(

                onPressed: () async {

                  await authProvider
                      .resetPassword(
                    widget.email,
                  );

                  if (!mounted) return;

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(

                    const SnackBar(

                      content: Text(

                        "Password reset email sent",

                      ),

                    ),

                  );

                },

                child: const Text(

                  "Forgot Password?",

                  style: TextStyle(

                    color:
                        Color(0xff6C4EF6),

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),

              ),

            ),

            const SizedBox(height: 25),

            AuthButton(

              title: authProvider.loading
                  ? "Please Wait..."
                  : "Login",

              onPressed:
                  authProvider.loading
                      ? null
                      : login,

            ),

          ],

        ),

      ),

    );

  }

}