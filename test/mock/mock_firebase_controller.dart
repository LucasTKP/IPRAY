import 'package:firebase_auth/firebase_auth.dart';
import 'package:ipray/controllers/firebase_controller.dart';

class MockFirebaseController extends FirebaseController {
  @override
  String? getEmail() => onGetEmail();
  String? Function() onGetEmail = () => throw UnimplementedError();

  @override
  Future<UserCredential?> getCredential(OAuthCredential credential) => onGetCredential(credential);
  Future<UserCredential?> Function (OAuthCredential credential) onGetCredential = (credential) => throw UnimplementedError();

  @override
  User? getCurrentUser() => onGetCurrentUser();
  User? Function () onGetCurrentUser = () => throw UnimplementedError();
}
