import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/models/users_models.dart';

class MockUserController extends UserController {
  @override
  addPray(DateTime selectedDay) => onAddPray(selectedDay);
  Function (DateTime selectedDay) onAddPray = (selectedDay) => throw UnimplementedError();

  @override
  Future<bool> createUser(Map<String, dynamic> dataUser) => onCreateUser(dataUser);
  Future<bool> Function(Map<String, dynamic> dataUser) onCreateUser = (dataUser) => throw UnimplementedError();

  @override
  int getLostDays() {
    throw UnimplementedError();
  }

  @override
  int getPrayDays() {
    throw UnimplementedError();
  }

  @override
  Future<UserIpray?> getUser(String email) => onGetUser(email);
  Future<UserIpray?> Function(String email) onGetUser = (email) => throw UnimplementedError();

  @override
  removePray(DateTime selectedDay) => onRemovePray(selectedDay);
  Function (DateTime selectedDay) onRemovePray = (selectedDay) => throw UnimplementedError();

  @override
  setUser(UserIpray newUser) => onSetUser(newUser);
  Function (UserIpray newUser) onSetUser = (newUser) => throw UnimplementedError();


  @override
  verifyUser() {}
}
