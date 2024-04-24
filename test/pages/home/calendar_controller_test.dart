import 'package:flutter_test/flutter_test.dart';
import 'package:ipray/models/users_models.dart';
import 'package:ipray/pages/home/widgets/calendar/calendar_controller.dart';

import '../../mock/mock_app_navigator.dart';
import '../../mock/mock_date_time_controller.dart';
import '../../mock/mock_pray_controller.dart';
import '../../mock/mock_user_controller.dart';

void main() {
  late CalendarController controller;
  late MockPrayController prayController;
  late MockAppNavigator appNavigator;
  late MockUserController userController;
  late MockDateTimeController dateTimeController;

  setUp(() {
    appNavigator = MockAppNavigator();
    userController = MockUserController();
    prayController = MockPrayController();
    dateTimeController = MockDateTimeController();

    controller = CalendarControllerImp(
      showDialogSelectDay: (DateTime daySelected) {},
      prayController: prayController,
      appNavigator: appNavigator,
      userController: userController, dateTimeController: dateTimeController,
    );
  });

  test("CalendarController.onDaySelected(selectedDay.isBefore(userController.user!.createdDate))", () async{
    // Arrange
    userController.user = UserIpray(id: 0,
      name: "teste",
      email: "teste@gmail.com",
      urlImage: "",
      age: 20,
      state: "São Paulo",
      city: "Franca",
      total: 0,
      streak: 0,
      createdDate: DateTime(2024, 4, 15, 0, 0, 0, 0, 0),
    );

    DateTime selectedDay = DateTime(2024, 4, 14, 0, 0, 0, 0, 0);

    dateTimeController.onGetNow = () => DateTime(2024, 4, 18, 0, 0, 0, 0, 0);

    bool error = false;
    appNavigator.onShowError = (value) => {
      error = true
    };

    // Act
    controller.onDaySelected(selectedDay);

    // Assert
    expect(error, true);
  });

  test("CalendarController.onDaySelected(selectedDay.isAfter(dateNow))", () {
    bool notifyListenerCalled = false;

    controller.addListener(() {
      notifyListenerCalled = true;
    });
    // Arrange
    userController.user = UserIpray(id: 0,
      name: "teste",
      email: "teste@gmail.com",
      urlImage: "",
      age: 20,
      state: "São Paulo",
      city: "Franca",
      total: 0,
      streak: 0,
      createdDate: DateTime(2024, 4, 15, 0, 0, 0, 0, 0),
    );

    DateTime selectedDay = DateTime(2024, 4, 20, 0, 0, 0, 0, 0);

    dateTimeController.onGetNow = () => DateTime(2024, 4, 19, 0, 0, 0, 0, 0);

    bool error = false;
    appNavigator.onShowError = (value) => {
      error = true
    };

    // Act
    controller.onDaySelected(selectedDay);

    // Assert
    expect(error, true);
    expect(notifyListenerCalled, false);

  });

  test("CalendarController.getDayIcon(🙏)", () async{
    // Arrange
    userController.user = UserIpray(id: 0,
        name: "teste",
        email: "teste@gmail.com",
        urlImage: "",
        age: 20,
        state: "São Paulo",
        city: "Franca",
        total: 0,
        streak: 0,
        createdDate: DateTime(2024, 4, 16, 0, 0, 0, 0, 0),
    );

    DateTime selectedDay = DateTime(2024, 4, 16, 0, 0, 0, 0, 0);

    dateTimeController.onGetNow = () => DateTime(2024, 4, 18, 0, 0, 0, 0, 0);

    prayController.onExistsPray = (selectedDay, id) async {
      return true;
    };

    // Act
    String icon = await controller.getDayIcon(selectedDay);

    // Assert
    expect(icon, "🙏");
  });

  test("CalendarController.getDayIcon(😭)", () async{
    // Arrange
    bool notifyListenerCalled = false;

    controller.addListener(() {
      notifyListenerCalled = true;
    });

    userController.user = UserIpray(id: 0,
      name: "teste",
      email: "teste@gmail.com",
      urlImage: "",
      age: 20,
      state: "São Paulo",
      city: "Franca",
      total: 0,
      streak: 0,
      createdDate: DateTime(2024, 4, 15, 0, 0, 0, 0, 0),
    );

    DateTime selectedDay = DateTime(2024, 4, 16, 0, 0, 0, 0, 0);

    dateTimeController.onGetNow = () => DateTime(2024, 4, 18, 0, 0, 0, 0, 0);

    prayController.onExistsPray = (selectedDay, id) async {
      return false;
    };

    // Act
    String icon = await controller.getDayIcon(selectedDay);

    // Assert
    expect(icon, "😭");
    expect(notifyListenerCalled, false);
  });

  test("CalendarController.getDayIcon(dateNow.isAfter(day))", () async{
    // Arrange
    userController.user = UserIpray(id: 0,
      name: "teste",
      email: "teste@gmail.com",
      urlImage: "",
      age: 20,
      state: "São Paulo",
      city: "Franca",
      total: 0,
      streak: 0,
      createdDate: DateTime(2024, 4, 15, 0, 0, 0, 0, 0),
    );

    DateTime selectedDay = DateTime(2024, 4, 16, 0, 0, 0, 0, 0);

    dateTimeController.onGetNow = () => DateTime(2024, 4, 15, 0, 0, 0, 0, 0);

    prayController.onExistsPray = (selectedDay, id) async {
      return false;
    };

    // Act
    String icon = await controller.getDayIcon(selectedDay);

    // Assert
    expect(icon, "");
  });

  test("CalendarController.getDayIcon(userController.user!.createdDate.isBefore(day))", () async{
    // Arrange
    userController.user = UserIpray(id: 0,
      name: "teste",
      email: "teste@gmail.com",
      urlImage: "",
      age: 20,
      state: "São Paulo",
      city: "Franca",
      total: 0,
      streak: 0,
      createdDate: DateTime(2024, 4, 15, 0, 0, 0, 0, 0),
    );

    DateTime selectedDay = DateTime(2024, 4, 14, 0, 0, 0, 0, 0);

    dateTimeController.onGetNow = () => DateTime(2024, 4, 15, 0, 0, 0, 0, 0);

    prayController.onExistsPray = (selectedDay, id) async {
      return false;
    };

    // Act
    String icon = await controller.getDayIcon(selectedDay);

    // Assert
    expect(icon, "");
  });

  test("CalendarController.processResponseDialogSelectDay(add pray)", () {
    // Arrange
    DateTime selectedDay = DateTime.now();

    bool addPray = false;
    userController.onAddPray = (selectedDay) {
      addPray = true;
    };

    // Act
    controller.processResponseDialogSelectDay(selectedDay, true);

    // Assert
    expect(addPray, true);
  });

  test("CalendarController.processResponseDialogSelectDay(add pray)", () {
    // Arrange
    DateTime selectedDay = DateTime.now();
    bool notifyListenerCalled = false;

    controller.addListener(() {
      notifyListenerCalled = true;
    });

    bool removePray = false;
    userController.onRemovePray = (selectedDay) {
      removePray = true;
    };

    // Act
    controller.processResponseDialogSelectDay(selectedDay, false);

    // Assert
    expect(removePray, true);
    expect(notifyListenerCalled, false);
  });
}


