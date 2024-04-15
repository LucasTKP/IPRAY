import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/shared/dependencies.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Dependencies.instance.get();
    return AnimatedBuilder(
        animation: userController,
        builder: (_, child) {
          return Container(
            decoration: const BoxDecoration(color: Color(0xFFEBE0BA)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text('🙏 ${userController.getPrayDays()}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)), const Text('Rezados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text('😭${userController.getLostDays()}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)), const Text('Perdidos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))],
                  )
                ],
              ),
            ),
          );
        });
  }
}
