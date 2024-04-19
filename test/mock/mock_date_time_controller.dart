import 'package:ipray/controllers/date_time_controller.dart';

class MockDateTimeController extends DateTimeController {
  @override
  DateTime getNow() => onGetNow();
  DateTime Function() onGetNow = () => throw UnimplementedError();
}
