import 'package:flutter/material.dart';
import 'package:ipray/pages/signup/signup_controller.dart';

class StepThree extends StatelessWidget {
  const StepThree({
    super.key,
    required this.signUpController,
  });

  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cadastre sua localidade',
          style: TextStyle(
            color: Color(0xFF585858),
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Estado',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18),
        ),
        DropdownButtonFormField<String>(
          value: signUpController.state,
          onChanged: (String? newValue) {
            signUpController.setState(newValue);
            signUpController.setCity(null);
            signUpController.setCities(signUpController.changeState(newValue!));
          },
          items: signUpController.variablesAddress.states.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: const InputDecoration(
            hintText: 'Selecione um estado',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, selecione um estado.';
            }

            return null;
          },
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cidade',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 18),
            ),
            DropdownButtonFormField<String>(
              value: signUpController.city,
              onChanged: (String? newValue) {
                signUpController.setCity(newValue!);
              },
              items: signUpController.cities.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ).toList(),
              decoration: const InputDecoration(
                hintText: 'Selecione uma cidade',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, selecione uma cidade.';
                }

                return null;
              },
            ),
          ],
        ),
      ],
    );
  }
}
