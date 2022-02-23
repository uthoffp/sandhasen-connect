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

  Event(
      this.id,
      this.name,
      this.organisation,
      this.address,
      this.canceled,
      this.confirmed,
      this.ownAppereance,
      this.ownAppointment,
      this.dateStart,
      this.dateMeeting,
      this.comment);
}
