import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/firebase/notification.dart';
import 'package:sandhasen_connect/data/model/address.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/widgets/message.dart';
import 'package:sandhasen_connect/viewmodel/events_viewmodel.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({Key? key}) : super(key: key);

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

  void showNotificationDialog() {
    showDialog(context: context, builder: (_) =>
        AlertDialog(
          title: const Text(Strings.dialogHeadNotification),
          content: Row(
            children: [
              const Text(Strings.dialogBodyNotification),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: orgCtr,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: Strings.dialogTextFieldNotificationHint,
                  labelText: Strings.dialogTextFieldNotificationLabel,
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
                saveEvent();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(Strings.yes),
              onPressed: () {
                saveEvent();
              },
            )
          ],
        )
    );
  }

  void saveEvent() {
    var date = _getDate();
    var startTime = this.startTime.text;
    var meetTime = this.meetTime.text;

    Event event = Event(
        "-1",
        nameCtr.text,
        orgCtr.text,
        Address(cityCtr.text, streetCtr.text, plzCtr.text, placeCtr.text),
        cancled,
        confirmed,
        ownApperance,
        ownAppointment,
        DateTime.parse("$date $startTime"),
        DateTime.parse("$date $meetTime"),
        commentCtr.text
    );

    EventViewModel.addEvent(event)
        .then((value) {
          String notificationText = notificationTextCtr.text;
          FirebaseNotification.sendNotification(
              Strings.newEvent,
              notificationText.isNotEmpty
                  ? notificationText : Strings.notificationBodyNewEvent);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        })
        .onError((error, stackTrace) {
          setState(() {
            Message.show(context, Strings.errorSave);
          });
        });
  }

  String _getDate() {
    var orig = date.text;

    if (orig.length == 10) {
      var day = orig.substring(0, 2);
      var month = orig.substring(3, 5);
      var year = orig.substring(6, 10);
      return "$year-$month-$day";
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.newEvent)),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
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
                height: 8,
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6),
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(
                height: 8,
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
                height: 8,
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
                height: 8,
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
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: mapsCtr,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: Strings.mapsUrl,
                  labelText: Strings.mapsUrl,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                child: Text(Strings.time,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6),
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: date,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: "Datum",
                  labelText: "Datum (DD.MM.JJJJ)",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: meetTime,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: "Treffen",
                          labelText: "Treffen (HH:MM)",
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: "Start",
                          labelText: "Start (HH:MM)",
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
                child:
                Text(Strings.menuInfo, style: Theme
                    .of(context)
                    .textTheme
                    .headline6),
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(
                height: 8,
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
                height: 8,
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
                height: 8,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  showNotificationDialog();
                },
                icon: const Icon(Icons.save, size: 18),
                label: const Text(Strings.save),
              ),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
