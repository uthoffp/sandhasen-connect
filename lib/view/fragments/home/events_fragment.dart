import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:sandhasen_connect/view/widgets/eventlist_item.dart';
import 'package:sandhasen_connect/viewmodel/events_viewmodel.dart';

class EventsFragment extends StatefulWidget {
  const EventsFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventsFragmentState();
}

class _EventsFragmentState extends State<EventsFragment> {
  List<Event> events = List.empty();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    EventViewModel.getEvents().then((value) {
      setState(() {
        events = value;
      });
    }).onError((error, stackTrace) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.separated(
        itemCount: events.length,
        itemBuilder: (_, int index) => EventListItem(events[index]), 
        separatorBuilder: (_, int index) => const Divider(),
      ),
    );
  }
}