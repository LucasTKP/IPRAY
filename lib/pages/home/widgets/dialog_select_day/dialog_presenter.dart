import 'package:flutter/material.dart';
import 'package:ipray/pages/home/widgets/calendar/calendar_controller.dart';
import 'package:ipray/pages/home/widgets/dialog_select_day/dialog.dart';
import 'package:ipray/pages/home/widgets/dialog_select_day/dialog_controller.dart';
import 'package:ipray/shared/dependencies.dart';

class DialogSelectDayPresenter extends StatefulWidget {
  final DateTime daySelected;
  final CalendarController calendarController;

  const DialogSelectDayPresenter({super.key, required this.daySelected, required this.calendarController});

  @override
  State<DialogSelectDayPresenter> createState() => _DialogSelectDayPresenterState();
}

class _DialogSelectDayPresenterState extends State<DialogSelectDayPresenter> {
  late DialogSelectDayController dialogSelectDayController;

  @override
  void initState() {
    super.initState();
    dialogSelectDayController = DialogSelectDayController(
      daySelected: widget.daySelected,
      prayController: Dependencies.instance.get(),
      appNavigator: Dependencies.instance.get(),
      calendarController: widget.calendarController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: dialogSelectDayController,
      builder: (context, child) {
        return DialogSelectDay(daySelected: widget.daySelected, dialogSelectDayController: dialogSelectDayController);
      },
    );
  }
}
