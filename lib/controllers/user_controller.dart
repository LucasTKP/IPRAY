import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/models/praies_models.dart';
import 'package:ipray/models/users_models.dart';
import 'package:ipray/shared/app_navigator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserController extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  final AppNavigator appNavigator;
  final PrayController prayController;

  UserController({required this.appNavigator, required this.prayController});

  UserIpray? user;

  Future<bool> createUser(Map<String, dynamic> dataUser) async {
    try {
      final response = await supabase.from('User').insert(dataUser).select();
      UserIpray user = UserIpray.fromJson(response[0]);
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

  Future<UserIpray?> getUser(String email) async {
    try {
      final response = await supabase.from('User').select().eq('email', email);

      if (response.isNotEmpty) {
        final data = UserIpray.fromJson(response[0]);

        return data;
      }

      return UserIpray(
        id: 0,
        name: "",
        email: "",
        urlImage: "",
        age: 0,
        state: "",
        city: "",
        total: 0,
        streak: 0,
        createdDate: DateTime.now(),
      );
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

  void verifyUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserIpray? userIpray = await getUser(user.email!);
      if (userIpray != null) {
        if (userIpray.id != 0) {
          setUser(userIpray);
          appNavigator.navigateToHome();
        } else {
          appNavigator.navigateToSignup();
        }
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      appNavigator.navigateToSignin();
    }
  }

  int getLostDays() {
    DateTime tomorrowStart = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
      0,
      0,
      0,
      0,
      0,
    );
    int lostDays = 0;
    if (user != null) {
      DateTime startDate = user?.createdDate ?? DateTime.now();
      int total = user?.total ?? 0;
      int differenceInDays = tomorrowStart.difference(startDate).inDays;
      lostDays = differenceInDays - total;
    }
    return lostDays;
  }

  int getPrayDays() {
    return user!.total;
  }

  setUser(UserIpray newUser) {
    user = newUser;
    notifyListeners();
  }
  
  addPray(DateTime selectedDay) async {
    final UserIpray? user = this.user;
    if (user != null) {
      if (prayController.existsPrayInCache(selectedDay)) {
        return;
      }

      final response = await prayController.createPray(selectedDay, user.id);
      if (response is Praies) {
        try {
          final response = await supabase.from('User').update({'total': user.total + 1}).match({'id': user.id}).select();
          final UserIpray newUser = UserIpray.fromJson(response[0]);
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

  removePray(DateTime selectedDay) async {
    final UserIpray? user = this.user;
    if (user != null) {
      if (!prayController.existsPrayInCache(selectedDay)) {
        return;
      }

      final response = await prayController.deletePray(selectedDay, user.id);

      if (response) {
        try {
          final response = await supabase.from('User').update({'total': user.total - 1}).match({'id': user.id}).select();
          final UserIpray newUser = UserIpray.fromJson(response[0]);
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
