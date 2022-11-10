import 'package:flutter/cupertino.dart';

abstract class Fragment extends StatefulWidget {
  const Fragment({Key? key}) : super(key: key);

  Future<void> refresh();
}