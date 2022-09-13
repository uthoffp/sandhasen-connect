import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:sandhasen_connect/view/pages/admin/newevent_page.dart';
import 'package:sandhasen_connect/view/pages/home/event_page.dart';

class EventListItem extends StatelessWidget {
  final Event _event;
  final bool asAdmin;

  const EventListItem(this._event, {this.asAdmin = false, Key? key})
      : super(key: key);

  Color _setStatusColor() {
    if (_event.canceled) {
      return const Color(0xffd50000);
    } else if (_event.confirmed) {
      return const Color(0xff43a047);
    } else {
      return const Color(0xff78909c);
    }
  }

  IconData _setLocationIcon() {
    if (_event.ownAppointment) {
      return Icons.home;
    } else {
      return Icons.directions_car;
    }
  }

  Widget _setNextPage() {
    if (asAdmin) {
      return const NewEventPage();
    }
    return EventPage(event: _event);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: _setStatusColor()),
            width: 10.0,
            height: 60.0,
          ),
          const Spacer(),
          Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(4), child: Text(_event.name)),
              Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(_event.dateMeeting.toString())),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(_setLocationIcon(), color: Colors.black54),
          )
        ],
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => _setNextPage()));
      },
    );
  }
}
