import 'package:flutter_test/flutter_test.dart';
import 'package:ipray/pages/signup/signup_controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_app_navigator.dart';
import '../../mock/mock_date_time_controller.dart';
import '../../mock/mock_firebase_controller.dart';
import '../../mock/mock_user_controller.dart';

// class UserControllerMock extends Mock implements UserController {
//
// }
//



void main() {
  late SignUpController controller;
  late MockAppNavigator appNavigator;
  late MockUserController userController;
  late MockFirebaseController firebaseController;
  late MockDateTimeController dateTimeController;

  setUp(() {
    appNavigator = MockAppNavigator();
    userController = MockUserController();
    firebaseController = MockFirebaseController();
    dateTimeController = MockDateTimeController();

    controller = SignUpController(
      userController: userController,
      appNavigator: appNavigator,
      firebaseController: firebaseController,
      dateTimeController: dateTimeController,
    );
  });

  test('SignUpController.signUp(user created)', () async {
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    controller.name.text = 'teste';
    controller.age.text = "20";
    controller.state = 'São Paulo';
    controller.city = 'Franca';

    firebaseController.onGetEmail = () => "teste@gmail.com";

    dateTimeController.onGetNow = () => DateTime(2024, 4, 15, 0, 0, 0, 0, 0);

    Map<String, dynamic> createUserData = {};
    userController.onCreateUser = (dataUser) async {
      createUserData = dataUser;
      return true;
    };

    bool navigateToHomeCalled = false;
    appNavigator.onNavigateToHome = () => navigateToHomeCalled = true;

    // Act
    await controller.signUp();

    // Assert
    expect(createUserData["name"], "teste");
    expect(createUserData["email"], "teste@gmail.com");
    expect(createUserData["age"], 20);
    expect(createUserData["state"], "São Paulo");
    expect(createUserData["city"], "Franca");
    expect(createUserData["url_image"], "");
    expect(createUserData["total"], 0);
    expect(createUserData["streak"], 0);
    expect(createUserData["created_date"], "2024-04-15T00:00:00.000");
    expect(notifyListenerCalled, false);
    expect(navigateToHomeCalled, true);
  });

  test('SignUpController.signUp(user not created)', () async {
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    controller.age.text = "20";

    firebaseController.onGetEmail = () => "teste@gmail.com";

    dateTimeController.onGetNow = () => DateTime(2024, 4, 15, 0, 0, 0, 0, 0);

    userController.onCreateUser = (dataUser) async {
      return false;
    };

    bool navigateToHomeCalled = false;
    appNavigator.onNavigateToHome = () => navigateToHomeCalled = true;

    // Act
    await controller.signUp();

    // Assert
    expect(notifyListenerCalled, false);
    expect(navigateToHomeCalled, false);
  });

  test('SignUpController.verificationSignUp(step = 1)', () async{
    // Arrange
    controller.step = 1;
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    // Act
    await controller.verificationStepSignUp();

    // Assert
    expect(controller.step, 2);
    expect(notifyListenerCalled, true);
  });

  test('SignUpController.verificationSignUp(step = 3)', () async{
    // Arrange
    controller.step = 3;
    int notifyListenerCalled = 0;
    List<bool> isLoadingCalled = [];
    controller.addListener(() {
      notifyListenerCalled++;
      isLoadingCalled.add(controller.isLoading);
    });

    controller.age.text = "20";

    firebaseController.onGetEmail = () => "teste@gmail.com";

    dateTimeController.onGetNow = () => DateTime(2024, 4, 15, 0, 0, 0, 0, 0);

    Map<String, dynamic> createUserData = {};
    userController.onCreateUser = (dataUser) async {
      createUserData = dataUser;
      return true;
    };

    bool navigateToHomeCalled = false;
    appNavigator.onNavigateToHome = () => navigateToHomeCalled = true;


    // Act
    await controller.verificationStepSignUp();

    // Assert
    expect(notifyListenerCalled, 2);
    expect(isLoadingCalled, [true, false]);
    expect(controller.step, 3);
    expect(createUserData["age"], 20);
  });

  // test('SignUpController.verificationSignUp()', () async{
  //   // Arrange
  //   final userControllerMock = UserControllerMock();
  //   final dateTimeControllerMock = DateTimeControllerMock();
  //
  //   dateTimeController.onGetNow = () => DateTime(2024, 4, 15, 0, 0, 0, 0, 0);
  //   firebaseController.onGetEmail = () => "teste@gmail.com";
  //   appNavigator.onNavigateToHome = () => true;
  //
  //
  //   when(() => userControllerMock.createUser(any())).thenAnswer((_) async => true);
  //   when(() => dateTimeControllerMock.getNow()).thenAnswer((_) => DateTime(2024, 4, 15, 0, 0, 0, 0, 0));
  //
  //   final sut = SignUpController(
  //     userController: userControllerMock,
  //     appNavigator: appNavigator,
  //     firebaseController: firebaseController,
  //     dateTimeController: dateTimeControllerMock,
  //   );
  //
  //   sut.age.text = "20";
  //
  //   sut.step = 3;
  //
  //   // Act
  //   await sut.verificationStepSignUp();
  //
  //   // Assert
  //   verify(() => userControllerMock.createUser(any())).called(1);
  //   verify(() => dateTimeControllerMock.getNow()).called(1);
  // });

  test('SignUpController.setState()', () {
    // Arrange
    controller.state = "";
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    // Act
    controller.setState("São Paulo");

    // Assert
    expect(controller.state, "São Paulo");
    expect(notifyListenerCalled, true);
  });

  test('SignUpController.setCity()', () {
    // Arrange
    controller.city = "";
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    // Act
    controller.setCity("Franca");

    // Assert
    expect(controller.city, "Franca");
    expect(notifyListenerCalled, true);
  });

  test('SignUpController.setStepDecrement(step decrement)', () {
    // Arrange
    controller.step = 1;
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    // Act
    controller.setStepDecrement();

    // Assert
    expect(controller.step, 0);
    expect(notifyListenerCalled, true);
  });

  test('SignUpController.setStepDecrement(step not decrement )', () {
    // Arrange
    controller.step = 0;

    // Act
    controller.setStepDecrement();

    // Assert
    expect(controller.step, 0);
  });

  test('SignUpController.setCities()', () {
    // Arrange
    controller.cities = [];
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    // Act
    controller.setCities(["São Paulo", "Franca"]);

    // Assert
    expect(controller.cities, ["São Paulo", "Franca"]);
    expect(notifyListenerCalled, true);
  });

  test('SignUpController.setIsLoading()', () {
    // Arrange
    controller.isLoading = false;
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    // Act
    controller.setIsLoading(true);

    // Assert
    expect(controller.isLoading, true);
    expect(notifyListenerCalled, true);
  });
}
