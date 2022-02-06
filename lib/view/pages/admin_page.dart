import 'package:flutter/material.dart';
import 'package:sandhasen_connect/resources/strings.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
    return Container(
      padding: EdgeInsets.all(16),
      child: Stack(
        children: [
          const Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  onPressed: null, child: Icon(Icons.add))),
          ListView(),
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    minLines: 8,
                    controller: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: Strings.menuNews,
                      labelText: Strings.menuNews,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.save, size: 18),
                        label: const Text("Speichern"),
                      ))
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    minLines: 8,
                    controller: null,
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
                        onPressed: () {},
                        icon: const Icon(Icons.save, size: 18),
                        label: const Text("Speichern"),
                      ))
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    minLines: 8,
                    controller: null,
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
                        onPressed: () {},
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
