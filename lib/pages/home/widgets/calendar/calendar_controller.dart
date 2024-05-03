import 'package:flutter/material.dart';
import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/shared/app_navigator.dart';
import 'package:ipray/utils/formatter_date.dart';

import '../../../../controllers/date_time_controller.dart';

abstract class CalendarController extends ChangeNotifier {
  DateTime firstDay = DateTime.utc(2024, 1, 1);
  DateTime lastDay = DateTime.utc(2030, 3, 14);

  onDaySelected(DateTime selectedDay);

  Future<String> getDayIcon(DateTime day);

  Future processResponseDialogSelectDay(DateTime selectedDay, bool? response);

  String textButtonRegisterPray();
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
    DateTime dateNow = dateTimeController.getNowZeroTime();

    if (dateNow.compareTo(selectedDay.formatDate()) != 0) {
      appNavigator.showError("Você só pode registrar sua reza de hoje!");
      return;
    }

    showDialogSelectDay(selectedDay);
  }

  @override
  Future<String> getDayIcon(DateTime day) async {
    DateTime dateNow = dateTimeController.getNowZeroTime();
    DateTime userCreatedDate = userController.user!.createdDate.formatDate();
    DateTime newDay = day.formatDate();
    String response = "";

    if (userCreatedDate.isBefore(newDay) || userCreatedDate.isAtSameMomentAs(newDay)) {
      if (dateNow.isAfter(newDay) || dateNow.isAtSameMomentAs(newDay)) {
        final result = await prayController.existsPray(newDay, userController.user!.id);
        response = result ? '🙏' : '😭';
      }
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

  @override
  String textButtonRegisterPray() {
    DateTime date= dateTimeController.getNowZeroTime();
    if (prayController.existsPrayInCache(date)) return 'Excluir Reza de hoje';
    return "Cadastrar Reza de hoje";
  }
}
