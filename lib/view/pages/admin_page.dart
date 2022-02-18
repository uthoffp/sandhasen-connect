import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/model/address.dart';
import 'package:sandhasen_connect/data/model/event.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/pages/newevent_page.dart';
import 'package:sandhasen_connect/viewmodel/info_viewmodel.dart';

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

  @override
  void initState() {
    super.initState();
    setState(() {
      InfoViewModel.getInfoString().then((value) => {
            newsController.text = value!["news"],
            helpController.text = value["help"],
            impressumController.text = value["impressum"],
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
            tabs: [Tab(text: 'Termine'), Tab(text: 'Info')],
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
    Event _event = Event(
        "Testname",
        "Test Org",
        Address("Pulheim", "50259", "Plebanusstraße 25", "Mein Eigener Platz"),
        false,
        true,
        true,
        false,
        DateTime.now(),
        DateTime.now(),
        "Test Comment");

    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          ListView(),
          Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewEventPage()));
                  },
                  child: const Icon(Icons.add))),
        ],
      ),
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
                      const Text("Änderungsbenachrichtigung senden"),
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
                          InfoViewModel.saveNews(
                              newsController.text, _sendNewsNotification);
                        },
                        icon: const Icon(Icons.save, size: 18),
                        label: const Text("Speichern"),
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
                          InfoViewModel.saveHelp(helpController.text);
                        },
                        icon: const Icon(Icons.save, size: 18),
                        label: const Text("Speichern"),
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
                          InfoViewModel.saveImpressum(impressumController.text);
                        },
                        icon: const Icon(Icons.save, size: 18),
                        label: const Text("Speichern"),
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
