import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_provider.dart';

//add event page
class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _formKey = GlobalKey<FormState>();
  final _eventController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _eventController,
                decoration: const InputDecoration(labelText: 'Wydarzenie'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę wpisać wydarzenie';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        _selectedDate = date;
                      });
                    }
                  });
                },
                child: Text(
                    'Wybierz datę: ${_selectedDate.toLocal()}'.split(' ')[0]),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<EventProvider>(context, listen: false)
                        .addEvent(_selectedDate, _eventController.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add an event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
