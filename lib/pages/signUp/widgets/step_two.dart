import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipray/pages/signup/signup_controller.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({super.key, required this.signUpController});

  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Digite a sua idade',
          style: TextStyle(
            color: Color(0xFF585858),
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Idade',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira um número.';
            }

            int? intValue = int.tryParse(value);

            if (intValue == null || intValue <= 10) {
              return 'Você precisa ter mais que 10 anos.';
            }

            if (intValue >= 120) {
              return 'Você precisa ter menos que 100 anos.';
            }

            return null;
          },
          controller: signUpController.age,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            hintText: 'Digite sua idade',
          ),
        ),
      ],
    );
  }
}
