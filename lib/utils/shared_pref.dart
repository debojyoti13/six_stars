import 'package:my_new_app/models/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  late String ID = "id",
      USERNAME = "username",
      PHONE = "phone",
      EMAIL = "email";

  Future<void> setPref(
      String id, String username, String phone, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SAving prefff");
    prefs.setString(ID, id);
    prefs.setString(USERNAME, username);
    prefs.setString(PHONE, phone);
    prefs.setString(EMAIL, email);
  }

  Future<UserDetails> getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserDetails user = UserDetails();
    user.userId = prefs.getString(ID)!;
    user.username = prefs.getString(USERNAME)!;
    user.phone = prefs.getString(PHONE)!;
    user.email = prefs.getString(EMAIL)!;
    return user;
  }
}
