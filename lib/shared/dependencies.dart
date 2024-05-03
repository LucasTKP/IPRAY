import 'package:flutter/material.dart';
import 'package:ipray/controllers/date_time_controller.dart';
import 'package:ipray/controllers/firebase_controller.dart';
import 'package:ipray/controllers/google_controller.dart';
import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/controllers/supabase_controller.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/pages/routes/routes_controller.dart';
import 'package:ipray/shared/app_navigator.dart';

class Dependencies {
  static Dependencies? _instance;

  static Dependencies get instance => _instance ??= Dependencies._();

  Dependencies._();

  final Map<Type, dynamic> _objects = {};

  bool contains<T>() => _objects.containsKey(T);

  void add<T>(T instance) => contains<T>() ? throw Exception('Class ${T.runtimeType} already registered!') : _objects[T] = instance;

  T get<T>() => contains<T>() ? _objects[T] : throw Exception('Class ${T.runtimeType} not registered!');

  void remove<T>() => _objects.remove(T);

  void clear() => _objects.clear();
}

Future<bool> setupDependencies(BuildContext context) async {
  Dependencies.instance.add<DateTimeController>(DateTimeControllerImp());
  Dependencies.instance.add<FirebaseController>(FirebaseControllerImp());
  Dependencies.instance.add<GoogleController>(GoogleControllerImp());
  Dependencies.instance.add<SupabaseController>(SupabaseControllerImp());
  Dependencies.instance.add<AppNavigator>(AppNavigatorImp(context: context));
  Dependencies.instance.add<RoutesController>(RoutesControllerImp());
  Dependencies.instance.add<PrayController>(
    PrayControllerImp(
      appNavigator: Dependencies.instance.get(),
      supabaseController: Dependencies.instance.get(),
    ),
  );

  Dependencies.instance.add<UserController>(
    UserControllerImp(
      appNavigator: Dependencies.instance.get(),
      prayController: Dependencies.instance.get(),
      supabaseController: Dependencies.instance.get(),
      dateTimeController: Dependencies.instance.get(),
      firebaseController: Dependencies.instance.get(),
    ),
  );
  return true;
}
