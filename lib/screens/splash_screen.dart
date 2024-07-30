import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lcpl_academy/provider/loading_provider.dart';
import 'package:lcpl_academy/reusablewidgets/multicolor_progress_indicator.dart';
import 'package:lcpl_academy/screens/authscreens/login_screen.dart';
import 'package:lcpl_academy/screens/homescreen/home_screen.dart';
import 'package:lcpl_academy/utils/constants.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
final authProvider = Provider.of<AuthProvider>(context);
    Timer(const Duration(seconds: 2), () {
     if (authProvider.user==null) {
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen(),),);
     }else{
       Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomeScreen(),),);
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(Constants.logo),
            ),
            MulticolorProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
