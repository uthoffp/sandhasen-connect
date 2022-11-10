import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:sandhasen_connect/extensions/date_extension.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/fragments/home/fragment_interface.dart';
import 'package:sandhasen_connect/view/widgets/eventlist.dart';
import 'package:sandhasen_connect/view/widgets/message.dart';
import 'package:sandhasen_connect/viewmodel/events_viewmodel.dart';

import '../../../resources/themes.dart';

class EventsFragment extends StatefulWidget implements Fragment {
  EventsFragment({Key? key}) : super(key: key);
  _EventsFragmentState? state;

  @override
  State<StatefulWidget> createState() => state = _EventsFragmentState();

  @override
  Future<void> refresh() async {
    state?.refresh();
  }
}

class _EventsFragmentState extends State<EventsFragment> {
  List<List<Event>> events = List.empty();
  EventViewModel eventViewModel = EventViewModel();
  String lastUpdated = "";

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh() async {
    eventViewModel.getEvents().then((value) {
      setState(() {
        events = value;
        lastUpdated = eventViewModel.lastUpdate.toGermanDateFormatWithTime;
        if (eventViewModel.isFromCache) {
          Message.show(context, Strings.errorRequest);
        } else {
          Message.show(context, Strings.successRefresh,
              bgColor: Themes.eventConfirmedColor);
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
    return Stack(children: [
      Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("${Strings.state} $lastUpdated",
                style: Theme.of(context).textTheme.caption),
          )),
      Eventlist(events: events, onRefresh: refresh)
    ]);
  }
}
