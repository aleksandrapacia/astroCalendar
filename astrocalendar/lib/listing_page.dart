import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_provider.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  late Map<DateTime, List<Event>> _events;
  @override
  Widget build(BuildContext context) {
    _events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observations'),
      ),
      body: ListView.builder(
        itemCount: _events.keys.length,
        itemBuilder: (context, index) {
          DateTime date = _events.keys.elementAt(index);
          List<Event> eventList = _events[date]!;
          return ExpansionTile(
            title: Text(date.toLocal().toString().split(' ')[0]),
            children: eventList
                .map((event) => ListTile(
                      title: Text(event.observation),
                      subtitle: Text(event.telescope),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
