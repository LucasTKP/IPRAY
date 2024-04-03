import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:provider/provider.dart';

class StepOne extends StatefulWidget {
  const StepOne({
    super.key,
  });

  @override
  State<StepOne> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<StepOne> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Digite seu nome, ele aparecerá para todos os usuários.',
          style: TextStyle(
            color: Color(0xFF585858),
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Nome',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18),
        ),
        Consumer<UserController>(builder: (_, controller, child) {
          return TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[(0-9, a-z, A-Z)]"))
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu nome.';
              } else if (value.length < 4) {
                return 'Seu nome precisa no minímo ter 4 letras.';
              }
              return null;
            },
            controller: controller.name,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              hintText: 'Digite seu nome',
            ),
          );
        })
      ],
    );
  }
}
