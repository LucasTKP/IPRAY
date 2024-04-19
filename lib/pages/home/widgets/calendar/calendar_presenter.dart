import 'package:flutter/material.dart';
import 'package:ipray/controllers/date_time_controller.dart';
import 'package:ipray/pages/home/widgets/calendar/calendar_controller.dart';
import 'package:ipray/pages/home/widgets/calendar/calendar.dart';
import 'package:ipray/pages/home/widgets/dialog_select_day/dialog_presenter.dart';
import 'package:ipray/shared/dependencies.dart';

class CalendarPresenter extends StatefulWidget {
  const CalendarPresenter({super.key});

  @override
  State<CalendarPresenter> createState() => _CalendarPresenterState();
}

class _CalendarPresenterState extends State<CalendarPresenter> {
  late final CalendarController calendarController;

  @override
  void initState() {
    super.initState();
    calendarController = CalendarControllerImp(
      showDialogSelectDay: showDialogSelectDay,
      prayController: Dependencies.instance.get(),
      userController: Dependencies.instance.get(),
      appNavigator: Dependencies.instance.get(),
      dateTimeController: Dependencies.instance.get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: calendarController,
      builder: ((context, child) => Calendar(
            onDaySelected: calendarController.onDaySelected,
            getDayIcon: calendarController.getDayIcon,
            firstDay: calendarController.firstDay,
            lastDay: calendarController.lastDay,
            dateNow: Dependencies.instance.get<DateTimeController>().getNow(),
          )),
    );
  }

  showDialogSelectDay(DateTime daySelected) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogSelectDayPresenter(
          daySelected: daySelected,
          calendarController: calendarController,
        );
      },
    );
  }
}
