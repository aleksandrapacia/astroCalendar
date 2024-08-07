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
  late Map<DateTime, List<String>> _events;

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
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: DateTime.now(),
              calendarStyle: const CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _events.keys.length,
                itemBuilder: (context, index) {
                  DateTime date = _events.keys.elementAt(index);
                  return ListTile(
                    title: Text(
                      date.toLocal().toString().split(' ')[0],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          _events[date]!.map((event) => Text(event)).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
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
}
