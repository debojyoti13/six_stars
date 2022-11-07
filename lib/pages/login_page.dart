import 'package:flutter/material.dart';
import 'package:my_new_app/database/my_pgsql_connection.dart';
import 'package:my_new_app/utils/route-animations.dart';
import 'package:my_new_app/utils/routes.dart';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool changeButton = false;

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
        child: InkWell(
          onTap: () {},
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // ignore: prefer_const_constructors

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.person,
                              size: 50,
                            ),
                            Text(
                              "  Welcome, user!",
                              style: TextStyle(
                                  fontSize: 26, fontFamily: 'Righteous'),
                            )
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
                            onTap: () => doLogin(),
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
      ),
    );
  }

  doLogin() async {
    if (_formKey.currentState!.validate()) {
      if (await MyDatabase().login(username, password)) {
        moveToHome();
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Oops!"),
                content: Text("Could not log you in."),
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
