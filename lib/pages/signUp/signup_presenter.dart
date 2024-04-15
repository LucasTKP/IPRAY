import 'package:flutter/material.dart';
import 'package:ipray/pages/signup/signup_controller.dart';
import 'package:ipray/pages/signup/signup_page.dart';
import 'package:ipray/shared/dependencies.dart';

class SignUpPresenter extends StatefulWidget {
  const SignUpPresenter({super.key});

  @override
  State<SignUpPresenter> createState() => _SignUpPresenterState();
}

class _SignUpPresenterState extends State<SignUpPresenter> {
  late SignUpController signUpController;

  @override
  void initState() {
    super.initState();
    signUpController = SignUpController(userController: Dependencies.instance.get(), appNavigator: Dependencies.instance.get());
  }

  @override
  Widget build(BuildContext context) {
    return SignupPage(signUpController: signUpController);
  }
}
