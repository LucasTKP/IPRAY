import 'package:flutter/material.dart';
import 'package:ipray/components/loading_user_controller.dart';
import 'package:ipray/pages/signUp/widgets/forms_widget.dart';
import 'package:ipray/pages/signUp/widgets/timeline_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFDE78), // #FFDE78
                Color(0xFFFFFFFF), // #FFFFFF
              ],
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: const Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Perfil',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.data_usage_rounded,
                          size: 40,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TimeLine(),
                        SizedBox(width: 20),
                        FormsWidget(),
                      ],
                    ),
                  ],
                ),
              ),
              const LoadingUserController(),
            ],
          ),
        ),
      ),
    );
  }
}
