import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/viewmodel/home_viewmodel.dart';

class NewsFragment extends StatefulWidget {
  const NewsFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsFragmentState();
}

class _NewsFragmentState extends State<NewsFragment> {
  Widget _content = Container();

  @override
  void initState() {
    super.initState();
    _content = HomeViewModel.getNews(_content);
  }

  Future<void> _refresh() {
    setState(() {
      _content = HomeViewModel.getNews(_content);
    });
    return Future(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        children: [
          _content
        ],
      ),
    );
  }
}
