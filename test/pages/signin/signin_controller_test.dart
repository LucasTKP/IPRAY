import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipray/models/users_models.dart';
import 'package:ipray/pages/signin/signin_controller.dart';

import '../../mock/mock_app_navigator.dart';
import '../../mock/mock_firebase_controller.dart';
import '../../mock/mock_google_controller.dart';
import '../../mock/mock_user_controller.dart';

void main() {
  late SignInController controller;
  late MockAppNavigator appNavigator;
  late MockUserController userController;
  late MockFirebaseController firebaseController;
  late MockGoogleController googleController;

  setUp(() {
    appNavigator = MockAppNavigator();
    userController = MockUserController();
    firebaseController = MockFirebaseController();
    googleController = MockGoogleController();

    controller = SignInController(
      userController: userController,
      appNavigator: appNavigator,
      firebaseController: firebaseController,
      googleController: googleController,
    );
  });

  test('SignInController.signInWithGoogle()', () async {
    // Arrange
    int notifyListenerCalled = 0;
    List<bool> isLoadingCalled = [];
    controller.addListener(() {
      notifyListenerCalled++;
      isLoadingCalled.add(controller.isLoading);
    });

    bool onSingInCalled = false;
    googleController.onSignIn = () async{
      OAuthCredential oAuthCredential = const OAuthCredential(providerId: '', signInMethod: '');
      onSingInCalled = true;
      return oAuthCredential;
    };

    bool onGetCredentialCalled = false;
    firebaseController.onGetCredential = (OAuthCredential credential) async {
      onGetCredentialCalled = true;
      return null;
    };

    userController.onGetUser = (String email) async => UserIpray(
        id: 0,
        name: "teste",
        email: "teste@gmail.com",
        urlImage: "",
        age: 20,
        state: "São Paulo",
        city: "Franca",
        total: 0,
        streak: 0,
        createdDate: DateTime(2024, 4, 15, 0, 0, 0, 0, 0));

    userController.onSetUser = (UserIpray userIpray) => {};

    appNavigator.onNavigateToRoutes = () => {};

    // Act
    await controller.signInWithGoogle();

    // Assert
    expect(notifyListenerCalled, 2);
    expect(isLoadingCalled, [true, false]);
    expect(onSingInCalled, true);
    expect(onGetCredentialCalled, true);
  });

  test('SignInController.signInWithGoogle(error)', () async {
    // Arrange
    int notifyListenerCalled = 0;
    List<bool> isLoadingCalled = [];
    controller.addListener(() {
      notifyListenerCalled++;
      isLoadingCalled.add(controller.isLoading);
    });

    googleController.onSignIn = () {
      throw Error;
    };

    bool showErrorCalled = false;
    appNavigator.onShowError = (String error) => showErrorCalled = true;

    // Act
    controller.signInWithGoogle();

    // Assert
    expect(notifyListenerCalled, 2);
    expect(showErrorCalled, true);
    expect(isLoadingCalled, [true, false]);
  });

  test('SignInController.processSignInWithGoogle(user found)', () async {
    // Arrange
    bool notifyListenerCalled = false;

    controller.addListener(() {
      notifyListenerCalled = true;
    });

    controller.isLoading = true;

    userController.onGetUser = (String email) async => UserIpray(
        id: 0,
        name: "teste",
        email: "teste@gmail.com",
        urlImage: "",
        age: 20,
        state: "São Paulo",
        city: "Franca",
        total: 0,
        streak: 0,
        createdDate: DateTime(2024, 4, 15, 0, 0, 0, 0, 0));

    bool setUser = false;
    userController.onSetUser = (UserIpray userIpray) => {setUser = true};

    bool navigateToRoutesCalled = false;
    appNavigator.onNavigateToRoutes = () => navigateToRoutesCalled = true;

    // Act
    await controller.processSignInWithGoogle("");

    // Assert
    expect(notifyListenerCalled, true);
    expect(controller.isLoading, false);
    expect(setUser, true);
    expect(navigateToRoutesCalled, true);
  });

  test('SignInController.processSignInWithGoogle(user not found)', () async {
    // Arrange
    controller.isLoading = true;

    userController.onGetUser = (String email) async => null;

    bool navigateToSignupCalled = false;
    appNavigator.onNavigateToSignup = () => navigateToSignupCalled = true;

    // Act
    await controller.processSignInWithGoogle("");

    // Assert
    expect(controller.isLoading, false);
    expect(navigateToSignupCalled, true);
  });
}

