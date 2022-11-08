import 'package:sandhasen_connect/data/firebase/event_requests.dart';
import 'package:sandhasen_connect/data/model/event.dart';

class EventViewModel {
  bool isFromCache = false;
  late DateTime lastUpdate;
  EventRequest eventRequest = EventRequest();

  static Future<void> addEvent(Event event) async {
    //check correct times

    return EventRequest.addEvent(event);
  }

  static Future<void> editEvent(Event event) async {
    return EventRequest.addEvent(event);
  }

  Future<List<Event>> getEvents() async {
    Future<List<Event>> result = eventRequest.getEvents();
    isFromCache = eventRequest.isFromCache;

    if(!isFromCache) {
      lastUpdate = DateTime.now();
    }
    return result;
  }
}
