import 'package:ipray/controllers/date_time_controller.dart';

class MockDateTimeController extends DateTimeController {
  @override
  DateTime getNowZeroTime() => onGetNowZeroTime();
  DateTime Function() onGetNowZeroTime = () => throw UnimplementedError();
}
