import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ipray/controllers/supabase_controller.dart';
import 'package:ipray/models/users_models.dart';
import 'package:ipray/shared/app_navigator.dart';

abstract class TableRankController extends ChangeNotifier {
  List<UserIpray> usersTopRank = [];

  bool isLoading = false;

  getTop10Rank();

  setIsLoading(bool value);
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
  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
