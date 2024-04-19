import 'package:firebase_auth/firebase_auth.dart';
import 'package:ipray/controllers/google_controller.dart';

class MockGoogleController extends GoogleController {
  @override
  Future<OAuthCredential> signIn() => onSignIn();
  Future<OAuthCredential> Function() onSignIn = () => throw UnimplementedError();

}