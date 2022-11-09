import 'package:my_new_app/models/user_details.dart';
import 'package:postgres/postgres.dart';
// import 'package:postgresql2/constants.dart';
import 'package:postgresql2/pool.dart';
import 'package:postgresql2/postgresql.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDatabase {
  PostgreSQLConnection getConnection() {
    var databaseConnection = PostgreSQLConnection(
        "10.177.15.121", 5432, "six_stars",
        queryTimeoutInSeconds: 3600,
        timeoutInSeconds: 3600,
        username: "postgres",
        password: "postgres");
    return databaseConnection;
  }

  Future<bool> regsiter(UserDetails userDetails) async {
    print("connecting to db0...");
    var conn = MyDatabase().getConnection();
    try {
      await conn.open();
      var id =
          await conn.query("SELECT id FROM users ORDER BY id DESC LIMIT 1;");
      int new_id;
      if (id.affectedRowCount == 0) {
        new_id = 1;
      } else {
        new_id = id.first.first + 1;
      }
      await conn.query(
          "INSERT INTO users(id, user_id, username, phone, email, password, status) VALUES($new_id, '${userDetails.userId}', '${userDetails.username}', '${userDetails.phone}', '${userDetails.email}', '${userDetails.password}', 1);");
      return true;
    } catch (e) {
      print("error=> $e");
      return false;
    }
  }

  Future<bool> isPresent(
      String text, String tableName, String columnName) async {
    print("called $text");
    var conn = MyDatabase().getConnection();

    try {
      await conn.open();
      var texts = await conn.query(
          "SELECT $columnName FROM $tableName WHERE $columnName='$text';");
      print("xxxx $texts ");
      if (texts.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    print("connecting to db0... $username");
    var conn = MyDatabase().getConnection();
    try {
      await conn.open();
      var count = await conn
          .query("SELECT password FROM users WHERE user_id='$username';");
      print("count  $count");
      if (count.affectedRowCount == 0) {
        return false;
      } else {
        if (count.first.first != password) {
          return false;
        } else {
          List<List<dynamic>> userDetails = await conn
              .query("SELECT * FROM users WHERE user_id='$username';");

          UserDetails user = UserDetails();
          for (final row in userDetails) {
            user.userId = row[1];
            user.username = row[2];
            user.phone = row[3];
            user.email = row[4];
            user.password = row[5];
            user.status = row[6];

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('id', user.userId);
            prefs.setString('username', user.username);
            prefs.setString('phone', user.phone);
            prefs.setString('email', user.email);
          }
          if (user.status == 1) {
            print(user.password);
            return true;
          } else {
            return false;
          }
        }
      }
    } catch (e) {
      print("error=> $e");
      return false;
    }
  }
}
