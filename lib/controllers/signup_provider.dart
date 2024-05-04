import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/models/request/auth/signup_model.dart';
import 'package:jobhubv2_0/services/helpers/auth_helper.dart';
import 'package:jobhubv2_0/views/screens/auth/login.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _loader = false;

  bool get loader => _loader;

  set loader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  final signupFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = signupFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  signUp(String model) {
    AuthHelper.signup(model).then((response) {
      if (response == true) {
        loader = false;
        Get.offAll(() => const LoginPage());
      } else {
        loader = false;
        Get.snackbar('Error al registrarse', 'Revisa la información ingresada',
            colorText: Color(kLight.value),
            backgroundColor: Color(kVerde.value),
            icon: const Icon(Icons.add_alert));
      }
    });
  }
}
