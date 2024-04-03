import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/service/dio_service_imp.dart';
import 'package:ipray/service/sington_service.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  UserController controller = UserController(DioServiceImp());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        controller.getUser(user.email!).then((response) {
          if (response != null) {
            if (response.id != 0) {
              SingtonService().user = response;
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              Navigator.pushReplacementNamed(context, '/signup');
            }
          }
        });
      } else {
        await Future.delayed(const Duration(seconds: 2));

        if (mounted) Navigator.pushReplacementNamed(context, '/signin');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE9A5), // #FFDE78
              Color(0xFFFFFFFF), // #FFFFFF
            ],
          ),
        ),
        child: Center(
          child: Lottie.asset('assets/lotties/lottieSplashPage.json'),
        ),
      ),
    );
  }
}
