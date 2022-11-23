import 'package:flutter/material.dart';
import 'package:my_new_app/database/tables.dart';
import 'package:my_new_app/fillers/chat.dart';
import 'package:my_new_app/fillers/feed.dart';
import 'package:my_new_app/models/user_details.dart';
import 'package:my_new_app/pages/login_page.dart';
import 'package:my_new_app/utils/shared_pref.dart';
import 'package:my_new_app/widgets/drawer.dart';
import 'package:postgres/postgres.dart';

import '../database/my_pgsql_connection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int selectedIndex = 0;
  bool _colorful = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);

    initial();
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  String name = '',
      email = '',
      phone = '',
      userId = '',
      token = '',
      role = '',
      active_status = '';


  void initial() async {
    UserDetails ud = UserDetails();
    SharedPrefManager sp = SharedPrefManager();
    ud = await sp.getUser();
    setState(() {
      userId = ud.userId;
      name = ud.username;
      email = ud.email;
      phone = ud.phone;
      role = ud.role;
      active_status = ud.active_status;
      token = ud.token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "The Six Stars",
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [

          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String result) async {
              switch (result) {
                case 'filter1':
                  SharedPrefManager sm = SharedPrefManager();
                  if (await sm.logout()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }

                  break;
                case 'filter2':
                  print('filter 2 clicked');
                  break;

                default:
              }
            },
            itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'filter1',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.power_settings_new, color: Colors.red,),
                    Text('Logout'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'filter2',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.black,),
                    Text('Exit App'),
                  ],
                ),
              ),

            ],
          ),
        ],

      ),
      body: Column(
        children: <Widget>[
          // SafeArea(
          //     child: SwitchListTile(
          //       title: const Text('Colorful Nav bar'),
          //       value: _colorful,
          //       onChanged: (bool value) {
          //         setState(() {
          //           _colorful = !_colorful;
          //         });
          //       },
          //     )),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _listOfWidget,
            ),
          ),
        ],
      ),

      bottomNavigationBar: _colorful
          ? SlidingClippedNavBar.colorful(
        backgroundColor: Colors.white,
        onButtonPressed: onButtonPressed,
        iconSize: 30,
        // activeColor: const Color(0xFF01579B),
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            icon: Icons.event,
            title: 'Events',
            activeColor: Colors.blue,
            inactiveColor: Colors.orange,
          ),
          BarItem(
            icon: Icons.search_rounded,
            title: 'Search',
            activeColor: Colors.yellow,
            inactiveColor: Colors.green,
          ),
          BarItem(
            icon: Icons.bolt_rounded,
            title: 'Energy',
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),
          BarItem(
            icon: Icons.tune_rounded,
            title: 'Settings',
            activeColor: Colors.cyan,
            inactiveColor: Colors.purple,
          ),
        ],
      )
          : Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: SlidingClippedNavBar(
          backgroundColor: Colors.white,
          onButtonPressed: onButtonPressed,
          iconSize: 30,
          // activeColor: const Color(0xFF01579B),
          activeColor: Colors.black,
          selectedIndex: selectedIndex,
          barItems: [
            BarItem(
              icon: Icons.feed,
              title: 'Feed',
            ),
            BarItem(
              icon: Icons.chat,
              title: 'Chat',
            ),
            BarItem(
              icon: Icons.discord,
              title: 'Room',
            ),
            BarItem(
              icon: Icons.tune_rounded,
              title: 'Settings',
            ),
          ],

        ),
      ),
      drawer: const MyDrawer(),);
  }
}


List<Widget> _listOfWidget = <Widget>[
  Feed(),
  Container(
    alignment: Alignment.center,
    child: const Icon(
      Icons.feed,
      size: 56,
      color: Colors.brown,
    ),
  ),
  Container(
    alignment: Alignment.center,
    child: const Icon(
      Icons.feed,
      size: 56,
      color: Colors.brown,
    ),
  ),
  Container(
    alignment: Alignment.center,
    child: const Icon(
      Icons.tune_rounded,
      size: 56,
      color: Colors.brown,
    ),
  ),
];