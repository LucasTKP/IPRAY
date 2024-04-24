import 'package:flutter/material.dart';
import 'package:ipray/pages/routes/routes_controller.dart';
import 'package:ipray/pages/routes/routes_page.dart';
import 'package:ipray/shared/dependencies.dart';

class RoutesPresenter extends StatefulWidget {
  const RoutesPresenter({super.key});

  @override
  State<RoutesPresenter> createState() => _RoutesPresenterState();
}

class _RoutesPresenterState extends State<RoutesPresenter> {
  late RoutesController routesController;

  @override
  void initState() {
    super.initState();
    routesController = Dependencies.instance.get();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: routesController,
      builder: (_, child) {
        return RoutesPage(routesController: routesController);
      },
    );
  }
}
