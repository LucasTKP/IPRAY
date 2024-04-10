import 'package:flutter/material.dart';
import 'package:ipray/controllers/calendar_controller.dart';
import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/pages/homePage/widgets/calendar.dart';
import 'package:provider/provider.dart';

class CalendarPresenter extends StatefulWidget {
  const CalendarPresenter({super.key});

  @override
  State<CalendarPresenter> createState() => _CalendarPresenterState();
}

class _CalendarPresenterState extends State<CalendarPresenter> {
  late final CalendarController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CalendarController(
      onError: onError,
      showDialogSelectDay: showDialogSelectDay,
      user: context.read<UserController>().user!,
      prayController: context.read<PrayController>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: ((context, child) => Calendar(
            onDaySelected: controller.onDaySelected,
            getDayIcon: controller.getDayIcon,
            firstDay: controller.firstDay,
            lastDay: controller.lastDay,
            dateNow: controller.dateNow,
          )),
    );
  }

  onError(String messageError) {
    const snackBar = SnackBar(content: Text("Você só pode selecionar algum dia entre o seu cadastro e  o dia de hoje "));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool?> showDialogSelectDay(DateTime daySelected) async {
    return true;
  }
}
