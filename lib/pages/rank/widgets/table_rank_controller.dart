import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ipray/controllers/supabase_controller.dart';
import 'package:ipray/models/users_models.dart';
import 'package:ipray/shared/app_navigator.dart';

abstract class TableRankController extends ChangeNotifier {
  List<UserIpray> usersTopRank = [];
  List<UserIpray> usersTopConsecultiveDays = [];

  bool isLoading = false;

  bool isTopTotal = true;

  getTop10Rank();
  getTop10ConsecutiveDays();

  setIsLoading(bool value);

  setIsTopTotal(bool value);
}

class TableRankControllerImp extends TableRankController {
  final SupabaseController supabaseController;
  final AppNavigator appNavigator;

  TableRankControllerImp({required this.supabaseController, required this.appNavigator});

  @override
  getTop10Rank() async {
    try {
      setIsLoading(true);
      List<UserIpray> users = await supabaseController.getTopUsersMorePray();
      usersTopRank = users;
      notifyListeners();
    } catch (e) {
      String error = 'Algo deu errado, tente novamente mais tarde.';
      if (e is SocketException) {
        error = 'Sem internet, por favor reconecte';
      }
      appNavigator.showError(error);
      return false;
    } finally {
      setIsLoading(false);
    }
  }

  @override
  getTop10ConsecutiveDays() async {
    try {
      setIsLoading(true);
      List<UserIpray> users = await supabaseController.getTopUsersMorePray();
      usersTopConsecultiveDays = users;
      notifyListeners();
    } catch (e) {
      String error = 'Algo deu errado, tente novamente mais tarde.';
      if (e is SocketException) {
        error = 'Sem internet, por favor reconecte';
      }
      appNavigator.showError(error);
      return false;
    } finally {
      setIsLoading(false);
    }
  }

  @override
  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  @override
  setIsTopTotal(bool value) {
    isTopTotal = value;
    if (value && usersTopRank.isEmpty) {
      getTop10Rank();
    } else if(!value && usersTopConsecultiveDays.isEmpty){
      getTop10ConsecutiveDays();
    }
    notifyListeners();
  }
}
