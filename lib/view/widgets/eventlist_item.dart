import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:sandhasen_connect/view/pages/event_page.dart';

class EventListItem extends StatelessWidget {
  final Event _event;
  const EventListItem(this._event);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [Text(_event.name), Text(_event.dateStart.toString())],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventPage(
                      event: _event,
                    )));
      },
    );
  }
}
