import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Map<DateTime, List<String>> _events;

  @override
  Widget build(BuildContext context) {
    _events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      appBar: AppBar(title: const Text('List')),
      body: Expanded(
        child: ListView.builder(
          itemCount: _events.keys.length,
          itemBuilder: (context, index) {
            DateTime date = _events.keys.elementAt(index);
            return ListTile(
              title: Text(date.toLocal().toString().split(' ')[0]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _events[date]!.map((event) => Text(event)).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
