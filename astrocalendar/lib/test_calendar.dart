import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TestCalendar extends StatefulWidget {
  const TestCalendar({super.key});

  @override
  State<TestCalendar> createState() => _TestCalendarState();
}

class _TestCalendarState extends State<TestCalendar> {
  int currentPageIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test App'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2900, 10, 16),
            focusedDay: DateTime.now(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
