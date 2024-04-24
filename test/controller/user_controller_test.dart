import 'package:flutter_test/flutter_test.dart';
import 'package:ipray/controllers/user_controller.dart';

import 'package:ipray/models/praies_models.dart';
import 'package:ipray/models/users_models.dart';

import '../mock/mock_app_navigator.dart';
import '../mock/mock_date_time_controller.dart';
import '../mock/mock_firebase_controller.dart';
import '../mock/mock_pray_controller.dart';
import '../mock/mock_supabase_controller.dart';

void main() {
  late UserController controller;
  late MockSupabaseController supabaseController;
  late MockAppNavigator appNavigator;
  late MockPrayController prayController;
  late MockDateTimeController dateTimeController;
  late MockFirebaseController firebaseController;

  setUp(() {
    appNavigator = MockAppNavigator();
    supabaseController = MockSupabaseController();
    prayController = MockPrayController();
    dateTimeController = MockDateTimeController();
    firebaseController = MockFirebaseController();

    controller = UserControllerImp(
      appNavigator: appNavigator,
      supabaseController: supabaseController,
      prayController: prayController,
      dateTimeController: dateTimeController,
      firebaseController: firebaseController
    );

    controller.user = UserIpray(
        id: 0,
        name: "teste",
        email: "teste@gmail.com",
        urlImage: "",
        age: 20,
        state: "São Paulo",
        city: "Franca",
        total: 2,
        streak: 0,
        createdDate: DateTime(2024, 4, 15, 0, 0, 0, 0, 0));
  });

  test("UserController.createUser()", () async{
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    bool onCreateUserCalled = false;
    supabaseController.onCreateUser = (Map<String, dynamic> dataUser) async{
      onCreateUserCalled = true;
      return controller.user!;
    };

    // Act
    bool response = await controller.createUser({});

    // Assert
    expect(notifyListenerCalled, true);
    expect(onCreateUserCalled, true);
    expect(response, true);
  });

  test("UserController.createUser(error)", () async{
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    supabaseController.onCreateUser = (Map<String, dynamic> dataUser) async{
      throw Error;
    };

    bool onNavigateShowErrorCalled = false;
    appNavigator.onShowError = (String error){
      onNavigateShowErrorCalled = true;
    };

    // Act
    bool response = await controller.createUser({});

    // Assert
    expect(notifyListenerCalled, false);
    expect(onNavigateShowErrorCalled, true);
    expect(response, false);
  });

  test("UserController.getUser()", () async{
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    bool onGetUserCalled = false;
    supabaseController.onGetUser = (String email) async {
      onGetUserCalled = true;
      return controller.user;
    };

    // Act
    UserIpray? response = await controller.getUser("");

    // Assert
    expect(notifyListenerCalled, false);
    expect(onGetUserCalled, true);
    expect(response, controller.user);
  });

  test("UserController.getUser(error)", () async{
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    supabaseController.onGetUser = (String email) async{
      throw Error;
    };

    bool onNavigateShowErrorCalled = false;
    appNavigator.onShowError = (String error){
      onNavigateShowErrorCalled = true;
    };


    // Act
    UserIpray? response = await controller.getUser("");

    // Assert
    expect(notifyListenerCalled, false);
    expect(onNavigateShowErrorCalled, true);
    expect(response, null);
  });

  test("UserController.verifyUser(error)", () async{
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    firebaseController.onGetCurrentUser = (){
      return null;
    };

    bool onNavigateToSigninCalled = false;
    appNavigator.onNavigateToSignin = (){
      onNavigateToSigninCalled = true;
    };


    // Act
    await controller.verifyUser();

    // Assert
    expect(notifyListenerCalled, false);
    expect(onNavigateToSigninCalled, true);
  });

  test("UserController.getLostDays()", (){
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    dateTimeController.onGetNow = () => DateTime(2024, 4, 20, 0, 0, 0, 0, 0);

    // Act
    int lostDays = controller.getLostDays();

    // Assert
    expect(lostDays, 3);
    expect(notifyListenerCalled, false);
  });

  test("UserController.getPrayDays()", (){
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });
    // Act
    int response = controller.getPrayDays();

    // Assert
    expect(controller.user!.total, response);
    expect(notifyListenerCalled, false);
  });

  test("UserController.setUser()", () {
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    // Act
    controller.setUser(controller.user!);

    // Assert
    expect(notifyListenerCalled, true);
  });

  test("UserController.addPray()", () async {
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    DateTime date = DateTime(2024, 4, 15, 0, 0, 0, 0, 0);

    bool onExistsPrayInCacheCalled = false;
    prayController.onExistsPrayInCache = (DateTime date){
      onExistsPrayInCacheCalled = true;
      return false;
    };

    bool onCreatePrayCalled = false;
    prayController.onCreatePray = (DateTime date, int id) async{
      onCreatePrayCalled = true;
      return Praies(id:0, idUser: 0, date: date);
    };

    bool onIncrementUserTotalCalled = false;
    supabaseController.onIncrementUserTotal = (UserIpray user) async{
      onIncrementUserTotalCalled = true;
      return controller.user!;
    };

    // Act
    await controller.addPray(date);

    // Assert
    expect(notifyListenerCalled, true);
    expect(onExistsPrayInCacheCalled, true);
    expect(onCreatePrayCalled, true);
    expect(onIncrementUserTotalCalled, true);
  });

  test("UserController.addPray(error)", () async {
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    DateTime date = DateTime(2024, 4, 15, 0, 0, 0, 0, 0);

    prayController.onExistsPrayInCache = (DateTime date){
      return false;
    };

    prayController.onCreatePray = (DateTime date, int id) async{
      return Praies(id:0, idUser: 0, date: date);
    };

    supabaseController.onIncrementUserTotal = (UserIpray user){
      throw Error;
    };

    bool onShowErrorCalled = false;
    appNavigator.onShowError = (value) => {
      onShowErrorCalled = true
    };

    // Act
    await controller.addPray(date);

    // Assert
    expect(notifyListenerCalled, false);
    expect(onShowErrorCalled, true);
  });

  test("UserController.removePray()", () async {
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    DateTime date = DateTime(2024, 4, 15, 0, 0, 0, 0, 0);

    prayController.onExistsPrayInCache = (DateTime date){
      return true;
    };

    prayController.onDeletePray = (DateTime date, int id) async{
      return true;
    };

    bool onDecrementUserTotalCalled = false;
    supabaseController.onDecrementUserTotal = (UserIpray user) async{
      onDecrementUserTotalCalled = true;
      return controller.user!;
    };


    // Act
    await controller.removePray(date);

    // Assert
    expect(notifyListenerCalled, true);
    expect(onDecrementUserTotalCalled, true);
  });

  test("UserController.removePray(error)", () async {
    // Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    DateTime date = DateTime(2024, 4, 15, 0, 0, 0, 0, 0);

    prayController.onExistsPrayInCache = (DateTime date){
      return true;
    };

    prayController.onDeletePray = (DateTime date, int id) async{
      return true;
    };

    supabaseController.onDecrementUserTotal = (UserIpray user){
      throw Error;
    };

    bool onShowErrorCalled = false;
    appNavigator.onShowError = (value) => {
      onShowErrorCalled = true
    };


    // Act
    await controller.removePray(date);

    // Assert
    expect(notifyListenerCalled, false);
    expect(onShowErrorCalled, true);
  });
}



