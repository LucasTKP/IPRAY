import 'package:ipray/utils/formatter_date.dart';

abstract class DateTimeController {
  DateTime getNowZeroTime();
}

class DateTimeControllerImp extends DateTimeController {
  @override
  DateTime getNowZeroTime() {
    DateTime dateNow = DateTime.now();
    dateNow = dateNow.formatDate();
    return dateNow;
  }
}
