import 'package:ipray/models/users_models.dart';

class SingtonService {
  static SingtonService? _instance;
  SingtonService._();
  factory SingtonService() {
    _instance ??= SingtonService._();
    return _instance!;
  }

  UserIpray? user;
}
