import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapfirst/authentication/auth_gate.dart';
import 'package:tapfirst/providers/auth_provider.dart' as user_auth_provider;
import 'package:tapfirst/providers/firebase_remote_config_provider.dart';
import 'package:tapfirst/providers/news_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => user_auth_provider.AuthProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => FirebaseRemoteConfigProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter News App',
        home: AuthGate(),
      ),
    );
  }
}
