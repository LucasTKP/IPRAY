import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipray/controllers/variables_address.dart';
import 'package:ipray/models/users_models.dart';

class UserController {
  VariablesAddress variablesAddress = VariablesAddress();
  ValueNotifier<UserIpray?> user = ValueNotifier<UserIpray?>(null);
  ValueNotifier<int> step = ValueNotifier<int>(1);

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void increment() {
    step.value += 1;
  }

  void decrement() {
    if (step.value > 0) {
      step.value -= 1;
    }
  }

  void signUp() {}

  List<String> changeState(String state) {
    switch (state) {
      case "Acre":
        return variablesAddress.ac;
      case "Alagoas":
        return variablesAddress.al;
      case "Amapá":
        return variablesAddress.ap;
      case "Amazonas":
        return variablesAddress.am;
      case "Bahia":
        return variablesAddress.ba;
      case "Ceará":
        return variablesAddress.ce;
      case "Distrito Federal":
        return variablesAddress.df;
      case "Espírito Santo":
        return variablesAddress.es;
      case "Goiás":
        return variablesAddress.go;
      case "Maranhão":
        return variablesAddress.ma;
      case "Mato Grosso":
        return variablesAddress.mt;
      case "Mato Grosso do Sul":
        return variablesAddress.ms;
      case "Minas Gerais":
        return variablesAddress.mg;
      case "Pará":
        return variablesAddress.pa;
      case "Paraíba":
        return variablesAddress.pb;
      case "Paraná":
        return variablesAddress.pr;
      case "Pernambuco":
        return variablesAddress.pe;
      case "Piauí":
        return variablesAddress.pi;
      case "Rio de Janeiro":
        return variablesAddress.rj;
      case "Rio Grande do Norte":
        return variablesAddress.rn;
      case "Rio Grande do Sul":
        return variablesAddress.rs;
      case "Rondônia":
        return variablesAddress.ro;
      case "Roraima":
        return variablesAddress.rr;
      case "Santa Catarina":
        return variablesAddress.sc;
      case "São Paulo":
        return variablesAddress.sp;
      case "Sergipe":
        return variablesAddress.se;
      case "Tocantins":
        return variablesAddress.to;
      default:
        return [];
    }
  }

  void verificationsSignUp(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      if (step.value < 3) {
        increment();
      } else if (step.value == 3) {
        signUp();
      }
    }
  }
}
