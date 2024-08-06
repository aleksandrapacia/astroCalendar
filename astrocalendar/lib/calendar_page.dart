import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(
            () {
              currentPageIndex = index;
            },
          );
          indicatorColor:
          Colors.amber;
          selectedIndex:
          currentPageIndex;
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
          ),
          NavigationDestination(
              selectedIcon: Icon(Icons.list),
              icon: Icon(Icons.list_outlined),
              label: 'List'),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: DateTime.now(),
            ),
          ],
        ),
      ),
    );
  }
}
