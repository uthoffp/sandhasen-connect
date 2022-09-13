import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/firebase/notification.dart';
import 'package:sandhasen_connect/data/model/address.dart';
import 'package:sandhasen_connect/data/model/event.dart';
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

  bool confirmed = false;
  bool cancled = false;
  bool ownAppointment = false;
  bool ownApperance = false;

  void onClickSave() {
    showDialog(context: context, builder: (_) =>
        AlertDialog(
          title: const Text("Benachrichtigung senden?"),
          content: const Text("Soll eine Benachrichtigung an die Benutzer der App gesendet werden?"),
          actions: [
            TextButton(
              child: const Text("Abbrechen"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Nein"),
              onPressed: () {
                saveEvent();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Ja"),
              onPressed: () {
                saveEvent();
                FirebaseNotification.sendNotification("Neuer Termin", "Es wurde ein neuer Termin eingestellt.");
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        ));
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
        commentCtr.text);
    EventViewModel.addEvent(event);
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
      appBar: AppBar(title: Text("Neuer Termin")),
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
                  hintText: "Name des Termins",
                  labelText: "Name",
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
                  hintText: "Organisator",
                  labelText: "Organisator",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                child: Text("Addresse",
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
                  hintText: "Ort",
                  labelText: "Ort",
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
                  hintText: "Straße, Nr.",
                  labelText: "Straße, Nr.",
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
                          hintText: "Postleitzahl",
                          labelText: "Postleitzahl",
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
                        hintText: "Stadt",
                        labelText: "Stadt",
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
                  hintText: "Google Maps URL",
                  labelText: "Google Maps URL",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                child: Text("Zeitpunkt",
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
                Text("Infos", style: Theme
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
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Bestätigt")),
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
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text("Abgesagt")),
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
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Anwesenheit")),
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
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text("Eigener Auftritt")),
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
                  minimumSize: const Size.fromHeight(
                      40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  onClickSave();
                },
                icon: const Icon(Icons.save, size: 18),
                label: const Text("Speichern"),
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
