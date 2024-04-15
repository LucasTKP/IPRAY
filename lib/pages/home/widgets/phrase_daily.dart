import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ipray/pages/home/home_controller.dart';

class PhraseDaily extends StatelessWidget {
  const PhraseDaily({super.key, required this.homeController});
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Frase Diária',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xFFEBE0BA),
              border: Border.all(
                color: const Color(0xFFBF9000), // Cor da borda
                width: 2, // Espessura da borda
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  homeController.getPhrase(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    homeController.getAuthorOfPhrase(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
