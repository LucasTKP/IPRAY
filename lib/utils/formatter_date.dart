import 'package:intl/intl.dart';

extension DateUtil on DateTime {
  String formatDateDescriptive() {
    DateFormat formatter = DateFormat.yMMMMd('pt_BR');
    return formatter.format(this);
  }

  DateTime formatDate() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(this);
    return formatter.parseStrict(formattedDate);
  }
}
