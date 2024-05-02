import 'package:flutter/material.dart';
import 'package:ipray/pages/signup/signup_controller.dart';
import 'package:ipray/pages/signup/widgets/step_one.dart';
import 'package:ipray/pages/signup/widgets/step_three.dart';
import 'package:ipray/pages/signup/widgets/step_two.dart';

class FormsWidget extends StatelessWidget {
  const FormsWidget({super.key, required this.signUpController});
  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: signUpController.formKey,
        child: Column(
          children: [
            signUpController.step == 1
                ? StepOne(signUpController: signUpController)
                : signUpController.step == 2
                    ? StepTwo(signUpController: signUpController)
                    : StepThree(signUpController: signUpController),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (signUpController.step > 1) ...{
                  InkWell(
                    onTap: () => signUpController.setStepDecrement(),
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
                  ),
                },
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (signUpController.formKey.currentState!.validate()) {
                      signUpController.verificationStepSignUp();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Color(0xFFBF9000),
                        width: 2,
                      ),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 227, 136),
                  ),
                  child: Text(
                    signUpController.step < 3 ? 'Próximo' : 'Finalizar',
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
      ),
    );
  }
}
