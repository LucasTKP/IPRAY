import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE9A5), // #FFDE78
              Color(0xFFFFFFFF), // #FFFFFF
            ],
          ),
        ),
        child: Center(
          child: Lottie.asset('assets/lotties/lottieSplashPage.json'),
        ),
      ),
    );
  }
}
