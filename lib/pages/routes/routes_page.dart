import 'package:flutter/material.dart';
import 'package:ipray/components/navigation_bar_widget.dart';
import 'package:ipray/pages/routes/routes_controller.dart';

class RoutesPage extends StatelessWidget {
  final RoutesController routesController;

  const RoutesPage({super.key, required this.routesController});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: NavigationBarWidget(routesController: routesController),
          body: routesController.pages[routesController.pageIndex]

        ),
      ),
    );
  }
}