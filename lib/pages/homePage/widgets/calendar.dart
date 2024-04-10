import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime dateNow;
  final Function(DateTime selectedDay) onDaySelected;
  final Future<String> Function(DateTime day) getDayIcon;
  const Calendar({
    super.key,
    required this.onDaySelected,
    required this.getDayIcon,
    required this.firstDay,
    required this.lastDay,
    required this.dateNow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0XFFBF9000), width: 2),
          ),
          child: TableCalendar(
            firstDay: firstDay,
            lastDay: lastDay,
            focusedDay: dateNow,
            locale: 'pt_BR',
            daysOfWeekHeight: 22,
            calendarStyle: CalendarStyle(
              defaultTextStyle: const TextStyle(color: Color(0XFFBF9000), fontSize: 20, fontWeight: FontWeight.w500),
              todayTextStyle: const TextStyle(color: Color(0XFFBF9000), fontSize: 20, fontWeight: FontWeight.w500), //
              todayDecoration: BoxDecoration(
                color: const Color(0XFFEFE6C8),
                border: Border.all(color: const Color(0XFFBF9000), width: 2),
                shape: BoxShape.circle,
              ),
              weekendTextStyle: const TextStyle(color: Color(0XFFBF9000), fontSize: 20, fontWeight: FontWeight.w500),
              outsideTextStyle: const TextStyle(
                color: Color.fromARGB(255, 218, 199, 145),
                fontSize: 18,
              ),
              markersAlignment: Alignment.bottomRight,
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0XFFBF9000),
              ),
              leftChevronIcon: Icon(Icons.chevron_left, color: Color(0XFFBF9000), size: 35),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Color(0XFFBF9000),
                size: 35,
              ),
              headerPadding: EdgeInsets.all(10),
              leftChevronPadding: EdgeInsets.symmetric(horizontal: 12),
              rightChevronPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Color(0XFFBF9000), fontWeight: FontWeight.w500, fontSize: 16),
              weekendStyle: TextStyle(color: Color(0XFFBF9000), fontWeight: FontWeight.w500, fontSize: 16),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (_, day, __) => FutureBuilder(
                future: getDayIcon(day),
                builder: (context, snapshot) => Text(
                  snapshot.data ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) => onDaySelected(selectedDay),
          ),
        )
      ],
    );
  }
}
