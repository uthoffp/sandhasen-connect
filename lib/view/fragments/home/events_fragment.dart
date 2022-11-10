import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:sandhasen_connect/extensions/date_extension.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/widgets/eventlist_item.dart';
import 'package:sandhasen_connect/view/widgets/message.dart';
import 'package:sandhasen_connect/viewmodel/events_viewmodel.dart';

class EventsFragment extends StatefulWidget {
  const EventsFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventsFragmentState();
}

class _EventsFragmentState extends State<EventsFragment> {
  List<List<Event>> events = List.empty();
  EventViewModel eventViewModel = EventViewModel();
  String lastUpdated = "";

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    eventViewModel.getEvents().then((value) {
      setState(() {
        events = value;
        lastUpdated = eventViewModel.lastUpdate.toGermanDateFormat;

        if(eventViewModel.isFromCache) {
          Message.show(context, Strings.errorRequest);
        }
      });
    }).onError((error, stackTrace) {
      setState(() {
        Message.show(context, Strings.errorRequest);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(alignment: Alignment.topRight, child: Text("${Strings.state} $lastUpdated")),
        RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.separated(
            itemCount: events.length,
            itemBuilder: (_, int index) => EventListItem(events[index][0], withTopPadding: index == 0),
            separatorBuilder: (_, int index) => const Divider(),
          ),
        ),
      ]
    );
  }
}