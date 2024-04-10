import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/models/users_models.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (_, controller, child) {
      UserIpray? user = controller.user;

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
                children: [
                  Text('🙏 ${user != null ? user.total.toString() : ""}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700)),
                  const Text('Rezados',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
                ],
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Text(
              //       '🔥12',
              //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              //     ),
              //     Text('Seguidos',
              //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
              //   ],
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('😭${controller.getLostDays()}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700)),
                  const Text('Perdidos',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
