import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/controllers/zoom_provider.dart';
import 'package:syplink/services/helpers/auth_helper.dart';
import 'package:syplink/views/screens/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;
  String userUid = '';

  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool? _entrypoint;

  bool get entrypoint => _entrypoint ?? false;

  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  bool _loader = false;

  bool get loader => _loader;

  set loader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  login(String model, ZoomNotifier zoomNotifier) {
    AuthHelper.login(model).then((response) {
      if (response == true) {
        loader = false;
        zoomNotifier.currentIndex = 0;
        Get.offAll(() => const Mainscreen());
      } else {
        loader = false;
        Get.snackbar(
            'Error al iniciar sesión', 'Revisa tus credenciales de acceso',
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  getPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    entrypoint = prefs.getBool('entrypoint') ?? false;
    loggedIn = prefs.getBool('loggedIn') ?? false;
    username = prefs.getString('username') ?? '';
    userUid = prefs.getString('uid') ?? '';
    profile = prefs.getString('profile') ?? '';
  }

  getUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userUid = prefs.getString('uid') ?? '';
    return userUid;
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.remove('token');
  }
}
