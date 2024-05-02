import 'package:intl/intl.dart';

extension DateUtil on DateTime {
  String formatDateDescriptive() {
    DateFormat formatador = DateFormat.yMMMMd('pt_BR');
    return formatador.format(this);
  }
}
