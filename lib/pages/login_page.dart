import 'package:flutter/material.dart';
import 'package:my_new_app/database/db_conn.dart';
import 'package:my_new_app/database/my_pgsql_connection.dart';
import 'package:my_new_app/utils/route-animations.dart';
import 'package:my_new_app/utils/routes.dart';
import 'dart:developer';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final imgUrl =
      "https://i1.rgstatic.net/ii/profile.image/1039397055123456-1624822977566_Q128/Debojyoti-Sarkar-5.jpg";

  bool changeButton = false;
  bool showAnim = false;

  String username = "", password = "";
  final _formKey = GlobalKey<FormState>();

  moveToHome() async {
    setState(() {
      changeButton = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    // ignore: use_build_context_synchronously
    await Navigator.of(context).push(RouteAnimations().createHomeRoute());
    setState(() {
      changeButton = false;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Material(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned.fill(

              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // ignore: prefer_const_constructors
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 30),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Row(

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                                Text(
                                  "  Welcome, user!",
                                  style: TextStyle(
                                      fontSize: 24, fontFamily: 'Righteous'),
                                ),
                                // Container(
                                //   width: 20,
                                //   child: Image.asset(
                                //     "images/wave.gif",
                                //     height: 20.0,
                                //     width:20.0,
                                //   ),
                                // )
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              // ignore: prefer_const_constructors
                              decoration: InputDecoration(
                                hintText: "Enter your 6s User ID",
                                labelText: "Username",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Username cannot be blank";
                                } else {
                                  setState(() {
                                    username = value;
                                  });
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Enter your secret code",
                                labelText: "Password",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password cannot be blank";
                                } else if (value.length < 6) {
                                  return "Password must be atleast 6 digits in length";
                                } else {
                                  setState(() {
                                    password = value;
                                  });
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 40),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () => {doLogin()},
                                child: AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  width: changeButton ? 45 : 120,
                                  height: 45,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(
                                          changeButton ? 50 : 10)),
                                  child: changeButton
                                      ? const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "Let me in",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pushAndRemoveUntil(
                                context,
                                RouteAnimations().createRegisterRoute(),
                                (r) => false,
                              ),
                              child: const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Not registered yet?",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: showAnim
                  ? SpinKitWanderingCubes(
                color: Colors.blueAccent,
                size: 60,
              )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  doLogin() async {
    if (_formKey.currentState!.validate()) {
      showAnim = true;
      Map resp = await ApiConnections().login(username, password);
      if (resp['status'] == "1") {
        setState(() {
          showAnim = false;
        });
        moveToHome();
      } else {
        setState(() {
          showAnim = false;
        });        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Oops!"),
                content: Text(resp['message']),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("I get it"))
                ],
              );
            });
      }
    }
  }
}
