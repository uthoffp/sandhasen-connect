import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/fragments/events_fragment.dart';
import 'package:sandhasen_connect/view/fragments/help_fragment.dart';
import 'package:sandhasen_connect/view/fragments/impressum_fragment.dart';
import 'package:sandhasen_connect/view/fragments/news_fragment.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _selectedFragment = Strings.menuNews;
  Widget _contentWidget = Container();

  _MainPageState();

  // select fragment based on selectedFragment parameter. This gets called when one menue element gets clicked
  void selectDestination(String selectedFragment) {
    setState(() {
      _selectedFragment = selectedFragment;
      switch (selectedFragment) {
        case Strings.menuNews:
          _contentWidget = NewsFragment();
          break;
        case Strings.menuEvents:
          _contentWidget = EventsFragment();
          break;
        case Strings.menuAdmin:
          //_contentWidget = AbRequestFragment();
          break;
        case Strings.menuHelp:
          _contentWidget = HelpFragment();
          break;
        case Strings.menuImpressum:
          _contentWidget = ImpressumFragment();
          break;
        case Strings.menuAbout:
          //_contentWidget = PwChangeFragment();
          break;
      }
      Navigator.of(context).pop();
    });
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      _contentWidget = const NewsFragment();
    });
  }

  //Main Page containing app bar, content and menu drawer to select main content fragments
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedFragment),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Strings.appName,
                    style: textTheme.headline5,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(alignment: Alignment.centerLeft, child: Text(Strings.appName, style: textTheme.headline6)),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            navDrawerItem(context, Icons.message, Strings.menuNews),
            navDrawerItem(context, Icons.calendar_today, Strings.menuEvents),
            navDrawerItem(context, Icons.vpn_key, Strings.menuAdmin),
            const Divider(height: 1, thickness: 1),
            navDrawerItem(context, Icons.help, Strings.menuHelp),
            navDrawerItem(context, Icons.info, Strings.menuImpressum),
          ],
        ),
      ),
      body: _contentWidget,
    );
  }

  // return menu drawer element
  Widget navDrawerItem(BuildContext context, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        leading: Icon(icon),
        dense: true,
        title: Text(text),
        selected: _selectedFragment == text,
        selectedTileColor: Theme.of(context).colorScheme.onPrimary,
        onTap: () => selectDestination(text),
      ),
    );
  }
}