import 'package:flutter/material.dart';
import 'package:ipray/pages/signUp/signUp_page.dart';
import 'package:ipray/pages/signin_page.dart';
import 'package:ipray/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      initialRoute: '/record',
      routes: {
        '/splash': (_) => const SplashPage(),
        '/signin': (_) => const SignInPage(),
        '/record': (_) => const SignUpPage()
      },
    );
  }
}
