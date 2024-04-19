import 'package:ipray/pages/home/widgets/calendar/calendar_controller.dart';

class MockCalendarController extends CalendarController{
  @override
  Future<String> getDayIcon(DateTime day) {
    // TODO: implement getDayIcon
    throw UnimplementedError();
  }

  @override
  onDaySelected(DateTime selectedDay) {
    // TODO: implement onDaySelected
    throw UnimplementedError();
  }

  @override
  void processResponseDialogSelectDay(DateTime selectedDay, bool? response) => onProcessResponseDialogSelectDay(selectedDay, response);
  Function(DateTime selectedDay, bool? response) onProcessResponseDialogSelectDay = (selectedDay, response) => throw UnimplementedError();
}