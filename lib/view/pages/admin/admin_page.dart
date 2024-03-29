import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/pages/admin/newevent_page.dart';
import 'package:sandhasen_connect/view/widgets/eventlist.dart';
import 'package:sandhasen_connect/view/widgets/message.dart';
import 'package:sandhasen_connect/viewmodel/home_viewmodel.dart';

import '../../../viewmodel/events_viewmodel.dart';
import '../../widgets/eventlist_item.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool _sendNewsNotification = false;
  TextEditingController newsController = TextEditingController();
  TextEditingController helpController = TextEditingController();
  TextEditingController impressumController = TextEditingController();
  List<List<Event>> events = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _refresh();
      HomeViewModel.getInfoString().then((value) => {
            newsController.text = value![Strings.news],
            helpController.text = value[Strings.help],
            impressumController.text = value[Strings.impressum],
          });
    });
  }

  Future<void> _refresh() async {
    EventViewModel().getEvents().then((value) {
      setState(() {
        events = value;
      });
    }).onError((error, stackTrace) {
      setState(() {
        Message.show(context, Strings.errorRequest);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.menuAdmin),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [Tab(text: Strings.menuEvents), Tab(text: Strings.menuInfo)],
          ),
        ),
        body: TabBarView(
          children: [
            eventsTab(),
            infoTab(),
          ],
        ),
      ),
    );
  }

  Widget eventsTab() {
    return Stack(
      children: [
        Eventlist(events: events, onRefresh: _refresh, asAdmin: true,),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewEventPage()));
                  },
                  child: const Icon(Icons.add))),
        ),
      ],
    );
  }

  Widget infoTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    minLines: 8,
                    controller: newsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: Strings.menuNews,
                      labelText: Strings.menuNews,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(Strings.sendNotification),
                      Switch(
                          value: _sendNewsNotification,
                          onChanged: (bool value) {
                            setState(() {
                              _sendNewsNotification = value;
                            });
                          }),
                    ],
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          HomeViewModel.saveNews(
                              newsController.text, _sendNewsNotification);
                        },
                        icon: const Icon(Icons.save, size: 18),
                        label: const Text(Strings.save),
                      ))
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    minLines: 8,
                    controller: helpController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: Strings.menuHelp,
                      labelText: Strings.menuHelp,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          HomeViewModel.saveHelp(helpController.text);
                        },
                        icon: const Icon(Icons.save, size: 18),
                        label: const Text(Strings.save),
                      ))
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    minLines: 8,
                    controller: impressumController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: Strings.menuImpressum,
                      labelText: Strings.menuImpressum,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          HomeViewModel.saveImpressum(impressumController.text);
                        },
                        icon: const Icon(Icons.save, size: 18),
                        label: const Text(Strings.save),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
