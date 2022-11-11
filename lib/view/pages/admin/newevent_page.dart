
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/firebase/notification.dart';
import 'package:sandhasen_connect/data/model/address.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:sandhasen_connect/extensions/date_extension.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/widgets/message.dart';
import 'package:sandhasen_connect/viewmodel/events_viewmodel.dart';

class NewEventPage extends StatefulWidget {
  NewEventPage({this.event, this.newEvent = true, Key? key}) : super(key: key);

  Event? event;
  bool newEvent;

  @override
  _NewEventPageState createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController orgCtr = TextEditingController();
  TextEditingController placeCtr = TextEditingController();
  TextEditingController streetCtr = TextEditingController();
  TextEditingController plzCtr = TextEditingController();
  TextEditingController cityCtr = TextEditingController();
  TextEditingController mapsCtr = TextEditingController();
  TextEditingController commentCtr = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController meetTime = TextEditingController();
  TextEditingController notificationTextCtr = TextEditingController();

  bool confirmed = false;
  bool cancled = false;
  bool ownAppointment = false;
  bool ownApperance = false;

  var dateSelected = DateTime.now();
  var pickerStartTime = TimeOfDay.now();
  var pickerMeetTime = TimeOfDay.now();

  void showNotificationDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text(Strings.dialogHeadNotification),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(Strings.dialogBodyNotification),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: notificationTextCtr,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: Strings.dialogTextFieldNotification,
                        labelText: Strings.dialogTextFieldNotification,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text(Strings.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(Strings.no),
                  onPressed: () {
                    saveEvent(false);
                  },
                ),
                TextButton(
                  child: const Text(Strings.yes),
                  onPressed: () {
                    saveEvent(true);
                  },
                )
              ],
            ));
  }

  void saveEvent(bool showNotification) {
    var startTime = dateSelected;
    var meetTime = dateSelected;

    startTime.setTime(pickerStartTime);
    meetTime.setTime(pickerMeetTime);

    Event event = Event(
        widget.newEvent ? null : widget.event?.id,
        nameCtr.text,
        orgCtr.text,
        Address(cityCtr.text, streetCtr.text, plzCtr.text, placeCtr.text),
        cancled,
        confirmed,
        ownApperance,
        ownAppointment,
        startTime,
        meetTime,
        commentCtr.text);

    Future<void> response;
    if (widget.newEvent) {
      response = EventViewModel.addEvent(event);
    } else {
      response = EventViewModel.editEvent(event);
    }

    response.then((value) {
      String notificationText = notificationTextCtr.text;
      if (showNotification) {
        FirebaseNotification.sendNotification(
            widget.newEvent ? Strings.newEvent : Strings.editEvent,
            notificationText.isNotEmpty
                ? notificationText
                : Strings.notificationBodyNewEvent);
      }
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      setState(() {
        Message.show(context, Strings.errorSave);
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (!widget.newEvent && widget.event != null) {
      setState(() {
        Event event = widget.event!;

        nameCtr.text = event.name;
        orgCtr.text = event.organisation;
        placeCtr.text = event.address.place;
        streetCtr.text = event.address.street;
        plzCtr.text = event.address.postcode;
        cityCtr.text = event.address.city;
        commentCtr.text = event.comment;

        date.text = event.dateStart.toGermanDateFormat;
        startTime.text = event.dateStart.toTime;
        meetTime.text = event.dateMeeting.toTime;
        pickerStartTime = TimeOfDay.fromDateTime(event.dateStart);
        pickerMeetTime = TimeOfDay.fromDateTime(event.dateMeeting);

        confirmed = event.confirmed;
        ownAppointment = event.ownAppointment;
        cancled = event.canceled;
        ownApperance = event.ownAppereance;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateSelected,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateSelected) {
      setState(() {
        dateSelected = picked;
        date.text = dateSelected.toGermanDateFormat;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, String type) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: type == Strings.start ? pickerStartTime : pickerMeetTime);
    if (picked != null) {
      setState(() {
        if (type == Strings.start) {
          pickerStartTime = picked;
          startTime.text = pickerStartTime.format(context);
        } else {
          pickerMeetTime = picked;
          meetTime.text = pickerMeetTime.format(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.newEvent ? Strings.newEvent : Strings.editedEvent)),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: nameCtr,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: Strings.eventName,
                  labelText: Strings.name,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: orgCtr,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: Strings.organisator,
                  labelText: Strings.organisator,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                child: Text(Strings.address,
                    style: Theme.of(context).textTheme.headline6),
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: placeCtr,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: Strings.place,
                  labelText: Strings.place,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: streetCtr,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: Strings.street,
                  labelText: Strings.street,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: plzCtr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: Strings.postcode,
                          labelText: Strings.postcode,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: cityCtr,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: Strings.city,
                        labelText: Strings.city,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Align(
                child: Text(Strings.time,
                    style: Theme.of(context).textTheme.headline6),
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: date,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: Strings.date,
                  labelText: Strings.date,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: meetTime,
                        readOnly: true,
                        onTap: () => _selectTime(context, Strings.meetTime),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: Strings.meeting,
                          labelText: Strings.meeting,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: startTime,
                        readOnly: true,
                        onTap: () => _selectTime(context, Strings.start),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: Strings.start,
                          labelText: Strings.start,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                child: Text(Strings.menuInfo,
                    style: Theme.of(context).textTheme.headline6),
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                                value: confirmed,
                                onChanged: (value) {
                                  setState(() {
                                    confirmed = value!;
                                  });
                                })),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(Strings.confirmed)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                                value: cancled,
                                onChanged: (value) {
                                  setState(() {
                                    cancled = value!;
                                  });
                                })),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Text(Strings.cancled)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                                value: ownAppointment,
                                onChanged: (value) {
                                  setState(() {
                                    ownAppointment = value!;
                                  });
                                })),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(Strings.ownAppointment)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                                value: ownApperance,
                                onChanged: (value) {
                                  setState(() {
                                    ownApperance = value!;
                                  });
                                })),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Text(Strings.apperance)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(
                      40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  showNotificationDialog();
                },
                icon: const Icon(Icons.save, size: 18),
                label: const Text(Strings.save),
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
