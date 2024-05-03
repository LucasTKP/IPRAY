import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipray/controllers/firebase_controller.dart';
import 'package:ipray/controllers/supabase_controller.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/models/users_models.dart';
import 'package:ipray/shared/app_navigator.dart';

import '../../controllers/google_controller.dart';

class SignInController extends ChangeNotifier {
  final UserController userController;
  final AppNavigator appNavigator;
  final GoogleController googleController;
  final FirebaseController firebaseController;
  final SupabaseController supabaseController;

  SignInController({required this.userController, required this.appNavigator, required this.googleController, required this.firebaseController, required this.supabaseController});

  bool isLoading = false;

  setIsLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  signInWithGoogle() async {
    try {
      setIsLoading(true);
      OAuthCredential credential = await googleController.signIn();

      final userCredential = await firebaseController.getCredential(credential);

      final email = userCredential?.user?.email ?? "";

      await processSignInWithGoogle(email);
    } catch (e) {
      debugPrint(e.toString());
      String errorMessage = "Não foi possivel fazer login";
      if (e is PlatformException) {
        errorMessage = "Sem internet, por favor reconecte";
      }

      setIsLoading(false);

      appNavigator.showError(errorMessage);
    }
  }

  processSignInWithGoogle(String email) async {
    try {
      final UserIpray? user = await supabaseController.getUser(email);
      setIsLoading(false);
      if (user != null) {
        userController.setUser(user);
        appNavigator.navigateToRoutes();
      } else {
        appNavigator.navigateToSignup();
      }
    } catch (e) {
      debugPrint(e.toString());
      String error = 'Algo deu errado, tente novamente mais tarde.';
      if (e is SocketException) {
        error = 'Sem internet, por favor reconecte';
      }
      appNavigator.showError(error);
      return null;
    }
  }
}
