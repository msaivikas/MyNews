import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapfirst/providers/auth_provider.dart' as user_auth_provider;
import 'package:tapfirst/screens/home_screen.dart';
import 'package:tapfirst/screens/sign_in_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<user_auth_provider.AuthProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.isSignedIn) {
          return const HomeScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
