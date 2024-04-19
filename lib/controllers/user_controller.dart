import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/controllers/supabase_controller.dart';
import 'package:ipray/models/praies_models.dart';
import 'package:ipray/models/users_models.dart';
import 'package:ipray/shared/app_navigator.dart';

import 'date_time_controller.dart';
import 'firebase_controller.dart';

abstract class UserController extends ChangeNotifier {
  UserIpray? user;

  Future<bool> createUser(Map<String, dynamic> dataUser);

  Future<UserIpray?> getUser(String email);

  verifyUser();

  int getLostDays();

  int getPrayDays();

  setUser(UserIpray newUser);

  addPray(DateTime selectedDay);

  removePray(DateTime selectedDay);
}

class UserControllerImp extends UserController {
  final AppNavigator appNavigator;
  final PrayController prayController;
  final SupabaseController supabaseController;
  final DateTimeController dateTimeController;
  final FirebaseController firebaseController;

  UserControllerImp({
    required this.appNavigator,
    required this.prayController,
    required this.supabaseController,
    required this.dateTimeController,
    required this.firebaseController,
  });

  @override
  Future<bool> createUser(Map<String, dynamic> dataUser) async {
    try {
      UserIpray user = await supabaseController.createUser(dataUser);
      setUser(user);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      String error = 'Algo deu errado, tente novamente mais tarde.';
      if (error is SocketException) {
        error = 'Sem internet, por favor reconecte';
      }
      appNavigator.showError(error);
      return false;
    }
  }

  @override
  Future<UserIpray?> getUser(String email) async {
    try {
      UserIpray? user = await supabaseController.getUser(email);
      return user;
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

  @override
  verifyUser() async {
    User? userFirebase = firebaseController.getCurrentUser();
    if (userFirebase != null) {
      UserIpray? userIpray = await getUser(userFirebase.email!);
      if (userIpray != null) {
        setUser(userIpray);
        appNavigator.navigateToHome();
      } else {
        appNavigator.navigateToSignup();
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      appNavigator.navigateToSignin();
    }
  }

  @override
  int getLostDays() {
    DateTime dateNow= dateTimeController.getNow();
    DateTime tomorrowStart = DateTime.utc(
      dateNow.year,
      dateNow.month,
      dateNow.day + 1,
      0,
      0,
      0,
      0,
      0,
    );
    int lostDays = 0;
    UserIpray? user = this.user;
    if (user != null) {
      DateTime startDate = user.createdDate;
      int total = user.total;
      int differenceInDays = tomorrowStart.difference(startDate).inDays;
      lostDays = differenceInDays - total;
    }
    return lostDays;
  }

  @override
  int getPrayDays() {
    return user!.total;
  }

  @override
  setUser(UserIpray newUser) {
    user = newUser;
    notifyListeners();
  }

  @override
  addPray(DateTime selectedDay) async {
    final UserIpray? user = this.user;
    if (user != null) {
      if (prayController.existsPrayInCache(selectedDay)) {
        return;
      }

      final response = await prayController.createPray(selectedDay, user.id);
      if (response is Praies) {
        try {
          final UserIpray newUser = await supabaseController.incrementUserTotal(user);
          setUser(newUser);
        } catch (e) {
          debugPrint(e.toString());
          String error = 'Algo deu errado, tente novamente mais tarde.';
          if (error is SocketException) {
            error = 'Sem internet, por favor reconecte';
          }
          appNavigator.showError(error);
        }
      }
    }
  }

  @override
  removePray(DateTime selectedDay) async {
    final UserIpray? user = this.user;
    if (user != null) {
      if (!prayController.existsPrayInCache(selectedDay)) {
        return;
      }

      final response = await prayController.deletePray(selectedDay, user.id);

      if (response) {
        try {
          final UserIpray newUser = await supabaseController.decrementUserTotal(user);
          setUser(newUser);
        } catch (e) {
          debugPrint(e.toString());
          String error = 'Algo deu errado, tente novamente mais tarde.';
          if (error is SocketException) {
            error = 'Sem internet, por favor reconecte';
          }
          appNavigator.showError(error);
        }
      }
    }
  }
}
