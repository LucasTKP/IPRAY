import 'package:flutter/material.dart';
import 'package:ipray/pages/routes/routes_controller.dart';

class NavigationBarWidget extends StatelessWidget {
  final RoutesController routesController;

  const NavigationBarWidget({super.key, required this.routesController});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: 'Rank',

        ),
      ],
      currentIndex: routesController.pageIndex,
      selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      backgroundColor: const Color(0xFFEBE0BA),
      onTap: routesController.changePage,
    );
  }
}
