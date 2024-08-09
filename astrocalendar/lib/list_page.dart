import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_provider.dart';

//add event page
class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.selectedDate});
  final DateTime selectedDate;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _formKey = GlobalKey<FormState>();
  final _observationController = TextEditingController();
  final _telescopeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observation Editor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _observationController,
                decoration:
                    const InputDecoration(labelText: 'Observation Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name of the observation is required.';
                  }
                  return null;
                },
              ),
              TextFormField(
                  controller: _telescopeController,
                  decoration:
                      const InputDecoration(labelText: 'Telescope Name ')),
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
                child: Text('Date ${_selectedDate.toLocal()}'.split(' ')[0]),
              ),
              const SizedBox(height: 20),
              // adding an event with a button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Event newEvent = Event(
                        observation: _observationController.text,
                        telescope: _telescopeController.text);
                    Provider.of<EventProvider>(context, listen: false)
                        .addEvent(_selectedDate, newEvent);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Observation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
