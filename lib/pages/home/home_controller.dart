import 'package:ipray/controllers/variables_bibleVerse.dart';

class HomeController {
  String getImagePath() {
    DateTime now = DateTime.now();
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
    VariablesPhrases variablesPhrases = VariablesPhrases();
    DateTime now = DateTime.now();
    int diaDoMes = now.day;

    return variablesPhrases.bibleVerses[diaDoMes].frase;
  }

  String getAuthorOfPhrase() {
    VariablesPhrases variablesPhrases = VariablesPhrases();
    String author = "${variablesPhrases.bibleVerses[0].livro} ${variablesPhrases.bibleVerses[0].capitulo}:${variablesPhrases.bibleVerses[0].versiculo}";
    return author;
  }
}
