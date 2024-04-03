import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipray/pages/homePage/widgets/calendar.dart';
import 'package:ipray/pages/homePage/widgets/imageDaily.dart';
import 'package:ipray/pages/homePage/widgets/phraseDaily.dart';
import 'package:ipray/pages/homePage/widgets/topbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _auth.signOut();
                    await _googleSignIn.signOut();
                    Navigator.pushReplacementNamed(context, '/signin');
                  } catch (e) {
                    print('Error signing out: $e');
                  }
                },
                child: Text('Deslogar'),
              ),
              const TopBar(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: const Column(
                  children: [
                    SizedBox(height: 20),
                    ImageDaily(),
                    PhraseDaily(),
                    Calendar()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
