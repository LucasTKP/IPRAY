import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ipray/models/praies_models.dart';
import 'package:ipray/shared/app_navigator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PrayController extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  final AppNavigator appNavigator;
  PrayController({required this.appNavigator});

  final Map<DateTime, Praies?> cache = {};

  Future<Praies?> createPray(DateTime dateSelected, int idUser) async {
    try {
      final response = await supabase.from('Pray').insert({'id_user': idUser, 'date': dateSelected.toIso8601String()}).select();

      final dataPray = Praies.fromJson(response[0]);
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

  Future<bool> deletePray(DateTime dateSelected, int idUser) async {
    try {
      final response = await supabase.from('Pray').delete().match({'id_user': idUser, 'date': dateSelected}).select();

      if (response.isNotEmpty) {
        final dataPray = Praies.fromJson(response[0]);
        cache[dataPray.date] = null;
        return true;
      }
      return false;
    } catch (e) {
      String error = 'Algo deu errado, tente novamente mais tarde.';
      if (e is SocketException) {
        error = 'Sem internet, por favor reconecte';
      }
      appNavigator.showError(error);
      return false;
    }
  }

  Future<bool> existsPray(DateTime dateSelected, int idUser) async {
    if (cache.containsKey(dateSelected)) {
      return cache[dateSelected] != null;
    }
    final response = await supabase.from('Pray').select().match({'id_user': idUser, 'date': dateSelected});

    if (response.isNotEmpty) {
      final dataPray = Praies.fromJson(response[0]);
      cache[dateSelected] = dataPray;
      return true;
    } else {
      cache[dateSelected] = null;
      return false;
    }
  }

  bool existsPrayInCache(DateTime dateSelected) {
    if (cache.containsKey(dateSelected)) {
      return cache[dateSelected] != null;
    }
    return false;
  }
}
