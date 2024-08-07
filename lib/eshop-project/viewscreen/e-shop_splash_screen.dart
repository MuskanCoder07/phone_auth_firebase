import 'dart:async';
import 'package:flutter/material.dart';
import 'e-shop_login_screen.dart';

class EshopSplashScreen extends StatefulWidget {
  @override
  _EshopSplashScreenState createState() => _EshopSplashScreenState();
}

class _EshopSplashScreenState extends State<EshopSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const EshopLoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(image: NetworkImage(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQokFEJDX-y0IMgn1hZywgQREANO0MPUkCOuv_oEqCML43W_LiMFqEcLKo5TfewYlxs4BU&usqp=CAU"))
      ),
    );
  }
}

