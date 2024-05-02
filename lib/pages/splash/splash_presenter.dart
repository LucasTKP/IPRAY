import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/pages/splash/splash_controller.dart';
import 'package:ipray/pages/splash/splash_page.dart';
import 'package:ipray/shared/dependencies.dart';

class SplashPresenter extends StatefulWidget {
  const SplashPresenter({super.key});

  @override
  State<SplashPresenter> createState() => _SplashPresenterState();
}

class _SplashPresenterState extends State<SplashPresenter> {
  late SplashController splashController;

  @override
  void initState() {
    super.initState();
    splashController = SplashController(
      supabaseController: Dependencies.instance.get(),
      appNavigator: Dependencies.instance.get(),
    );
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      if (await splashController.verifyVersionApp()) {
        Dependencies.instance.get<UserController>().verifyUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: splashController,
        builder: (context, child) {
          return SplashPage(
            splashController: splashController,
          );
        });
  }
}
