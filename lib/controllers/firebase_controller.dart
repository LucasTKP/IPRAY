import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseController {
  String? getEmail();

  Future<UserCredential?> getCredential(OAuthCredential credential);

  User? getCurrentUser();
}

class FirebaseControllerImp extends FirebaseController {
  @override
  String? getEmail() {
    return FirebaseAuth.instance.currentUser!.email;
  }

  @override
  Future<UserCredential?> getCredential(OAuthCredential credential) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential;
  }

  @override
  User? getCurrentUser() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return currentUser;
  }
}
