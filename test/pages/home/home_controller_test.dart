import 'package:flutter_test/flutter_test.dart';
import 'package:ipray/variables/variables_bible_phrases.dart';
import 'package:ipray/pages/home/home_controller.dart';
import '../../mock/mock_date_time_controller.dart';

void main() {
  late HomeController controller;
  late VariablesPhrases variablesPhrases;
  late MockDateTimeController dateTimeController;

  setUp(() {
    dateTimeController = MockDateTimeController();
    variablesPhrases = VariablesPhrases();
    controller = HomeController(
      variablesPhrases: variablesPhrases,
      dateTimeController: dateTimeController,
    );
  });

  test('HomeController.getImagePath()', () {
    // Arrange
    dateTimeController.onGetNowZeroTime = () => DateTime(2024, 4, 15, 0, 0, 0, 0, 0);

    // Act
    String imagePath = controller.getImagePath();

    // Assert
    expect(imagePath, 'assets/images/monday.png');
  });

  test('HomeController.getPhrase', () {
    // Arrange
    dateTimeController.onGetNowZeroTime = () => DateTime(2024, 4, 15, 0, 0, 0, 0, 0);

    // Act
    String phrase = controller.getPhrase();

    // Assert
    expect(phrase,
        'Portanto, não se preocupem com o amanhã, pois o amanhã trará suas próprias preocupações. Basta a cada dia o seu próprio mal.');
  });

  test('HomeController.getAuthorOfPhrase()', () {
    // Arrange

    // Act
    String author = controller.getAuthorOfPhrase();

    // Assert
    expect(author, 'Salmos 23:1');
  });
}
