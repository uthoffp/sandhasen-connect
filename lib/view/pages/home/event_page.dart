import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  void initState() {
    super.initState();
  }

  static Future<void> openMap(String url) async {
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(widget.event.name)),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Organisation: ${widget.event.organisation}", style: textTheme.headline6),
              const SizedBox(height: 16),
              Text("Addresse:", style: textTheme.headline6),
              Text(widget.event.address.place),
              Text(widget.event.address.street),
              Text("${widget.event.address.postcode} ${widget.event.address.city}"),
              TextButton(
                  onPressed: () => openMap("https://goo.gl/maps/YgdgCJq9N4xrfnBk9"), child: const Text("In Maps öffnen")),
              const SizedBox(height: 16),
              Text("Zeitpunkt:", style: textTheme.headline6),
              Text("Treffen: ${widget.event.dateMeeting}"),
              Text("Start: ${widget.event.dateMeeting}"),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                              value: widget.event.confirmed,
                              onChanged: (bool? value) {},
                            )),
                        Align(alignment: Alignment.centerLeft, child: Text("Bestätigt")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                              value: widget.event.canceled,
                              onChanged: (bool? value) {},
                            )),
                        Align(alignment: Alignment.centerRight, child: Text("Abgesagt")),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                              value: widget.event.ownAppointment,
                              onChanged: (bool? value) {},
                            )),
                        Align(alignment: Alignment.centerLeft, child: Text("Anwesenheit")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                              value: widget.event.ownAppereance,
                              onChanged: (bool? value) {},
                            )),
                        Align(alignment: Alignment.centerRight, child: Text("Eigener Auftritt")),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
