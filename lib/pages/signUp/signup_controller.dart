import 'package:flutter/material.dart';
import 'package:ipray/controllers/date_time_controller.dart';
import 'package:ipray/controllers/firebase_controller.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/variables/variables_address.dart';
import 'package:ipray/shared/app_navigator.dart';

class SignUpController extends ChangeNotifier {
  final UserController userController;
  final AppNavigator appNavigator;
  final FirebaseController firebaseController;
  final DateTimeController dateTimeController;

  SignUpController({required this.userController, required this.appNavigator, required this.firebaseController, required this.dateTimeController});

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
    DateTime dateNow = dateTimeController.getNowZeroTime();

    final dataUser = {
      'name': name.text,
      'email': firebaseController.getEmail(),
      'age': int.parse(age.text),
      'state': state,
      'city': city,
      'url_image': '',
      'total': 0,
      'streak': 0,
      'created_date': dateNow.toIso8601String(),
    };
    bool result = await userController.createUser(dataUser);
    if (result) {
      appNavigator.navigateToRoutes();
    }
  }

  verificationStepSignUp() async {
    if (step < 3) {
      step++;
      notifyListeners();
    } else if (step == 3) {
      setIsLoading(true);
      await signUp();
      setIsLoading(false);
    }
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

  setStepDecrement() {
    if (step > 0) {
      step--;
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
