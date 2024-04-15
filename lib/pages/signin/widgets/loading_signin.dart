import 'package:flutter/material.dart';
import 'package:ipray/components/loading.dart';
import 'package:ipray/pages/signin/signin_controller.dart';

class LoadingSignIn extends StatelessWidget {
  const LoadingSignIn({super.key, required this.signInController});
  final SignInController signInController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: signInController,
      builder: (_, child) {
        return Visibility(
          visible: signInController.isLoading,
          child: const Loading(),
        );
      },
    );
  }
}
