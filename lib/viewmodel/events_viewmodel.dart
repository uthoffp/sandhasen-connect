import 'package:sandhasen_connect/data/firebase/event_requests.dart';
import 'package:sandhasen_connect/data/model/event.dart';

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

    if(!isFromCache) {
      lastUpdate = DateTime.now();
    }
    return sortEvents(events);
  }

  List<List<Event>> sortEvents(List<Event> events) {
    List<List<Event>> result = List.empty();
    int prevEventDateMonth = -1;
    int resultMapIndex = -1;

    for (var event in events) {
      if(event.dateStart.month == prevEventDateMonth) {
        result[resultMapIndex].add(event);
      } else {
        resultMapIndex++;
        result[resultMapIndex] = List.empty();
      }
    }

    return result;
  }
}
