abstract class DateTimeController {
  DateTime getNow();
}

class DateTimeControllerImpl extends DateTimeController {
  @override
  DateTime getNow() {
    return DateTime.now();
  }
}
