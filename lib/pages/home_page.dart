// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:my_new_app/database/tables.dart';
import 'package:my_new_app/widgets/drawer.dart';
import 'package:postgres/postgres.dart';

import '../database/my_pgsql_connection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});



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
      ),
      body: const Center(
        // ignore: prefer_interpolation_to_compose_strings
        child: Text("6 Boiz"),
      ),
      drawer: const MyDrawer(),
    );
  }
}
