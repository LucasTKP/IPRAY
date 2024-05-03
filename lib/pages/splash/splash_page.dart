import 'package:flutter/material.dart';
import 'package:ipray/pages/splash/components/alert_box_version_app/alert_box_presenter.dart';
import 'package:ipray/pages/splash/splash_controller.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatelessWidget {
  final SplashController splashController;
  const SplashPage({super.key, required this.splashController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFE9A5),
                  Color(0xFFFFFFFF),
                ],
              ),
            ),
            child: Center(
              child: Lottie.asset('assets/lotties/lottieSplashPage.json'),
            ),
          ),
          Visibility(visible: splashController.differentVersionApp, child: const AlertBoxPresenter())
        ],
      ),
    );
  }
}
