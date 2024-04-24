import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ipray/controllers/supabase_controller.dart';
import 'package:ipray/models/app_info_models.dart';
import 'package:ipray/shared/app_navigator.dart';

class SplashController extends ChangeNotifier {
  late SupabaseController supabaseController;
  late AppNavigator appNavigator;

  SplashController({required this.supabaseController});

  bool differentVersionApp = false;

  Future<bool> verifyVersionApp() async {
    try {
      AppInfo appInfo = await supabaseController.getAppInfo();

      if (appInfo.version != '1.0.0') {
        differentVersionApp = true;
        notifyListeners();
        return false;
      }
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
}
