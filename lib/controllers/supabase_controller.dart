import 'package:ipray/models/users_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/praies_models.dart';

abstract class SupabaseController {
  Future<UserIpray> createUser(Map<String, dynamic> dataUser);

  Future<UserIpray?> getUser(String email);

  Future<UserIpray> incrementUserTotal(UserIpray user);

  Future<UserIpray> decrementUserTotal(UserIpray user);

  Future<Praies> createPray(DateTime dateSelected, int idUser);

  Future<Praies> deletePray(DateTime dateSelected, int idUser);

  Future<List<Map<String, dynamic>>> getPray(DateTime dateSelected, int idUser);
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
  Future<UserIpray> incrementUserTotal(UserIpray user) async {
    final response = await supabase.from('User').update({'total': user.total + 1}).match({'id': user.id}).select();
    final UserIpray newUser = UserIpray.fromJson(response[0]);
    return newUser;
  }

  @override
  Future<UserIpray> decrementUserTotal(UserIpray user) async {
    final response = await supabase.from('User').update({'total': user.total - 1}).match({'id': user.id}).select();
    final UserIpray newUser = UserIpray.fromJson(response[0]);
    return newUser;
  }

  @override
  Future<Praies> createPray(DateTime dateSelected, int idUser) async {
    List<Map<String, dynamic>> response =
        await supabase.from('Pray').insert({'id_user': idUser, 'date': dateSelected.toIso8601String()}).select();

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
  Future<List<Map<String, dynamic>>> getPray(DateTime dateSelected, int idUser) async{
    final response = await supabase.from('Pray').select().match({'id_user': idUser, 'date': dateSelected});
    return response;
  }
}

// class SupabaseControllerFake extends SupabaseController {
//   Map<int, UserIpray> users = {};
//
//   @override
//   Future<UserIpray> createUser(Map<String, dynamic> dataUser) async {
//     dataUser['id'] = DateTime.now().millisecondsSinceEpoch;
//     UserIpray user = UserIpray.fromJson(dataUser);
//     users[user.id] = user;
//     return user;
//   }
//
//   @override
//   Future<UserIpray?> getUser(String email) async {
//     final UserIpray? user = users.values.firstWhereOrNull((element) => element.email == email);
//     return user;
//   }
//
//   @override
//   Future<UserIpray> incrementUserTotal(UserIpray user) async {
//     final UserIpray newUser = UserIpray(
//       id: user.id,
//       name: user.name,
//       email: user.email,
//       total: user.total + 1,
//       urlImage: user.urlImage,
//       age: user.age,
//       state: user.state,
//       city: user.city,
//       streak: user.streak,
//       createdDate: user.createdDate,
//     );
//     users[newUser.id] = newUser;
//     return newUser;
//   }
//
//   @override
//   Future<UserIpray> decrementUserTotal(UserIpray user) async {
//     final UserIpray newUser = UserIpray(
//       id: user.id,
//       name: user.name,
//       email: user.email,
//       total: user.total - 1,
//       urlImage: user.urlImage,
//       age: user.age,
//       state: user.state,
//       city: user.city,
//       streak: user.streak,
//       createdDate: user.createdDate,
//     );
//     users[newUser.id] = newUser;
//     return newUser;
//   }
// }