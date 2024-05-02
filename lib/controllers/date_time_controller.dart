abstract class DateTimeController {
  DateTime getNow();

  DateTime getNowZeroTime();

  DateTime formatDate(DateTime date);
}

class DateTimeControllerImp extends DateTimeController {
  @override
  DateTime getNow() {
    return DateTime.now();
  }

  @override
  DateTime getNowZeroTime() {
    DateTime dateNow = DateTime.now();
    DateTime dateWithZeroTime = DateTime(dateNow.year, dateNow.month, dateNow.day);
    return dateWithZeroTime;
  }

  @override
  DateTime formatDate(DateTime date) {
    DateTime newDate = DateTime(date.year, date.month, date.day);
    return newDate;
  }
}
