import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lcpl_academy/provider/home_index_provider.dart';
import 'package:lcpl_academy/provider/loading_provider.dart';
import 'package:lcpl_academy/provider/password_visibility_provider.dart';
import 'package:lcpl_academy/screens/authscreens/login_screen.dart';
import 'package:lcpl_academy/theme/theme.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => PasswordVisibilityProvider()),
      ChangeNotifierProvider(create: (context) => HomeIndexProvider()),
    ],
    child: MaterialApp(
      home: const LoginScreen(),
      theme: AppTheme.lightTheme,
    ),
  ));
}
