import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:provider/provider.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({super.key});

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (_, controller, child) {
        return Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFBF9000),
              ),
              child: const Icon(
                Icons.account_circle,
                size: 60,
              ),
            ),
            Container(
              width: 6,
              height: 70,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: 6,
                height: controller.step > 1 ? 70 : 00,
                decoration: const BoxDecoration(
                  color: Color(0xFFBF9000),
                ),
              ),
            ),
            Container(
              width: 70,
              height: 70,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: 70,
                    height: controller.step > 1 ? 70 : 0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFBF9000),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            controller.step > 1
                                ? Colors.black
                                : const Color(0xFF6D6D6D),
                            BlendMode.srcIn),
                        child: SvgPicture.asset(
                          'assets/icons/time.svg',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 6,
              height: 70,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: 6,
                height: controller.step > 2 ? 70 : 00,
                decoration: const BoxDecoration(
                  color: Color(0xFFBF9000),
                ),
              ),
            ),
            Container(
              width: 70,
              height: 70,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: 70,
                    height: controller.step > 2 ? 70 : 0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFBF9000),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            controller.step > 2
                                ? Colors.black
                                : const Color(0xFF6D6D6D),
                            BlendMode.srcIn),
                        child: SvgPicture.asset(
                          'assets/icons/city.svg',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
