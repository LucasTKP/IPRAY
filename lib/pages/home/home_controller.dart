import 'package:ipray/variables/variables_bible_phrases.dart';

import '../../controllers/date_time_controller.dart';

class HomeController {
  final VariablesPhrases variablesPhrases;
  final DateTimeController dateTimeController;

  HomeController({required this.variablesPhrases, required this.dateTimeController});

  String getImagePath() {
    DateTime now = dateTimeController.getNowZeroTime();
    int dayOfWeek = now.weekday;
    String dayName = '';

    switch (dayOfWeek) {
      case 1:
        dayName = 'monday';
        break;
      case 2:
        dayName = 'tuesday';
        break;
      case 3:
        dayName = 'wednesday';
        break;
      case 4:
        dayName = 'thursday';
        break;
      case 5:
        dayName = 'friday';
        break;
      case 6:
        dayName = 'saturday';
        break;
      case 7:
        dayName = 'sunday';
        break;
    }

    String imagePath = 'assets/images/$dayName.png';

    return imagePath;
  }

  String getPhrase() {
    DateTime now = dateTimeController.getNowZeroTime();
    int diaDoMes = now.day;

    return variablesPhrases.bibleVerses[diaDoMes].frase;
  }

  String getAuthorOfPhrase() {
    String author = "${variablesPhrases.bibleVerses[0].livro} ${variablesPhrases.bibleVerses[0].capitulo}:${variablesPhrases.bibleVerses[0].versiculo}";
    return author;
  }
}
