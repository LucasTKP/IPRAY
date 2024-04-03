import 'package:flutter/material.dart';
import 'package:ipray/components/loading_user_controller.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/pages/signUp/widgets/forms_widget.dart';
import 'package:ipray/pages/signUp/widgets/timeline_widget.dart';
import 'package:ipray/service/dio_service_imp.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final UserController controller = UserController(DioServiceImp());

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
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Row(
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
                    const SizedBox(height: 20),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TimeLine(
                            controller: controller,
                          ),
                          const SizedBox(width: 20),
                          FormsWidget(controller: controller),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              LoadingUserController(controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}
