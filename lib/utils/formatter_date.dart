import 'package:intl/intl.dart';

String formatDate(String dataString) {
  DateTime date = DateTime.parse(dataString);
  DateFormat formatador = DateFormat.yMMMMd('pt_BR');
  return formatador.format(date);
}
