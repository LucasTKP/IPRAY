import 'package:flutter/material.dart';
import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/shared/app_navigator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CalendarController extends ChangeNotifier {
  DateTime firstDay = DateTime.utc(2024, 1, 1);
  DateTime lastDay = DateTime.utc(2030, 3, 14);
  DateTime dateNow = DateTime.now();
  final supabase = Supabase.instance.client;

  final Function(DateTime daySelected) showDialogSelectDay;
  final PrayController prayController;
  final UserController userController;
  final AppNavigator appNavigator;

  CalendarController({
    required this.showDialogSelectDay,
    required this.prayController,
    required this.userController,
    required this.appNavigator,
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

  DateTime get createdDateUser => userController.user!.createdDate.subtract(const Duration(days: 1));

  onDaySelected(DateTime selectedDay) {
    if (selectedDay.isBefore(createdDateUser) || selectedDay.isAfter(dateNow)) {
      appNavigator.showError("Você só pode selecionar algum dia entre o seu cadastro e  o dia de hoje");
      return;
    }

    showDialogSelectDay(selectedDay);
  }

  Future<String> getDayIcon(DateTime day) async {
    String response = "";

    if (dateNow.isAfter(day) && createdDateUser.isBefore(day)) {
      final result = await prayController.existsPray(day, userController.user!.id);
      response = result ? '🙏' : '😭';
    }
    return response;
  }

  void processResponseDialogSelectDay(DateTime selectedDay, bool? response) async {
    if (response == null) return;

    if (response == true) {
      userController.addPray(selectedDay);
    } else {
      userController.removePray(selectedDay);
    }
  }
}
