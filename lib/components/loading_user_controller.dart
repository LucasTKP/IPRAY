import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';

class LoadingUserController extends StatefulWidget {
  const LoadingUserController({super.key, required this.controller});
  final UserController controller;

  @override
  State<LoadingUserController> createState() => _LoadingState();
}

class _LoadingState extends State<LoadingUserController> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.isLoading,
      builder: (context, isLoadingValue, child) {
        return Visibility(
          visible: isLoadingValue,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.6),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 246, 217)),
              ),
            ),
          ),
        );
      },
    );
  }
}
