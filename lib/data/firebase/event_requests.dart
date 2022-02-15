import 'package:sandhasen_connect/data/model/address.dart';

class Event {
  String name;
  String organisation;
  Address address;
  bool canceled;
  bool confirmed;
  bool ownAppereance;
  bool ownAppointment;
  DateTime dateStart;
  DateTime dateMeeting;
  DateTime lastModified;
  String comment;

  Event(this.name, this.organisation, this.address, this.canceled, this.confirmed, this.ownAppereance,
      this.ownAppointment, this.dateStart, this.dateMeeting, this.lastModified, this.comment);
}