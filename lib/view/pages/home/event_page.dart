import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/widgets/message.dart';
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

  Future<void> openMap(String url) async {
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      setState(() {
        Message.show(context, Strings.errorMapOpen);
      });
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
              Text("${Strings.organisation} ${widget.event.organisation}", style: textTheme.headline6),
              const SizedBox(height: 16),
              Text(Strings.address, style: textTheme.headline6),
              Text(widget.event.address.place),
              Text(widget.event.address.street),
              Text("${widget.event.address.postcode} ${widget.event.address.city}"),
              TextButton(
                  onPressed: () => openMap(widget.event.id), child: const Text(Strings.openInMaps)),
              const SizedBox(height: 16),
              Text(Strings.time, style: textTheme.headline6),
              Text("${Strings.meetTime} ${widget.event.dateMeeting}"),
              Text("${Strings.startTime} ${widget.event.dateMeeting}"),
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
                        const Align(alignment: Alignment.centerLeft, child: Text(Strings.confirmed)),
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
                        const Align(alignment: Alignment.centerRight, child: Text(Strings.cancled)),
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
                        const Align(alignment: Alignment.centerLeft, child: Text(Strings.ownAppointment)),
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
                        const Align(alignment: Alignment.centerRight, child: Text(Strings.apperance)),
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
