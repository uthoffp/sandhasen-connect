import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/viewmodel/home_viewmodel.dart';

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
    _content = HomeViewModel.getHelp(_content);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_content],
    );
  }
}
