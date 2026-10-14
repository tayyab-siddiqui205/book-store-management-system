import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../navigation/bottom_nav_screen.dart';

import 'widgets/auth_background.dart';
import 'widgets/auth_logo.dart';
import 'widgets/auth_textfield.dart';
import 'widgets/auth_button.dart';

class SignupScreen extends StatefulWidget {
  final String email;

  const SignupScreen({
    super.key,
    required this.email,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register() async {

    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }

    if (passwordController.text !=
        confirmPasswordController.text) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      return;
    }

    final authProvider =
        Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final success =
        await authProvider.register(

      firstName:
          firstNameController.text.trim(),

      lastName:
          lastNameController.text.trim(),

      phone:
          phoneController.text.trim(),

      email:
          emailController.text.trim(),

      password:
          passwordController.text.trim(),

    );

    if (!mounted) return;

    if (success) {

      Navigator.pushAndRemoveUntil(

        context,

        MaterialPageRoute(

          builder: (_) =>
              const BottomNavScreen(),

        ),

        (route) => false,

      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(

            authProvider.error ??
                "Registration Failed",

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

            const SizedBox(height: 40),

            const AuthLogo(),

            const SizedBox(height: 35),

            AuthTextField(
              controller: firstNameController,
              hint: "First Name",
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 18),

            AuthTextField(
              controller: lastNameController,
              hint: "Last Name",
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 18),

            AuthTextField(
              controller: phoneController,
              hint: "Phone Number",
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 18),

            AuthTextField(
              controller: emailController,
              hint: "Email",
              icon: Icons.email_outlined,
              keyboardType:
                  TextInputType.emailAddress,
            ),

            const SizedBox(height: 18),

            AuthTextField(
              controller: passwordController,
              hint: "Password",
              icon: Icons.lock_outline,
              obscureText: obscurePassword,

              suffixIcon: IconButton(

                onPressed: () {

                  setState(() {

                    obscurePassword =
                        !obscurePassword;

                  });

                },

                icon: Icon(

                  obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,

                ),

              ),

            ),

            const SizedBox(height: 18),

            AuthTextField(
              controller:
                  confirmPasswordController,

              hint: "Confirm Password",

              icon: Icons.lock_outline,

              obscureText: obscureConfirm,

              suffixIcon: IconButton(

                onPressed: () {

                  setState(() {

                    obscureConfirm =
                        !obscureConfirm;

                  });

                },

                icon: Icon(

                  obscureConfirm
                      ? Icons.visibility_off
                      : Icons.visibility,

                ),

              ),

            ),

            const SizedBox(height: 35),

            AuthButton(

              title: authProvider.loading
                  ? "Creating Account..."
                  : "Create Account",

              onPressed:
                  authProvider.loading
                      ? null
                      : register,

            ),

            const SizedBox(height: 40),

          ],

        ),

      ),

    );

  }

}