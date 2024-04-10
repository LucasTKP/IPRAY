import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/pages/signUp/widgets/step_one.dart';
import 'package:ipray/pages/signUp/widgets/step_three.dart';
import 'package:ipray/pages/signUp/widgets/step_two.dart';
import 'package:provider/provider.dart';

class FormsWidget extends StatefulWidget {
  const FormsWidget({super.key});

  @override
  State<FormsWidget> createState() => _FormsWidgetState();
}

class _FormsWidgetState extends State<FormsWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<UserController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Form(
            key: controller.formKey,
            child: Column(
              children: [
                controller.step == 1
                    ? const StepOne()
                    : controller.step == 2
                        ? const StepTwo()
                        : const StepThree(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.step > 1
                        ? InkWell(
                            onTap: () => controller.setStepDecrement(),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_rounded,
                                  color: Color(0xFF585858),
                                ),
                                Text(
                                  'Voltar',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF585858),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    ElevatedButton(
                      onPressed: () {
                        controller.setIsLoading(true);
                        controller.verificationsSignUp().then(
                          (response) {
                            if (response) {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                            controller.setIsLoading(false);
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xFFBF9000),
                            width: 2,
                          ),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 227, 136),
                      ),
                      child: Text(
                        controller.step < 3 ? 'Próximo' : 'Finalizar',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 95, 95, 95),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
