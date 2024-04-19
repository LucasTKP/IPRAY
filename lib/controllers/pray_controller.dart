import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ipray/controllers/supabase_controller.dart';
import 'package:ipray/models/praies_models.dart';
import 'package:ipray/shared/app_navigator.dart';

abstract class PrayController extends ChangeNotifier {
  final Map<DateTime, Praies?> cache = {};

  Future<Praies?> createPray(DateTime dateSelected, int idUser);

  Future<bool> deletePray(DateTime dateSelected, int idUser);

  Future<bool> existsPray(DateTime dateSelected, int idUser);

  bool existsPrayInCache(DateTime dateSelected);
}

class PrayControllerImp extends PrayController {
  final AppNavigator appNavigator;
  final SupabaseController supabaseController;

  PrayControllerImp({
    required this.appNavigator,
    required this.supabaseController,
  });

  @override
  Future<Praies?> createPray(DateTime dateSelected, int idUser) async {
    try {
      Praies dataPray = await supabaseController.createPray(dateSelected, idUser);
      cache[dateSelected] = dataPray;
      return dataPray;
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
  Future<bool> deletePray(DateTime dateSelected, int idUser) async {
    try {
      Praies dataPray = await supabaseController.deletePray(dateSelected, idUser);
      cache[dataPray.date] = null;
      return true;
    } catch (e) {
      String error = 'Algo deu errado, tente novamente mais tarde.';
      if (e is SocketException) {
        error = 'Sem internet, por favor reconecte';
      }
      appNavigator.showError(error);
      return false;
    }
  }

  @override
  Future<bool> existsPray(DateTime dateSelected, int idUser) async {
    if (cache.containsKey(dateSelected)) {
      return cache[dateSelected] != null;
    }
    List<Map<String, dynamic>> response = await supabaseController.getPray(dateSelected, idUser);
    if (response.isNotEmpty) {
      final dataPray = Praies.fromJson(response[0]);
      cache[dateSelected] = dataPray;
      return true;
    } else {
      cache[dateSelected] = null;
      return false;
    }
  }

  @override
  bool existsPrayInCache(DateTime dateSelected) {
    if (cache.containsKey(dateSelected)) {
      return cache[dateSelected] != null;
    }
    return false;
  }
}
