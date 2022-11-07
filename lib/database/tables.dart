// ignore_for_file: avoid_print

import 'my_pgsql_connection.dart';

class CreateTables {
  Future<void> create_users_table() async {
    var conn = MyDatabase().getConnection();
    try {
      await conn.open();
      var result = conn.query(
          "CREATE TABLE IF NOT EXISTS users (id int NOT NULL PRIMARY KEY, user_id varchar(255) NOT NULL UNIQUE ,username varchar(255) NOT NULL,phone varchar(10) NULL,email varchar(255) NULL,password varchar(255) NOT NULL,status int NOT NULL DEFAULT 1);");
    } catch (e) {
      print("error=> $e");
    }
  }
}
