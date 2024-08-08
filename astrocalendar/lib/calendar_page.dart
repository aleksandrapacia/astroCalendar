import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'event_provider.dart';
import 'list_page.dart';
import 'listing_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int currentPageIndex = 0;
  late Map<DateTime, List<Event>> _events;

  static final List<Widget> _pages = <Widget>[
    const CalendarPage(),
    const ListPage(),
    const ListingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    _events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Center(
        child: TableCalendar(
          locale: 'en_US',
          rowHeight: 43.0,
          headerStyle: const HeaderStyle(
              titleCentered: true, formatButtonVisible: false),
          firstDay: DateTime.utc(2000, 1, 1),
          lastDay: DateTime.utc(2100, 12, 31),
          focusedDay: DateTime.now(),
          eventLoader: (day) => _events[day] ?? [],
          //TODO: why ??????????
          selectedDayPredicate: (day) => isSameDay(DateTime.now(), day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              selectedDay = selectedDay;
            });
            _showEventDetails(selectedDay);
          },
          calendarStyle: const CalendarStyle(
            markerDecoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEventDetails(DateTime date) {
    final events = _events[date] ?? [];

    if (events.isEmpty) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return ListTile(
              title: Text(event.observation),
              subtitle: Text(event.telescope),
            );
          },
        ),
      ),
    );
  }
}
