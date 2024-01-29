import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gifter/pages/home/view/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3),
            ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context)=> const Home()), (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff19a29a),
      body: Center(child: Image.asset('assets/app_icon.png'),),
    );
  }
}
