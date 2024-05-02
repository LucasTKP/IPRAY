import 'package:ipray/controllers/date_time_controller.dart';

class MockDateTimeController extends DateTimeController {
  @override
  DateTime getNow() => onGetNow();
  DateTime Function() onGetNow = () => throw UnimplementedError();
  
  @override
  DateTime getNowZeroTime() => onGetNowZeroTime();
  DateTime Function() onGetNowZeroTime = () => throw UnimplementedError();
  
  @override
  DateTime formatDate(DateTime date) => onFormatDate(date);
  DateTime Function(DateTime date) onFormatDate = (date) => throw UnimplementedError();
}
