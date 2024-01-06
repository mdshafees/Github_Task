// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:github/Helper/userDefault.dart';
import 'package:github/View/HomeScreen.dart';
import 'package:github/View/InitialScreen.dart';
import 'package:github/state/provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  statusOfSplash() async {
    if (!await UserDefault.getLoginStatus()) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const InitialScreen()),
          (Route<dynamic> route) => false);
    } else {
      context.read<ProfileData>().getProfile();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      statusOfSplash();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
            margin: const EdgeInsets.all(100),
            child:const Hero(
              tag: "logo",
              child: const Image(image: AssetImage("assets/logo.png")))),
      ),
    );
  }
}
