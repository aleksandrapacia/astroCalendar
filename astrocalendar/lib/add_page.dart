import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_provider.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  // initializing global key -> provides access to State
  final formKey = GlobalKey<FormState>();
  // it will read and control the text which will be input by the user
  final eventController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        //form = widget
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: eventController,
                decoration: const InputDecoration(labelText: 'Observation'),
                validator: (value) {
                  if (value == null) {
                    return 'Type your planned observation';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
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
                  'Select your date: ${_selectedDate.toLocal()}'.split(' ')[0],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Provider.of<EventProvider>(context, listen: false)
                        .addEvent(_selectedDate, eventController.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add observation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
