import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ipray/utils/formatter_date.dart';

void main() {
  setUpAll(() {
    initializeDateFormatting('pt_BR', null);
  });
  test('DateUtil.formatDate()', () {
    // Arrange
    var date = DateTime(2024, 4, 16);

    // Act
    var response = date.formatDateDescriptive();

    // Assert
    expect(response, "16 de abril de 2024");
  });
}
