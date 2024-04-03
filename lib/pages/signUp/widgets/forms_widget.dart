import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/pages/signUp/widgets/step_one.dart';
import 'package:ipray/pages/signUp/widgets/step_three.dart';
import 'package:ipray/pages/signUp/widgets/step_two.dart';

class FormsWidget extends StatefulWidget {
  final UserController controller;

  const FormsWidget({super.key, required this.controller});

  @override
  State<FormsWidget> createState() => _FormsWidgetState();
}

class _FormsWidgetState extends State<FormsWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<int>(
        valueListenable: widget.controller.step,
        builder: (_, step, __) {
          return Form(
            key: widget.controller.formKey,
            child: Column(
              children: [
                step == 1
                    ? StepOne(
                        controller: widget.controller,
                      )
                    : step == 2
                        ? StepTwo(
                            controller: widget.controller,
                          )
                        : StepThree(
                            controller: widget.controller,
                          ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    step > 1
                        ? InkWell(
                            onTap: () => widget.controller.decrement(),
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
                        widget.controller.isLoading.value = true;
                        widget.controller.verificationsSignUp().then(
                          (response) {
                            if (response) {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                            widget.controller.isLoading.value = false;
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
                        step < 3 ? 'Próximo' : 'Finalizar',
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
