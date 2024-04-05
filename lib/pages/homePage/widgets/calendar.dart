import 'package:flutter/material.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/pages/homePage/widgets/dialog_select_day.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final dateNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Consumer<UserController>(
          builder: (_, controller, __) {
            final user = controller.user;
            final createdDateUser =
                user?.createdDate.subtract(const Duration(days: 1));

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0XFFBF9000), width: 2),
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                locale: 'pt_BR',
                daysOfWeekHeight: 22,
                onDaySelected: (selectedDay, focusedDay) {
                  if (createdDateUser != null) {
                    if (dateNow.isAfter(focusedDay) &&
                        createdDateUser.isBefore(focusedDay)) {
                      dialogSelectDay(context, focusedDay);
                    } else {
                      onError() {
                        const snackBar = SnackBar(
                          content: Text(
                              "Você só pode selecionar algum dia entre o seu cadastro e  o dia de hoje "),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                      onError();
                    }
                  }
                },
                calendarStyle: CalendarStyle(
                  defaultTextStyle: const TextStyle(
                      color: Color(0XFFBF9000),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  todayTextStyle: const TextStyle(
                      color: Color(0XFFBF9000),
                      fontSize: 20,
                      fontWeight: FontWeight.w500), //
                  todayDecoration: BoxDecoration(
                    color: const Color(0XFFEFE6C8),
                    border:
                        Border.all(color: const Color(0XFFBF9000), width: 2),
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: const TextStyle(
                      color: Color(0XFFBF9000),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
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
                  leftChevronIcon: Icon(Icons.chevron_left,
                      color: Color(0XFFBF9000), size: 35),
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
                  weekdayStyle: TextStyle(
                      color: Color(0XFFBF9000),
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  weekendStyle: TextStyle(
                      color: Color(0XFFBF9000),
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (_, day, __) {
                    if (createdDateUser != null && user != null) {
                      final result =
                          user.praies.any((praies) => praies.date == day);
                      if (dateNow.isAfter(day) &&
                          createdDateUser.isBefore(day)) {
                        if (result) {
                          return const Text(
                            '🙏',
                            style: TextStyle(fontSize: 18),
                          );
                        }
                        return const Text('😭', style: TextStyle(fontSize: 18));
                      }
                    }
                    return null;
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
