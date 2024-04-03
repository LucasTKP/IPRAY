import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';

class StepThree extends StatefulWidget {
  final UserController controller;

  const StepThree({
    super.key,
    required this.controller,
  });

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {


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
          value: widget.controller.currentState,
          onChanged: (String? newValue) {
            widget.controller.updateState(newValue!);
            setState(() {
              widget.controller.currentCity = null;
              widget.controller.currentState = newValue;
            });
            widget.controller.cities.value = widget.controller.changeState(newValue);
          },
          items: widget.controller.variablesAddress.states
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
        ValueListenableBuilder(
            valueListenable: widget.controller.cities,
            builder:
                (BuildContext context, List<String> cities, Widget? child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cidade',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButtonFormField<String>(
                    value: widget.controller.currentCity,
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.controller.currentCity = newValue;
                      });
                      widget.controller.updateCity(newValue!);
                    },
                    items: cities.map<DropdownMenuItem<String>>(
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
              );
            }),
      ],
    );
  }
}
