import 'package:my_new_app/models/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  late String ID = "id",
      USERNAME = "username",
      PHONE = "phone",
      EMAIL = "email",
      TOKEN = "token",
      ROLE="role",
      ACTIVE_STATUS="active_status"
  ;

  Future<void> storeUser(
      UserDetails user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Saving user");
    prefs.setString(ID, user.userId);
    prefs.setString(USERNAME, user.username);
    prefs.setString(PHONE, user.phone);
    prefs.setString(EMAIL, user.email);
    prefs.setString(ROLE, user.role);
    prefs.setString(ACTIVE_STATUS, user.active_status);

  }

  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Saving login token");
    prefs.setString(TOKEN, token);
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(TOKEN) == null || prefs.getString(TOKEN) == '') {
      return false;
    } else {
      return true;
    }
  }

  Future<UserDetails> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserDetails user = UserDetails();
    user.userId = prefs.getString(ID)!;
    user.username = prefs.getString(USERNAME)!;
    user.phone = prefs.getString(PHONE)!;
    user.email = prefs.getString(EMAIL)!;
    user.token = prefs.getString(TOKEN)!;
    user.role = prefs.getString(ROLE)!;
    user.active_status = prefs.getString(ACTIVE_STATUS)!;
    return user;
  }

  Future<bool> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("Logging out");
      prefs.remove(ID);
      prefs.remove(USERNAME);
      prefs.remove(PHONE);
      prefs.remove(EMAIL);
      prefs.remove(ROLE);
      prefs.remove(ACTIVE_STATUS);
      prefs.remove(TOKEN);
      return true;
    } on Exception catch (e) {
      return false;
    }

  }
}
