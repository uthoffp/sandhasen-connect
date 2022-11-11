import 'package:flutter/material.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/fragments/admin/admin_fragment.dart';
import 'package:sandhasen_connect/view/fragments/home/events_fragment.dart';
import 'package:sandhasen_connect/view/fragments/home/help_fragment.dart';
import 'package:sandhasen_connect/view/fragments/home/impressum_fragment.dart';
import 'package:sandhasen_connect/view/fragments/home/news_fragment.dart';

import '../../fragments/home/fragment_interface.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Fragment _contentWidget = NewsFragment();
  String _title = Strings.menuNews;
  int _selectedFragmentIndex = 0;

  _MainPageState();

  // select fragment based on selectedFragment parameter. This gets called when one menu element gets clicked
  void selectDestination(int selectedFragment) {
    _selectedFragmentIndex = selectedFragment;
    setState(() {
      switch (selectedFragment) {
        case 0:
          _title = Strings.menuNews;
          _contentWidget = NewsFragment();
          break;
        case 1:
          _title = Strings.menuEvents;
          _contentWidget = EventsFragment();
          break;
        case 2:
          _title = Strings.menuAdmin;
          _contentWidget = const AdminFragment();
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _contentWidget = NewsFragment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          _title == Strings.menuEvents
              ? const Switch(value: true, onChanged: null)
              : Container(),
          _title != Strings.menuAdmin
              ? IconButton(
                  onPressed: () => _contentWidget.refresh(),
                  icon: const Icon(Icons.refresh))
              : Container(),
          PopupMenuButton(
            onSelected: (value) => {
              if (value == 0)
                {
                  showAboutDialog(
                      context: context, children: [const ImpressumFragment()])
                }
              else
                {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(Strings.menuHelp),
                          content: const HelpFragment(),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(Strings.cancel))
                          ],
                        );
                      })
                }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(child: Text(Strings.menuImpressum), value: 0),
              const PopupMenuItem(child: Text(Strings.menuHelp), value: 1)
            ],
          )
        ],
      ),
      body: _contentWidget,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedFragmentIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) => selectDestination(value),
        items: const [
          BottomNavigationBarItem(
            label: Strings.menuNews,
            icon: Icon(Icons.message_rounded),
          ),
          BottomNavigationBarItem(
            label: Strings.menuEvents,
            icon: Icon(Icons.calendar_today_rounded),
          ),
          BottomNavigationBarItem(
            label: Strings.menuAdmin,
            icon: Icon(Icons.lock),
          ),
        ],
      ),
    );
  }
}
