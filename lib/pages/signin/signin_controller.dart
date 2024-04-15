import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/shared/app_navigator.dart';

class SignInController extends ChangeNotifier {
  final UserController userController;
  final AppNavigator appNavigator;

  SignInController({required this.userController, required this.appNavigator});

  bool isLoading = false;

  setIsLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  signInWithGoogle() async {
    try {
      setIsLoading(true);
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final response = await FirebaseAuth.instance.signInWithCredential(credential);

      await processSignInWithGoogle(response);
    } catch (e) {
      String errorMessage = "Não foi possivel fazer login";
      if (e is PlatformException) {
        errorMessage = "Sem internet, por favor reconecte";
      }

      setIsLoading(false);

      appNavigator.showError(errorMessage);
    }
  }

  processSignInWithGoogle(UserCredential? userCredential) async {
    if (userCredential != null) {
      final email = userCredential.user?.email ?? "";
      final response = await userController.getUser(email);
      setIsLoading(false);
      if (response != null) {
        if (response.id != 0) {
          userController.setUser(response);
          appNavigator.navigateToHome();
        } else {
          appNavigator.navigateToSignup();
        }
      }
    }
    return null;
  }
}
