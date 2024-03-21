// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/controllers/variables_address.dart';

class StepThree extends StatefulWidget {
  String? state;
  String? city;
  final UserController controller;

  StepThree({
    super.key,
    this.state,
    this.city,
    required this.controller,
  });

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  VariablesAddress variablesAddress = VariablesAddress();
  List<String> cities = [];

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
          onChanged: (String? newValue) {
            setState(() {
              widget.state = newValue;
              cities = widget.controller.changeState(newValue!);
            });
          },
          value: widget.state,
          items: variablesAddress.states
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
        if (widget.state != null) // Verifique se o estado foi selecionado
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cidade',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18),
              ),
              DropdownButtonFormField<String>(
                onChanged: (String? newValue) {
                  setState(() {
                    widget.city = newValue;
                  });
                },
                value: widget.city,
                items: cities.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
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
