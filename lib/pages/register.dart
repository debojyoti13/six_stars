// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_new_app/database/db_conn.dart';
import 'package:my_new_app/database/my_pgsql_connection.dart';
import 'package:my_new_app/pages/login_page.dart';
import 'package:my_new_app/utils/route-animations.dart';
import 'package:my_new_app/utils/routes.dart';
import 'dart:developer';
import 'package:my_new_app/models/user_details.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String user_id_msg = "";
  IconData myIconData = Icons.person_add;
  Color iconColor = Colors.black;
  Color textColor = Colors.black;
  bool iconVisibility = false;
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  // ignore: unnecessary_new, non_constant_identifier_names
  UserDetails user_details = new UserDetails();

  // Route _createRoute() {
  //   return PageRouteBuilder(
  //       pageBuilder: (context, animation, secondaryAnimation) =>
  //           const LoginPage(),
  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //         const begin = Offset(0.0, 1.0);
  //         const end = Offset.zero;
  //         const curve = Curves.ease;

  //         final tween = Tween(begin: begin, end: end);
  //         final curvedAnimation = CurvedAnimation(
  //           parent: animation,
  //           curve: curve,
  //         );

  //         return SlideTransition(
  //           position: tween.animate(curvedAnimation),
  //           child: child,
  //         );
  //       });
  // }

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

  register() async {
    if (_formKey.currentState!.validate()) {
      print("calling register()");
      Map<dynamic, dynamic> resp = await ApiConnections().register(user_details.userId, user_details.username, user_details.email, user_details.phone, user_details.password,user_details.role="1");
      print("received status"+resp['status'].toString()+resp['message'].toString());
      if (resp["status"]=='1') {
        print("success");
        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registration Successful!'),
              content: const Text(
                  'Dear user, kindly login with the username and password'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('I get it'),
                ),
                TextButton(
                  // onPressed: () => Navigator.pushNamed(context, MyRoutes.loginRoute),
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    RouteAnimations().createLoginRoute(),
                    (r) => false,
                  ),
                  child: const Text('Login'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Oops!"),
                content: Text("Sorry! Something went wrong."),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.pop(context, "Try Again"),
                      child: const Text("ok"))
                ],
              );
            });
      }
      // setState(() {
      //   changeButton = true;
      // });
      // await Future.delayed(const Duration(seconds: 1));
      // // ignore: use_build_context_synchronously
      // await Navigator.pushNamed(context, MyRoutes.homeRoute);
      // setState(() {
      //   changeButton = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Material(
        color: Colors.white,
        child: InkWell(
          // onTap: () => Navigator.pushAndRemoveUntil(
          //   context,
          //   RouteAnimations().createLoginRoute(),
          //   (r) => false,
          // ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // ignore: prefer_const_constructors
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
                    child: const Text(
                      "Registration Form",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // ignore: prefer_const_constructors
    
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextFormField(
                          // ignore: prefer_const_constructors
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: "",
                            labelText: "Enter your name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name cannot be blank";
                            } else {
                              user_details.username = value;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            hintText: "",
                            labelText: "Choose a ID for yourself",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "User ID cannot be blank";
                            } else {
                              user_details.userId = value;
                            }
                            return null;
                          },
                          onChanged: (value) async {
                            // ignore: unrelated_type_equality_checks
                            if (value == "") {
                              print("xaxa");
                              setState(() {
                                iconVisibility = false;
                                user_id_msg = "";
                              });
                            } else {
                              if (await ApiConnections().isUserPresent(value)) {
                                setState(() {
                                  user_id_msg = "Username Exists!";
                                  textColor = Colors.red;
                                  myIconData =
                                      CupertinoIcons.exclamationmark_octagon_fill;
                                  iconColor = Colors.red;
                                  iconVisibility = true;
                                });
                              } else {
                                setState(() {
                                  user_id_msg = "Username Available";
                                  textColor = Colors.green;
                                  myIconData = CupertinoIcons.checkmark_seal_fill;
                                  iconColor = Colors.green;
                                  iconVisibility = true;
                                });
                              }
                            }
                          },
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                user_id_msg,
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Visibility(
                                visible: iconVisibility,
                                child: Icon(
                                  myIconData,
                                  color: iconColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          // ignore: prefer_const_constructors
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
    
                          decoration: const InputDecoration(
                            hintText: "",
                            labelText: "Enter your phone number",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone number cannot be blank";
                            } else {
                              user_details.phone = value;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            hintText: "",
                            labelText: "Enter your email ID",
                          ),
                          validator: (value) {
                            user_details.email = value!;
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "",
                            labelText: "Create a password",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be blank";
                            } else if (value.length < 6) {
                              return "Password must be atleast 6 digits in length";
                            } else {
                              user_details.password = value;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "",
                            labelText: "Re-enter password",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be blank";
                            } else if (value.length < 6) {
                              return "Password must be atleast 6 digits in length";
                            } else {
                              if (user_details.password != value) {
                                return "Password do not match!";
                              } else {}
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => register(),
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: changeButton ? 45 : 120,
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(
                                      changeButton ? 50 : 10)),
                              child: changeButton
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Register",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0),
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () => Navigator.pushAndRemoveUntil(
                              context,
                              RouteAnimations().createLoginRoute(),
                              (r) => false,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "Already Registered?",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
