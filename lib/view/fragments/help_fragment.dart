import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/widgets/message.dart';
import 'package:sandhasen_connect/viewmodel/info_viewmodel.dart';

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
    _content = InfoViewModel.getHelp(_content);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_content],
    );
  }
}
