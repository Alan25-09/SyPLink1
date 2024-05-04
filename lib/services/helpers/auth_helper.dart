import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhubv2_0/models/request/auth/login_model.dart';
import 'package:jobhubv2_0/models/request/auth/profile_update_model.dart';
import 'package:jobhubv2_0/models/request/auth/signup_model.dart';
import 'package:jobhubv2_0/models/response/auth/login_res_model.dart';
import 'package:jobhubv2_0/models/response/auth/profile_model.dart';
import 'package:jobhubv2_0/services/config.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> signup(String model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      var url = Uri.https(Config.apiUrl, Config.signupUrl);

      var response =
          await client.post(url, headers: requestHeaders, body: model);

      if (response.statusCode == 201) {
        print('Registro exitoso');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> login(model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      var url = Uri.https(Config.apiUrl, Config.loginUrl);

      var response =
          await client.post(url, headers: requestHeaders, body: model);

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        var user = loginResponseModelFromJson(response.body);

        await prefs.setString('token', user.userToken);
        await prefs.setString('userId', user.id);
        await prefs.setString('profile', user.profile);
        await prefs.setString('username', user.username);
        await prefs.setBool('loggedIn', true);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
