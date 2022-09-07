import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'address.dart';

class Event {
  String id;
  String name;
  String organisation;
  Address address;
  bool canceled;
  bool confirmed;
  bool ownAppereance;
  bool ownAppointment;
  DateTime dateStart;
  DateTime dateMeeting;
  String comment;

  Event(this.id, this.name, this.organisation, this.address, this.canceled, this.confirmed, this.ownAppereance,
      this.ownAppointment, this.dateStart, this.dateMeeting, this.comment);

  factory Event.fromSnapshot(String id, Map<String, dynamic> snapshot) {
    return Event(
      id,
      snapshot['name'],
      snapshot['organisation'],
      Address.fromSnapshot(snapshot['address']),
      snapshot['canceled'],
      snapshot['confirmed'],
      snapshot['ownAppereance'],
      snapshot['ownAppointment'],
      DateTime.fromMicrosecondsSinceEpoch((snapshot['dateStart'] as Timestamp).microsecondsSinceEpoch),
      DateTime.fromMicrosecondsSinceEpoch((snapshot['dateMeeting'] as Timestamp).microsecondsSinceEpoch),
      snapshot['comment'],
    );
  }
}
