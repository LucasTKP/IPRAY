import 'package:flutter/material.dart';
import 'package:ipray/pages/signup/signup_controller.dart';
import 'package:ipray/pages/signup/widgets/forms_widget.dart';
import 'package:ipray/pages/signup/widgets/loading_signup.dart';
import 'package:ipray/pages/signup/widgets/timeline_widget.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key, required this.signUpController});
  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: AnimatedBuilder(
                animation: signUpController,
                builder: (context, child) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFFDE78), 
                          Color(0xFFFFFFFF), 
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              const Row(
                                children: [
                                  Text(
                                    'Perfil',
                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.data_usage_rounded,
                                    size: 40,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TimeLine(controller: signUpController),
                                  const SizedBox(width: 20),
                                  FormsWidget(
                                    signUpController: signUpController,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        LoadingSignUp(signUpController: signUpController),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
