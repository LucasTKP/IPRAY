import 'package:flutter_test/flutter_test.dart';
import 'package:ipray/pages/home/widgets/dialog_select_day/dialog_controller.dart';

import '../../mock/mock_app_navigator.dart';
import '../../mock/mock_calendar_controller.dart';
import '../../mock/mock_pray_controller.dart';

void main() {
  late DialogSelectDayController controller;
  late MockPrayController prayController;
  late MockCalendarController calendarController;
  late MockAppNavigator appNavigator;

  setUp(() {
    appNavigator = MockAppNavigator();
    prayController = MockPrayController();
    calendarController = MockCalendarController();

    prayController.onExistsPrayInCache = (DateTime dateSelected){
      return true;
    };

    controller = DialogSelectDayController(
      prayController: prayController,
      appNavigator: appNavigator,
      daySelected: DateTime.now(),
      calendarController: calendarController,
    );
  });

  test("DialogController.handleClickButtonSave(praySelected = false)", (){
    // Arrange
    controller.praySelected = false;

    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    bool onProcessResponseDialogSelectDayCalled = false;
    calendarController.onProcessResponseDialogSelectDay = (DateTime dateSelected, bool? response) async{
      onProcessResponseDialogSelectDayCalled = true;
    };

    bool onNavigatePopDayCalled = false;
    appNavigator.onNavigatePop = (){
      onNavigatePopDayCalled = true;
    };

    // Act
    controller.handleClickButtonSave();

    // Assert
    expect(notifyListenerCalled, false);
    expect(onProcessResponseDialogSelectDayCalled, true);
    expect(onNavigatePopDayCalled, true);
  });


  test("DialogController.handleClickButtonSave(praySelected = true)", (){
    // Arrange
    controller.praySelected = true;

    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    bool onProcessResponseDialogSelectDayCalled = false;
    calendarController.onProcessResponseDialogSelectDay = (DateTime dateSelected, bool? response) async{
      onProcessResponseDialogSelectDayCalled = true;
    };

    bool onNavigatePopDayCalled = false;
    appNavigator.onNavigatePop = (){
      onNavigatePopDayCalled = true;
    };

    // Act
     controller.handleClickButtonSave();

    // Assert
    expect(notifyListenerCalled, false);
    expect(onProcessResponseDialogSelectDayCalled, true);
    expect(onNavigatePopDayCalled, true);
  });

  test("DialogController.setPraySelected()", (){
    // Arrange
    controller.praySelected = false;

    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    // Act
    controller.setPraySelected(true);

    // Assert
    expect(controller.praySelected, true);
    expect(notifyListenerCalled, true);
  });
}
