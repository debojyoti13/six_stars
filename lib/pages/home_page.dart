

import 'package:flutter/material.dart';
import 'package:my_new_app/database/tables.dart';
import 'package:my_new_app/models/user_details.dart';
import 'package:my_new_app/pages/login_page.dart';
import 'package:my_new_app/utils/shared_pref.dart';
import 'package:my_new_app/widgets/drawer.dart';
import 'package:postgres/postgres.dart';

import '../database/my_pgsql_connection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String name='',email='',phone='',userId='',token='',role='',active_status='';

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    UserDetails ud = UserDetails();
    SharedPrefManager sp = SharedPrefManager();
    ud = await sp.getUser();
    setState(() {
      userId=ud.userId;
      name = ud.username;
      email = ud.email;
      phone = ud.phone;
      role=ud.role;
      active_status=ud.active_status;
      token=ud.token;
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
                  if(await sm.logout()){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  }

                  break;
                case 'filter2':
                  print('filter 2 clicked');
                  break;

                default:
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'filter1',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.power_settings_new,color: Colors.red,),
                    Text('Logout'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'filter2',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.exit_to_app,color: Colors.black,),
                    Text('Exit App'),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
      body: Center(
        // ignore: prefer_interpolation_to_compose_strings
        child: Text("okay::"+userId+name+email+phone+role+active_status),
      ),
      drawer: const MyDrawer(),
    );
  }
}
