import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StepTwo extends StatefulWidget {
  final TextEditingController age;
  const StepTwo({super.key, required this.age});

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
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
              return 'O número precisa ser maior que 10.';
            }

            if (intValue >= 120) {
              return 'O número precisa ser menor que 120.';
            }

            return null;
          },
          controller: widget.age,
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
