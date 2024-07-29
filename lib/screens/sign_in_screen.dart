import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapfirst/providers/auth_provider.dart' as user_auth_provider;
import 'package:tapfirst/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tapfirst/utils/app_colors.dart';
import 'package:tapfirst/widgets/build_text_field_widget.dart';
import 'package:tapfirst/widgets/custom_button_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Provider.of<user_auth_provider.AuthProvider>(context, listen: false)
          .setIsSignedIn();
    } on FirebaseAuthException catch (e) {
      debugPrint('Error while signing in : $e');
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      // handle other errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'MyNews',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const Spacer(),
              const SizedBox(height: 16),
              buildTextFieldWidget(_emailController, 'Email'),
              const SizedBox(height: 16),
              buildTextFieldWidget(_passwordController, 'Password',
                  isPassword: true),
              const Spacer(),
              CustomButtonWidget(
                  text: 'Sign in',
                  onPressed: () {
                    _signIn(context);
                  }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New here?'),
                  TextButton(
                    child: const Text('Sign up'),
                    onPressed: () {
                      // Navigate to login page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
