import 'package:flutter/material.dart';
import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/pages/homePage/home_page.dart';
import 'package:ipray/pages/signUp/signUp_page.dart';
import 'package:ipray/pages/signin_page.dart';
import 'package:ipray/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ipray/service/dio_service_imp.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initializeDateFormatting().then(
    (_) => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController(DioServiceImp())),
        ChangeNotifierProvider(create: (_) => PrayController(DioServiceImp())),
      ],
      child: const MyApp(),
    )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPRAY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashPage(),
        '/signin': (_) => const SignInPage(),
        '/signup': (_) => const SignupPage(),
        '/home': (_) => const HomePage()
      },
    );
  }
}
