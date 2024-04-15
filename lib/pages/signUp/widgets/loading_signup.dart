import 'package:flutter/material.dart';
import 'package:ipray/components/loading.dart';
import 'package:ipray/pages/signup/signup_controller.dart';

class LoadingSignUp extends StatelessWidget {
  const LoadingSignUp({super.key, required this.signUpController});
  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: signUpController,
      builder: (_, child) {
        return Visibility(
          visible: signUpController.isLoading,
          child: const Loading(),
        );
      },
    );
  }
}
