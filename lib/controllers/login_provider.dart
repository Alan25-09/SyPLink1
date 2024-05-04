import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/request/auth/login_model.dart';
import 'package:jobhubv2_0/models/request/auth/profile_update_model.dart';
import 'package:jobhubv2_0/services/helpers/auth_helper.dart';
import 'package:jobhubv2_0/views/screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool? _entrypoint;

  bool get entrypoint => _entrypoint ?? false;

  set entrypoint(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _obscureText = newState;
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
}
