import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sandhasen_connect/data/model/event.dart';

class EventRequest {
  static Future<void> addEvent(Event event) {
    CollectionReference eventRef =
        FirebaseFirestore.instance.collection('event');
    return eventRef.add({
      'name': event.name,
      'organisation': event.organisation,
      'address': {
        'place': event.address.place,
        'street': event.address.street,
        'postcode': event.address.postcode,
        'city': event.address.city,
      },
      'canceled': event.canceled,
      'confirmed': event.confirmed,
      'ownAppereance': event.ownAppereance,
      'ownAppointment': event.ownAppointment,
      'dateStart': event.dateStart,
      'dateMeeting': event.dateMeeting,
      'comment': event.comment,
    });
  }
}
