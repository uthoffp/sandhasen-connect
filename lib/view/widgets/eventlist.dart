import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:sandhasen_connect/extensions/date_extension.dart';

import 'eventlist_item.dart';

//ignore: must_be_immutable
class Eventlist extends StatelessWidget {
  Eventlist(
      {required this.events,
      required this.onRefresh,
      Key? key,
      this.asAdmin = false})
      : super(key: key);

  final List<List<Event>> events;
  final Future<void> Function() onRefresh;
  bool asAdmin = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.separated(
          itemCount: events.length,
          separatorBuilder: (_, i) => const Divider(),
          itemBuilder: (_, i) => Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(events[i].first.dateStart.toMonthYearFormat,
                        style: Theme.of(context).textTheme.bodyLarge),
                  )),
              const Divider(),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: events[i].length,
                itemBuilder: (_, int j) =>
                    EventListItem(events[i][j], asAdmin: asAdmin),
                separatorBuilder: (_, j) => const Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
