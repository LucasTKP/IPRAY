import 'package:flutter/material.dart';
import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/pages/home/widgets/calendar/calendar_controller.dart';
import 'package:ipray/shared/app_navigator.dart';

class DialogSelectDayController extends ChangeNotifier {
  final PrayController prayController;
  final DateTime daySelected;
  final CalendarController calendarController;
  final AppNavigator appNavigator;

  DialogSelectDayController({
    required this.prayController,
    required this.daySelected,
    required this.calendarController,
    required this.appNavigator,
  }) {
    setPraySelected(prayController.existsPrayInCache(daySelected));
  }

  late bool praySelected;

  Future handleClickButtonSave() async{
    if (praySelected) {
       calendarController.processResponseDialogSelectDay(daySelected, true);
    } else {
       calendarController.processResponseDialogSelectDay(daySelected, false);
    }
    appNavigator.navigatePop();
  }

  setPraySelected(bool value) {
    praySelected = value;
    notifyListeners();
  }
}
