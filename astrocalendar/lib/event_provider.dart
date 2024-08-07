import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  final Map<DateTime, List<Event>> _events = {};

  Map<DateTime, List<Event>> get events => _events;

  void addEvent(DateTime date, Event event) {
    if (_events[date] != null) {
      _events[date]!.add(event);
    } else {
      _events[date] = [event];
    }
    notifyListeners();
  }
}

class Event {
  final String observation;
  final String telescope;

  Event({required this.observation, required this.telescope});
}
