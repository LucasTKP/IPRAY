import 'package:ipray/models/users_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_info_models.dart';
import '../models/praies_models.dart';

abstract class SupabaseController {
  Future<UserIpray> createUser(Map<String, dynamic> dataUser);

  Future<UserIpray?> getUser(String email);

  Future<UserIpray?> updateUser(Map<String, String> user, int idUser);

  Future<Praies> createPray(DateTime dateSelected, int idUser);

  Future<Praies> deletePray(DateTime dateSelected, int idUser);

  Future<List<Map<String, dynamic>>> getPray(DateTime dateSelected, int idUser);

  Future<AppInfo> getAppInfo();

  Future<List<UserIpray>> getTopUsersMorePray();
  Future<List<UserIpray>> getTopUsersConsecultiveDays();
}

class SupabaseControllerImp extends SupabaseController {
  final supabase = Supabase.instance.client;

  @override
  Future<UserIpray> createUser(Map<String, dynamic> dataUser) async {
    final response = await supabase.from('User').insert(dataUser).select();
    UserIpray user = UserIpray.fromJson(response[0]);
    return user;
  }

  @override
  Future<UserIpray?> getUser(String email) async {
    final response = await supabase.from('User').select().eq('email', email);

    if (response.isNotEmpty) {
      final data = UserIpray.fromJson(response[0]);
      return data;
    }
    return null;
  }

  @override
  Future<UserIpray> updateUser(Map<String, String> user, int idUser) async {
    final response = await supabase.from('User').update(user).match({'id': idUser}).select();
    UserIpray newUser = UserIpray.fromJson(response[0]);
    return newUser;
  }

  @override
  Future<Praies> createPray(DateTime dateSelected, int idUser) async {
    List<Map<String, dynamic>> response = await supabase.from('Pray').insert({'id_user': idUser, 'date': dateSelected.toIso8601String()}).select();

    Praies dataPray = Praies.fromJson(response[0]);
    return dataPray;
  }

  @override
  Future<Praies> deletePray(DateTime dateSelected, int idUser) async {
    final response = await supabase.from('Pray').delete().match({'id_user': idUser, 'date': dateSelected}).select();
    final dataPray = Praies.fromJson(response[0]);
    return dataPray;
  }

  @override
  Future<List<Map<String, dynamic>>> getPray(DateTime dateSelected, int idUser) async {
    final response = await supabase.from('Pray').select().match({'id_user': idUser, 'date': dateSelected});
    return response;
  }

  @override
  Future<AppInfo> getAppInfo() async {
    final response = await supabase.from('App').select().limit(1).single();
    AppInfo appInfo = AppInfo.fromJson(response);
    return appInfo;
  }

  @override
  Future<List<UserIpray>> getTopUsersMorePray() async {
    final response = await supabase.from('User').select().order('total', ascending: false).limit(10);

    List<UserIpray> listUserIPray(List<dynamic> usersSupabase) {
      return usersSupabase.map((user) {
        return UserIpray.fromJson(user);
      }).toList();
    }

    List<UserIpray> users = listUserIPray(response);

    return users;
  }

  @override
  Future<List<UserIpray>> getTopUsersConsecultiveDays() async {
    final response = await supabase.from('User').select().order('streak', ascending: false).limit(10);

    List<UserIpray> listUserIPray(List<dynamic> usersSupabase) {
      return usersSupabase.map((user) {
        return UserIpray.fromJson(user);
      }).toList();
    }

    List<UserIpray> users = listUserIPray(response);
    return users;
  }
}
