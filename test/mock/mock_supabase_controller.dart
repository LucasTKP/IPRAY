import 'package:ipray/controllers/supabase_controller.dart';
import 'package:ipray/models/app_info_models.dart';
import 'package:ipray/models/praies_models.dart';
import 'package:ipray/models/users_models.dart';

class MockSupabaseController extends SupabaseController {
  @override
  Future<UserIpray> createUser(Map<String, dynamic> dataUser) =>
      onCreateUser(dataUser);

  Future<UserIpray> Function(Map<String, dynamic> dataUser) onCreateUser =
      (dataUser) => throw UnimplementedError();

  @override
  Future<UserIpray> decrementUserTotal(UserIpray user) => onDecrementUserTotal(user);
  Future<UserIpray> Function(UserIpray user) onDecrementUserTotal = (user) => throw UnimplementedError();

  @override
  Future<UserIpray?> getUser(String email)=> onGetUser(email);
  Future<UserIpray?> Function(String email) onGetUser = (email) => throw UnimplementedError();


  @override
  Future<UserIpray> incrementUserTotal(UserIpray user)=> onIncrementUserTotal(user);
  Future<UserIpray> Function(UserIpray user) onIncrementUserTotal = (user) => throw UnimplementedError();

  @override
  Future<Praies> createPray(DateTime dateSelected, int idUser) => onCreatePray(dateSelected, idUser);
  Future<Praies> Function(DateTime dateSelected, int idUser) onCreatePray = (dateSelected, idUser) => throw UnimplementedError();

  @override
  Future<Praies> deletePray(DateTime dateSelected, int idUser) => onDeletePray(dateSelected, idUser);
  Future<Praies> Function(DateTime dateSelected, int idUser) onDeletePray = (dateSelected, idUser) => throw UnimplementedError();

  @override
  Future<List<Map<String, dynamic>>> getPray(DateTime dateSelected, int idUser) => onGetPray(dateSelected, idUser);
  Future<List<Map<String, dynamic>>> Function(DateTime dateSelected, int idUser) onGetPray = (dateSelected, idUser) => throw UnimplementedError();

  @override
  Future<AppInfo> getAppInfo() {
    // TODO: implement getAppInfo
    throw UnimplementedError();
  }
  
  @override
  Future<List<UserIpray>> getTopUsersMorePray() {
    // TODO: implement getUsersMorePray
    throw UnimplementedError();
  }
}
