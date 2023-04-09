import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Event {
  final String title;
  final DateTime? date;
  Event({required this.title, this.date});

  String toString() => this.title;
}

class EventStorage {
  static const String _key = 'events';

  Future<List<Event>> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final eventList = prefs.getStringList(_key);
    if (eventList == null) {
      return [];
    }
    return eventList
        .map((event) => Event(title: event, date: DateTime.parse(event)))
        .toList();
  }

  Future<void> saveEvents(List<Event> events) async {
    final prefs = await SharedPreferences.getInstance();
    final eventList = events.map((event) => event.title).toList();
    await prefs.setStringList(_key, eventList);
    await prefs.reload(); // optional
  }
}
