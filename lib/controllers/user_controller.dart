import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipray/controllers/variables_address.dart';
import 'package:ipray/models/users_models.dart';
import 'package:ipray/service/dio_service.dart';

class UserController extends ChangeNotifier {
  final DioService dioService;
  UserController(this.dioService);

  UserIpray? user;
  int step = 1;
  List<String> cities = [];
  bool isLoading = false;
  VariablesAddress variablesAddress = VariablesAddress();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? state;
  String? city;

  Future<UserCredential?> signInWithGoogle(Function(String) onError) async {
    try {
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
      final response =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return response;
    } catch (e) {
      String errorMessage = "Não foi possivel fazer login";
      if (e is PlatformException) {
        errorMessage = "Sem internet, por favor reconecte";
      }
      onError(errorMessage);

      return null;
    }
  }

  Future<UserIpray?> getUser(String email) async {
    try {
      final response =
          await dioService.getDio().get('/users/$email?praies=true');
      if (response.data.length > 0) {
        final data = UserIpray.fromJson(response.data);

        return data;
      }
      return UserIpray(
        id: 0,
        name: "",
        email: "",
        urlImage: "",
        age: 0,
        state: "",
        city: "",
        total: 0,
        streak: 0,
        createdDate: DateTime.now(),
        praies: [],
      );
    } catch (e) {
      debugPrint(e.toString());
      String error = 'Algo deu errado, tente novamente mais tarde.';
      if (e is DioException) {
        if (e.error is SocketException) {
          error = 'Sem internet, por favor reconecte';
        }
      }

      Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

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

  Future<bool> signUp() async {
    try {
      final response = await dioService.getDio().post('/users', data: user);
      if (response.data.length > 0) {
        final data = UserIpray.fromJson(response.data);
        setUser(data);
      }
      return true;
    } catch (e) {
      String error = 'Algo deu errado, tente novamente mais tarde.';
      if (e is DioException) {
        if (e.error is SocketException) {
          error = 'Sem internet, por favor reconecte';
        }
      }

      Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  Future<bool> verificationsSignUp() async {
    if (formKey.currentState!.validate()) {
      if (step < 3) {
        setStepIncrement();
      } else if (step == 3) {
        // user = UserIpray.fromMap(
        //   {
        //     'name': name.text,
        //     'email': FirebaseAuth.instance.currentUser!.email,
        //     'age': int.parse(age.text),
        //     'state': state,
        //     'city': city,
        //     'urlImage': '',
        //     'total': 0,
        //     'streak': 0,
        //   },
        // );
        // return await signUp();
      }
    }
    return false;
  }

  int getLostDays() {
    DateTime tomorrowStart = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
      0,
      0,
      0,
      0,
      0,
    );
    int lostDays = 0;
    if (user != null) {
      DateTime startDate = user?.createdDate ?? DateTime.now();
      int total = user?.total ?? 0;
      int differenceInDays = tomorrowStart.difference(startDate).inDays;
      lostDays = differenceInDays - total;
    }
    return lostDays;
  }

  setUser(UserIpray newUser) {
    user = newUser;
    notifyListeners();
  }

  setStepIncrement() {
    step += 1;
    notifyListeners();
  }

  setStepDecrement() {
    if (step > 0) {
      step -= 1;
      notifyListeners();
    }
  }

  setCities(List<String> newCities) {
    cities = newCities;
    notifyListeners();
  }

  setIsLoading(bool newLoading) {
    isLoading = newLoading;
    notifyListeners();
  }

  setState(String? newState) {
    state = newState;
    city = null;
    notifyListeners();
  }

  setCity(String? newCity) {
    city = newCity;
    notifyListeners();
  }
}
