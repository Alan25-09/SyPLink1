import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/custom_btn.dart';
import 'package:jobhubv2_0/views/common/custom_textfield.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/screens/auth/registration.dart';
import 'package:jobhubv2_0/views/screens/mainscreen.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: 'Inicio de sesión',
              child: GestureDetector(
                onTap: () {
                  Get.offAll(() => const Mainscreen());
                },
                child: const Icon(
                  AntDesign.leftcircleo,
                ),
              ),
            ),
          ),
          body: loginNotifier.loader
              ? const PageLoader()
              : buildStyleContainer(
                  context,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                        child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        const HeightSpacer(size: 50),
                        Center(
                          child: ReusableText(
                              text: "¡Bienvenid@ de vuelta!",
                              style: appStyle(
                                  25, Color(kDark.value), FontWeight.w600)),
                        ),
                        const HeightSpacer(size: 30),
                        Text(
                            "Inicia sesión para acceder a todas las funciones de la aplicación.",
                            textAlign: TextAlign.center,
                            style: appStyle(
                                15, Color(kDarkGris.value), FontWeight.w400)),
                        const HeightSpacer(size: 30),
                        CustomTextField(
                          controller: email,
                          hintText: 'Ingresa tu correo electrónico',
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email!.isEmpty || !email.contains('@')) {
                              return "Ingresa tu correo electrónico";
                            }
                            return null;
                          },
                        ),
                        const HeightSpacer(size: 20),
                        CustomTextField(
                          controller: password,
                          hintText: 'Ingresa tu contraseña',
                          obscureText: loginNotifier.obscureText,
                          keyboardType: TextInputType.text,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              loginNotifier.obscureText =
                                  !loginNotifier.obscureText;
                            },
                            child: Icon(loginNotifier.obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          validator: (password) {
                            if (password!.isEmpty || password.length < 6) {
                              return "Ingresa una contraseña válida";
                            }
                            return null;
                          },
                        ),
                        const HeightSpacer(size: 30),
                        Consumer<ZoomNotifier>(
                            builder: (context, zoomNotifier, child) {
                          return CustomButton(
                            text: "Iniciar sesión",
                            onTap: () {},
                          );
                        }),
                        const HeightSpacer(size: 30),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Get.offAll(() => const RegistrationPage());
                            },
                            child: ReusableText(
                                text:
                                    '¿Aún no tienes una cuenta? Regístrate aquí.',
                                style: appStyle(14, Color(kDarkGris.value),
                                    FontWeight.w400)),
                          ),
                        ),
                      ],
                    )),
                  )),
        );
        ;
      },
    );
  }
}
