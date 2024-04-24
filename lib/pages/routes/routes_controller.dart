import 'package:flutter/material.dart';
import 'package:ipray/pages/home/home_presenter.dart';
import 'package:ipray/pages/rank/rank_page.dart';

abstract class RoutesController extends ChangeNotifier {
  int pageIndex = 0;

  List<Widget> pages = [const HomePresenter(), const RankPage()];

  changePage(int index);
}

class RoutesControllerImp extends RoutesController {
  @override
  changePage(int index) {
    if (pageIndex != index) {
      pageIndex = index;
      notifyListeners();
    }
  }
}
