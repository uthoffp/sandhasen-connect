import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/viewmodel/home_viewmodel.dart';

class ImpressumFragment extends StatefulWidget {
  const ImpressumFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImpressumFragmentState();
}

class _ImpressumFragmentState extends State<ImpressumFragment> {
  Widget _content = Container();

  @override
  void initState() {
    super.initState();
    _content = HomeViewModel.getImpressum(_content);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_content],
    );
  }
}
