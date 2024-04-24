import 'package:flutter/material.dart';
import 'package:ipray/pages/splash/components/alert_box_version_app/alert_box_controller.dart';
import 'package:ipray/pages/splash/components/alert_box_version_app/alert_box_page.dart';
import 'package:ipray/shared/dependencies.dart';

class AlertBoxPresenter extends StatefulWidget {
  const AlertBoxPresenter({super.key});

  @override
  State<AlertBoxPresenter> createState() => _AlertBoxPresenterState();
}

class _AlertBoxPresenterState extends State<AlertBoxPresenter> {
  late AlertBoxController alertBoxController;

  @override
  void initState() {
    super.initState();
    alertBoxController = AlertBoxController(supabaseController: Dependencies.instance.get());
  }

  @override
  Widget build(BuildContext context) {
    return AlertBoxPage(alertBoxController: alertBoxController);
  }
}
