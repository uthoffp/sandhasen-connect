import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/resources/strings.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({Key? key}) : super(key: key);

  @override
  _NewEventPageState createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Neuer Termin")),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: "Name des Termins",
                  labelText: "Name",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: "Organisator",
                  labelText: "Organisator",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                child: Text("Addresse",
                    style: Theme.of(context).textTheme.headline6),
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: "Ort",
                  labelText: "Ort",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: "Straße, Nr.",
                  labelText: "Straße, Nr.",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: "Postleitzahl",
                          labelText: "Postleitzahl",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "Stadt",
                        labelText: "Stadt",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: "Google Maps URL",
                  labelText: "Google Maps URL",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                child: Text("Zeitpunkt",
                    style: Theme.of(context).textTheme.headline6),
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: "Datum",
                  labelText: "Datum",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: "Treffen",
                          labelText: "Treffen",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: "Start",
                          labelText: "Start",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                child:
                    Text("Infos", style: Theme.of(context).textTheme.headline6),
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Bestätigt")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text("Abgesagt")),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Anwesenheit")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text("Eigener Auftritt")),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save, size: 18),
                label: const Text("Speichern"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
