import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/pages/signUp/widgets/forms_widget.dart';
import 'package:ipray/pages/signUp/widgets/timeline_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<SignUpPage> {
  UserController controller = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            children: [
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
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TimeLine(controller: controller,),
                    const SizedBox(width: 20),
                    FormsWidget(controller: controller),
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
