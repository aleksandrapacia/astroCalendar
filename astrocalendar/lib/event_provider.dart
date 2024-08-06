import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  final Map<DateTime, List<String>> _events = {};

  Map<DateTime, List<String>> get events => _events;

  void addEvent(DateTime date, String event) {
    if (_events[date] != null) {
      _events[date]!.add(event);
    } else {
      _events[date] = [event];
    }
    notifyListeners();
  }
}
