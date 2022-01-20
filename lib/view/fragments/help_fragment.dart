import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/widgets/message.dart';

class HelpFragment extends StatefulWidget {
  const HelpFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HelpFragmentState();
}

class _HelpFragmentState extends State<HelpFragment> {
  Widget _content = Container();

  @override
  void initState() {
    super.initState();
    _content = readHelpData();
  }

  FutureBuilder<DocumentSnapshot> readHelpData() {
    CollectionReference info = FirebaseFirestore.instance.collection('info');
    return FutureBuilder<DocumentSnapshot>(
      future: info.doc('kOGUzGOw3RuRu9MqXgHq').get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError || (snapshot.hasData && !snapshot.data!.exists)) {
          Message.show(context, Strings.errorRequest);
          return _content;
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return SingleChildScrollView(
            child: Padding(
              child: Html(data: data['help']),
              padding: EdgeInsets.all(8),
            ),
          );
        }
        return const LinearProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_content],
    );
  }
}
