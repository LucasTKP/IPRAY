import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/controllers/variables_address.dart';
import 'package:ipray/shared/app_navigator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpController extends ChangeNotifier {
  final UserController userController;
  final AppNavigator appNavigator;
  SignUpController({required this.userController, required this.appNavigator});

  final supabase = Supabase.instance.client;
  VariablesAddress variablesAddress = VariablesAddress();
  int step = 1;
  List<String> cities = [];
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? state;
  String? city;
  bool isLoading = false;

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

  signUp() async {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0, 0, 0);

    final dataUser = {
      'name': name.text,
      'email': FirebaseAuth.instance.currentUser!.email,
      'age': int.parse(age.text),
      'state': state,
      'city': city,
      'url_image': '',
      'total': 0,
      'streak': 0,
      'created_date': startOfDay.toIso8601String(),
    };
    bool result = await userController.createUser(dataUser);
    if (result) {
      appNavigator.navigateToHome();
    }
  }

  verificationsSignUp() {
    if (formKey.currentState!.validate()) {
      if (step < 3) {
        setStepIncrement();
      } else if (step == 3) {
        setIsLoading(true);
        signUp();
      }
    }
    setIsLoading(false);
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

  setIsLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
}
