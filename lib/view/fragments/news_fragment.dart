import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsFragment extends StatefulWidget {
  const NewsFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsFragmentState();
}

class _NewsFragmentState extends State<NewsFragment> {
  Widget _content = Container();

  @override
  void initState() {
    _content = readNewsData();
  }

  FutureBuilder<DocumentSnapshot> readNewsData() {
    CollectionReference info = FirebaseFirestore.instance.collection('info');
    return FutureBuilder<DocumentSnapshot>(
      future: info.doc('kOGUzGOw3RuRu9MqXgHq').get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("has Error");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text(data['news']);
        }
        return Visibility(child: LinearProgressIndicator(), visible: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_content],
      ),
    );
  }
}
