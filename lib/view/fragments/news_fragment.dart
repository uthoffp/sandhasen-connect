import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/viewmodel/info_viewmodel.dart';

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
    _content = InfoViewModel.getNews(_content);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_content],
    );
  }
}
