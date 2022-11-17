
import 'dart:convert';

import 'package:my_new_app/utils/urls.dart';
import 'package:http/http.dart' as http;

class ApiConnections{
  Future<Map> register(String user_id,name,email,phone, pass,role) async {
    Map<String,String> msg;
    msg = {
      'status':'0',
      'message':'There appears to be a poor internet connection!'
    };
    Map data = {
      'user_id': user_id,
      'name': name,
      'email': email,
      'phone': phone,
      'password':pass,
      'role':role
    };
    print(data);
    String body = json.encode(data);
    var url = Urls.BASE_URL+Urls.REG_URL;
    try
    {
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      Map msgFromApi= jsonDecode(response.body);

      if (response.statusCode == 200) {
        return msgFromApi;
      } else {
        print('error');
        return msg;
      }
    }
    catch(e)
    {
      return msg;
    }
  }
  Future<bool> isUserPresent(String user_id) async {

    Map map = {
      'user_id':user_id
    };
    String data = jsonEncode(map);
    String isUserPresent_url = Urls.BASE_URL+Urls.USER_EXISTS_URL;
    try{
      var response = await http.post(
        Uri.parse(isUserPresent_url),
        body: data,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },

      );
      Map m=jsonDecode(response.body);
      print("status==="+m['status']);
      if(m["status"]=="1"){
        print("TRUE");
        return true;
      }else{
        print("FALSE");

        return false;
      }
    }catch(e){
        return false;
    }
  }

  Future<Map> login(String user_id,pass) async {
    Map<String,String> msg;
    msg = {
      'status':'0',
      'message':'There appears to be a poor internet connection!'
    };
    Map data = {
      'user_id': user_id,
      'password':pass,
    };
    String body = json.encode(data);

    var loginUrl = Urls.BASE_URL+Urls.LOGIN_URL;
    try
    {
      print("trying...");
      var response = await http.post(
        Uri.parse(loginUrl),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      Map msgFromApi= jsonDecode(response.body);
      print("resp body: "+response.body);
      if (response.statusCode == 200) {
        return msgFromApi;
      } else {
        print('error');
        return msg;
      }
    }
    catch(e)
    {
      print("caught"+e.toString());
      return msg;
    }
  }

}