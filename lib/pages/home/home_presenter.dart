import 'package:flutter/widgets.dart';
import 'package:ipray/pages/home/home_controller.dart';
import 'package:ipray/pages/home/home_page.dart';
import 'package:ipray/shared/dependencies.dart';

import '../../variables/variables_bible_phrases.dart';

class HomePresenter extends StatefulWidget {
  const HomePresenter({super.key});

  @override
  State<HomePresenter> createState() => _HomePresenterState();
}

class _HomePresenterState extends State<HomePresenter> {
  late HomeController homeController;
  late VariablesPhrases variablesPhrases;



  @override
  void initState() {
    super.initState();
    variablesPhrases = VariablesPhrases();
    homeController = HomeController(variablesPhrases: variablesPhrases, dateTimeController: Dependencies.instance.get());
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(homeController: homeController);
  }
}
