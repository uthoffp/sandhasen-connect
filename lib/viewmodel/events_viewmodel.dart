import 'package:sandhasen_connect/data/firebase/event_requests.dart';
import 'package:sandhasen_connect/data/model/event.dart';

class EventViewModel {
  static Future<void> addEvent(Event event) async {
    //check correct times

    return EventRequest.addEvent(event);
  }

  static Future<void> editEvent(Event event) async {
    return EventRequest.addEvent(event);
  }
}
