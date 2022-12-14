import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_new_app/models/user_details.dart';
import 'package:my_new_app/utils/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var name = "";
  var email = "";
  var phone = "56";
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
      name = ud.username;
      email = ud.email;
      phone = ud.phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    const imgUrl =
        "https://i1.rgstatic.net/ii/profile.image/1039397055123456-1624822977566_Q128/Debojyoti-Sarkar-5.jpg";

    return Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                border: const Border(bottom: BorderSide(color: Colors.white)),
              ),
              child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(imgUrl),
                      radius: 34,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      phone,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ]),
            ),
            const ListTile(
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                "Who am I ?",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.white,
              ),
              title: Text(
                "Room",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(
                CupertinoIcons.photo,
                color: Colors.white,
              ),
              title: Text(
                "Gallery",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            const ListTile(
              leading: Icon(
                Icons.developer_mode,
                color: Colors.white,
              ),
              title: Text(
                "Developers",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.description_outlined,
                color: Colors.white,
              ),
              title: Text(
                "About Us",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.connect_without_contact,
                color: Colors.white,
              ),
              title: Text(
                "Social Media Links",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(
                    MdiIcons.facebook,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    MdiIcons.instagram,
                    color: Colors.purple,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    MdiIcons.linkedin,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    MdiIcons.twitter,
                    color: Color.fromARGB(255, 144, 192, 231),
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      );

  }
}
