import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';

// ignore: must_be_immutable
class CalendarParts extends StatelessWidget {
  CalendarParts({super.key, required this.index});

  final int index;

  DateTime monthFirst = DateTime.now();
  List<String> days = [];
  List<String> youbiList = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  ///
  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    final month = DateTime.now().month;
    final date = DateTime(year, month + index);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date.yyyymm),
          const SizedBox(height: 10),
          _getCalendar(date: date),
        ],
      ),
    );
  }

  ///
  Widget _getCalendar({required DateTime date}) {
    monthFirst = DateTime(date.year, date.month);

    final monthEnd = DateTime(date.year, date.month + 1, 0);

    final diff = monthEnd.difference(monthFirst).inDays;
    final monthDaysNum = diff + 1;

    final youbi = monthFirst.youbiStr;
    final youbiNum = youbiList.indexWhere((element) => element == youbi);

    final weekNum = ((monthDaysNum + youbiNum) <= 35) ? 5 : 6;

    days = List.generate(weekNum * 7, (index) => '');

    for (var i = 0; i < (weekNum * 7); i++) {
      if (i >= youbiNum) {
        final gendate = monthFirst.add(Duration(days: i - youbiNum));

        if (monthFirst.month == gendate.month) {
          days[i] = gendate.day.toString();
        }
      }
    }

    final list = <Widget>[];
    for (var i = 0; i < weekNum; i++) {
      list.add(getRow(week: i));
    }

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 7),
      child: Column(children: list),
    );
  }

  ///
  Widget getRow({required int week}) {
    final list = <Widget>[];

    for (var i = week * 7; i < ((week + 1) * 7); i++) {
      final dispDate = (days[i] == '') ? '' : DateTime(monthFirst.year, monthFirst.month, days[i].toInt()).yyyymmdd;

      list.add(
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(1),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(
                color: (days[i] == '') ? Colors.transparent : Colors.white.withOpacity(0.4),
              ),
            ),
            child: (days[i] == '')
                ? const Text('')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dispDate),
                      const SizedBox(height: 30),
                    ],
                  ),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }
}
