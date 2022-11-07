import 'package:flutter/material.dart';
import 'package:my_new_app/pages/home_page.dart';
import 'package:my_new_app/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_new_app/pages/register.dart';
import 'package:my_new_app/utils/routes.dart';
import 'package:my_new_app/widgets/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.light,
      theme: ThemeData(fontFamily: "Times New Roman"),
      // darkTheme: ThemeData(brightness: Brightness.dark, fontFamily: "Times New Roman"),

      initialRoute: "/",
      routes: {
        "/": (context) => const LoginPage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.homeRoute: (context) => const HomePage(),
      },
    );
  }
}
