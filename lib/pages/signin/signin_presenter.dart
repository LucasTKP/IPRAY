import 'package:flutter/material.dart';
import 'package:ipray/pages/signin/signin_controller.dart';
import 'package:ipray/pages/signin/signin_page.dart';
import 'package:ipray/shared/dependencies.dart';

class SignInPresenter extends StatefulWidget {
  const SignInPresenter({super.key});

  @override
  State<SignInPresenter> createState() => _SignInPresenterState();
}

class _SignInPresenterState extends State<SignInPresenter> {
  late SignInController signInController;

  @override
  void initState() {
    super.initState();
    signInController = SignInController(
      userController: Dependencies.instance.get(),
      appNavigator: Dependencies.instance.get(),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return SignInPage(signInController: signInController);
  }
}
