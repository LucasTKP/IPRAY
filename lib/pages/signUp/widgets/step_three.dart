import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:provider/provider.dart';

class StepThree extends StatefulWidget {
  const StepThree({
    super.key,
  });

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (_, controller, child) {
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
              value: controller.state,
              onChanged: (String? newValue) {
                controller.setState(newValue);
                controller.setCity(null);
                controller.setCities(controller.changeState(newValue!));
              },
              items: controller.variablesAddress.states
                  .map<DropdownMenuItem<String>>((String value) {
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
                  value: controller.city,
                  onChanged: (String? newValue) {
                    controller.setCity(newValue!);
                  },
                  items: controller.cities.map<DropdownMenuItem<String>>(
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
      },
    );
  }
}
