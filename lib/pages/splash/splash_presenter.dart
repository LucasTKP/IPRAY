import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/pages/splash/splash_page.dart';
import 'package:ipray/shared/dependencies.dart';

class SplashPresenter extends StatefulWidget {
  const SplashPresenter({super.key});

  @override
  State<SplashPresenter> createState() => _SplashPresenterState();
}

class _SplashPresenterState extends State<SplashPresenter> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      Dependencies.instance.get<UserController>().verifyUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }
}
