import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_provider.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  late Map<DateTime, List<String>> _events;
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
          return ListTile(
            title: Text(
              date.toLocal().toString().split(' ')[0],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _events[date]!.map((event) => Text(event)).toList(),
            ),
          );
        },
      ),
    );
  }
}
