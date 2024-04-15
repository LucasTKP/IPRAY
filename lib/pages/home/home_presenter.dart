import 'package:flutter/widgets.dart';
import 'package:ipray/pages/home/home_controller.dart';
import 'package:ipray/pages/home/home_page.dart';

class HomePresenter extends StatefulWidget {
  const HomePresenter({super.key});

  @override
  State<HomePresenter> createState() => _HomePresenterState();
}

class _HomePresenterState extends State<HomePresenter> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(homeController: homeController);
  }
}
