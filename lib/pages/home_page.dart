// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:my_new_app/database/tables.dart';
import 'package:my_new_app/widgets/drawer.dart';
import 'package:postgres/postgres.dart';

import '../database/my_pgsql_connection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future operation() async {
    CreateTables().create_users_table();
    // String phone = "9864544409";
    // String email = "debojyoti.s@nic.in";
    // String username = "Debojyoti5";
    // int userId = 1;
    // String password = "12345";
    // int status = 1;
    // MyDatabase().regsiter(userId, username, phone, email, password, status);
  }

  @override
  Widget build(BuildContext context) {
    operation();

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
