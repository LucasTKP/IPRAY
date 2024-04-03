import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ipray/controllers/variables_bibleVerse.dart';

class PhraseDaily extends StatelessWidget {
  const PhraseDaily({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int diaDoMes = now.day;
    
    VariablesPhrases variablesPhrases = VariablesPhrases();
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
                  '"${variablesPhrases.bibleVerses[diaDoMes].frase}"',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "${variablesPhrases.bibleVerses[0].livro} ${variablesPhrases.bibleVerses[0].capitulo}:${variablesPhrases.bibleVerses[0].versiculo}",
                  style: const TextStyle(fontWeight: FontWeight.w500),),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
