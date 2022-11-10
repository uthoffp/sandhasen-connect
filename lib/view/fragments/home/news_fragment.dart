import 'package:flutter/material.dart';
import 'package:sandhasen_connect/viewmodel/home_viewmodel.dart';

import 'fragment_interface.dart';

class NewsFragment extends StatefulWidget implements Fragment{
  NewsFragment({Key? key}) : super(key: key);
  _NewsFragmentState? state;

  @override
  State<StatefulWidget> createState() => state = _NewsFragmentState();

  @override
  Future<void> refresh() async {
    state?.refresh();
  }
}

class _NewsFragmentState extends State<NewsFragment>{
  Widget _content = Container();

  @override
  void initState() {
    super.initState();
    _content = HomeViewModel.getNews(_content);
  }

  Future<void> refresh() {
    setState(() {
      _content = HomeViewModel.getNews(_content);
    });
    return Future(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView(
        children: [
          _content
        ],
      ),
    );
  }
}
