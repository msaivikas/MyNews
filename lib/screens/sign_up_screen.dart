import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapfirst/providers/auth_provider.dart' as user_auth_provider;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tapfirst/screens/sign_in_screen.dart';
import 'package:tapfirst/utils/app_colors.dart';
import 'package:tapfirst/widgets/build_text_field_widget.dart';
import 'package:tapfirst/widgets/custom_button_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp(BuildContext context) async {
    try {
      // create user with email and password
      // UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // store user info in Firestore collection 'users'
      final data = {
        "email": _emailController.text,
        "name": _nameController.text
      };
      await FirebaseFirestore.instance.collection('users').add(data);

      Provider.of<user_auth_provider.AuthProvider>(context, listen: false)
          .setIsSignedIn();

      Navigator.pop(
          context); // this'll take to sign in screen which signs you in automatically
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'An account already exists for that email.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'MyNews',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
                textAlign: TextAlign.start,
              ),
              const Spacer(),
              buildTextFieldWidget(_nameController, 'Name'),
              const SizedBox(height: 16),
              buildTextFieldWidget(_emailController, 'Email'),
              const SizedBox(height: 16),
              buildTextFieldWidget(_passwordController, 'Password',
                  isPassword: true),
              const Spacer(),
              CustomButtonWidget(
                  text: 'Sign up',
                  onPressed: () {
                    _signUp(context);
                  }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    child: const Text('Login'),
                    onPressed: () {
                      // Navigate to login page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
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
