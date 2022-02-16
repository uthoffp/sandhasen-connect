import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/firebase/event_requests.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(8),
            ),
          )
        ],
      ),
    );
  }
}
