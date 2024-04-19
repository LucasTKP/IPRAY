import 'package:intl/intl.dart';

extension DateUtil on DateTime {
  String formatDate() {
    DateFormat formatador = DateFormat.yMMMMd('pt_BR');
    return formatador.format(this);
  }
}
