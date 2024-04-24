import 'package:flutter/material.dart';
import 'package:ipray/pages/routes/routes_presenter.dart';
import 'package:ipray/pages/signin/signin_presenter.dart';
import 'package:ipray/pages/signup/signup_presenter.dart';

abstract class AppNavigator {
  navigateToSignup();
  navigateToSignin();
  navigatePop();
  navigateToRoutes();
  showError(String errorMessage);
}

class AppNavigatorImpl extends AppNavigator {
  final BuildContext context;

  AppNavigatorImpl({required this.context});
  @override
  navigateToSignin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPresenter()));
  }

  @override
  navigateToSignup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPresenter()));
  }

  @override
  navigateToRoutes() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RoutesPresenter()));
  }

  @override
  navigatePop() {
    Navigator.of(context).pop();
  }

  @override
  showError(String errorMessage) {
    final snackBar = SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
