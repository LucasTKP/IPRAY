import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:provider/provider.dart';

class LoadingUserController extends StatefulWidget {
  const LoadingUserController({super.key});
  @override
  State<LoadingUserController> createState() => _LoadingState();
}

class _LoadingState extends State<LoadingUserController> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (_, controller, child) {
        return Visibility(
          visible: controller.isLoading,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.6),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 255, 246, 217)),
              ),
            ),
          ),
        );
      },
    );
  }
}
