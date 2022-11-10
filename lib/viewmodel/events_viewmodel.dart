import 'package:sandhasen_connect/data/firebase/event_requests.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventViewModel {
  bool isFromCache = false;
  late DateTime lastUpdate;
  EventRequest eventRequest = EventRequest();

  static Future<void> addEvent(Event event) async {
    return EventRequest.addEvent(event);
  }

  static Future<void> editEvent(Event event) async {
    return EventRequest.editEvent(event);
  }

  Future<List<List<Event>>> getEvents() async {
    List<Event> events = await eventRequest.getEvents();
    isFromCache = eventRequest.isFromCache;

    if (!isFromCache) {
      lastUpdate = DateTime.now();
      _setLastUpdateFromSharedPrefs();
    } else {
      lastUpdate = await _getLastUpdateFromSharedPrefs();
    }
    return sortEvents(events);
  }

  List<List<Event>> sortEvents(List<Event> events) {
    List<List<Event>> result = List.empty(growable: true);
    int prevEventDateMonth = -1;
    int resultMapIndex = -1;

    for (var event in events) {
      if (event.dateStart.month != prevEventDateMonth) {
        resultMapIndex++;
        prevEventDateMonth = event.dateStart.month;
        result.add(List.empty(growable: true));
      }
      result[resultMapIndex].add(event);
    }

    return result;
  }

  Future<DateTime> _getLastUpdateFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return DateTime.fromMillisecondsSinceEpoch(prefs.getInt("lastUpdate") ?? 0);
  }

  Future<void> _setLastUpdateFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("lastUpdate", lastUpdate.millisecondsSinceEpoch);
  }
}
