import 'package:flutter/material.dart';
import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/shared/app_navigator.dart';

import '../../../../controllers/date_time_controller.dart';

abstract class CalendarController extends ChangeNotifier {
  DateTime firstDay = DateTime.utc(2024, 1, 1);
  DateTime lastDay = DateTime.utc(2030, 3, 14);

  onDaySelected(DateTime selectedDay);

  Future<String> getDayIcon(DateTime day);

  Future processResponseDialogSelectDay(DateTime selectedDay, bool? response);
}

class CalendarControllerImp extends CalendarController {
  final Function(DateTime daySelected) showDialogSelectDay;
  final PrayController prayController;
  final UserController userController;
  final AppNavigator appNavigator;
  final DateTimeController dateTimeController;

  CalendarControllerImp({
    required this.showDialogSelectDay,
    required this.prayController,
    required this.userController,
    required this.appNavigator,
    required this.dateTimeController,
  }) {
    prayController.addListener(notifyListeners);
    userController.addListener(notifyListeners);
  }

  @override
  void dispose() {
    super.dispose();
    prayController.removeListener(notifyListeners);
    userController.removeListener(notifyListeners);
  }

  @override
  onDaySelected(DateTime selectedDay) {
    DateTime dateWithZeroTime = dateTimeController.getNowZeroTime();

    if (dateWithZeroTime.compareTo(selectedDay) != 0) {
      appNavigator.showError("Você só pode registrar sua reza de hoje!");
      return;
    }

    showDialogSelectDay(selectedDay);
  }

  @override
  Future<String> getDayIcon(DateTime day) async {
    DateTime dateNow = dateTimeController.getNow();

    String response = "";

    if (dateNow.isAfter(day) && userController.user!.createdDate.isBefore(day) || userController.user!.createdDate.compareTo(day) == 0) {
      final result = await prayController.existsPray(day, userController.user!.id);
      response = result ? '🙏' : '😭';
    }
    return response;
  }

  @override
  Future processResponseDialogSelectDay(DateTime selectedDay, bool? response) async {
    if (response == null) return;

    if (response == true) {
      userController.addPray(selectedDay);
    } else {
      userController.removePray(selectedDay);
    }
  }
}
