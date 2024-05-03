import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipray/controllers/notification_controller.dart';
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

  verifyUser();

  verifyToken(UserIpray userIpray);

  int getLostDays();

  int getPrayDays();

  int getConsecultiveDaysPray();

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
  verifyUser() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      User? userFirebase = firebaseController.getCurrentUser();
      if (userFirebase != null) {
        UserIpray? userIpray = await supabaseController.getUser(userFirebase.email!);
        if (userIpray != null) {
          await verifyToken(userIpray);
          UserIpray userWithoutToken = userIpray.copyWith(deviceToken: null);
          setUser(userWithoutToken);
          appNavigator.navigateToRoutes();
        } else {
          appNavigator.navigateToSignup();
        }
      } else {
        appNavigator.navigateToSignin();
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

  @override
  verifyToken(UserIpray userIpray) async {
    String? token = await NotificationController.getTokenCell();
    debugPrint(token.toString());
    if (token != userIpray.deviceToken && token != null) {
      await supabaseController.updateUser({"device_token": token}, userIpray.id);
    }
  }

  @override
  int getLostDays() {
    DateTime dateNow = dateTimeController.getNowZeroTime();
    int lostDays = 0;
    UserIpray? user = this.user;
    if (user != null) {
      DateTime startDate = user.createdDate;
      int total = user.total;
      int differenceInDays = dateNow.difference(startDate).inDays;
      lostDays = differenceInDays - (total -1);
    }
    return lostDays;
  }

  @override
  int getPrayDays() {
    return user!.total;
  }

  @override
  getConsecultiveDaysPray() {
    return user!.streak;
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
          final response = await supabaseController.getUser(user.email);

          if (response is UserIpray) {
            setUser(response);
          }
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
          final response = await supabaseController.getUser(user.email);
          if (response is UserIpray) {
            setUser(response);
          }
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
