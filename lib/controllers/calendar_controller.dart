import 'package:flutter/material.dart';
import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/models/users_models.dart';

class CalendarController extends ChangeNotifier {
  DateTime firstDay = DateTime.utc(2024, 1, 1);
  DateTime lastDay = DateTime.utc(2030, 3, 14);
  DateTime dateNow = DateTime.now();

  final Function(String messageError) onError;
  final Future<bool?> Function(DateTime daySelected) showDialogSelectDay;
  final UserIpray user;
  final PrayController prayController;

  CalendarController({
    required this.onError,
    required this.showDialogSelectDay,
    required this.user,
    required this.prayController,
  }) {
    prayController.addListener(notifyListeners);
  }

  @override
  void dispose() {
    super.dispose();
    prayController.removeListener(notifyListeners);
  }

  DateTime get createdDateUser => user.createdDate.subtract(const Duration(days: 1));

  onDaySelected(DateTime selectedDay) {
    if (selectedDay.isBefore(createdDateUser) || selectedDay.isAfter(dateNow)) {
      return onError("Você só pode selecionar algum dia entre o seu cadastro e  o dia de hoje");
    }

    showDialogSelectDay(selectedDay).then((response) => processResponseDialogSelectDay(selectedDay, response));
  }

  Future<String> getDayIcon(DateTime day) async {
    String response = "";

    if (dateNow.isAfter(day) && createdDateUser.isBefore(day)) {
      final result = await prayController.existsPray(day, user.praies);
      response = result ? '🙏' : '😭';
    }
    return response;
  }

  void processResponseDialogSelectDay(DateTime selectedDay, bool? response) async {
    if (response == null) return;

    if (response == true) {
      await prayController.createPray(selectedDay, user.id);
    } else {
      await prayController.deletePray(selectedDay, user.id);
    }
  }
}
