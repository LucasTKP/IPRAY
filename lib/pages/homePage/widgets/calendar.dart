import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0XFFBF9000), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            locale: 'pt_BR',
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0XFFBF9000),
              ),
              leftChevronIcon: Icon(Icons.chevron_left, color: Color(0XFFBF9000),),
              rightChevronIcon: Icon(Icons.chevron_right, color: Color(0XFFBF9000),)

            ),
          ),
        ),
      ],
    );
  }
}
