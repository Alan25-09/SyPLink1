import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/controllers/signup_provider.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/request/auth/signup_model.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/custom_btn.dart';
import 'package:jobhubv2_0/views/common/custom_textfield.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/screens/auth/login.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(
      builder: (context, signUpNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: 'Registro',
              child: GestureDetector(
                onTap: () {
                  Get.offAll(() => const LoginPage());
                },
                child: const Icon(
                  AntDesign.leftcircleo,
                ),
              ),
            ),
          ),
          body: signUpNotifier.loader
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
                              text: "¡Bienvenid@ a SyPLink!",
                              style: appStyle(
                                  25, Color(kDark.value), FontWeight.w600)),
                        ),
                        const HeightSpacer(size: 30),
                        Text(
                            "Regístrate para acceder a todas las funciones de la aplicación.",
                            textAlign: TextAlign.center,
                            style: appStyle(
                                15, Color(kDarkGris.value), FontWeight.w400)),
                        const HeightSpacer(size: 30),
                        CustomTextField(
                          controller: username,
                          hintText: 'Ingresa tu nombre completo',
                          keyboardType: TextInputType.text,
                          validator: (username) {
                            if (username!.isEmpty) {
                              return "Ingresa tu nombre completo";
                            }
                            return null;
                          },
                        ),
                        const HeightSpacer(size: 20),
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
                          obscureText: signUpNotifier.obscureText,
                          keyboardType: TextInputType.text,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              signUpNotifier.obscureText =
                                  !signUpNotifier.obscureText;
                            },
                            child: Icon(signUpNotifier.obscureText
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
                            onTap: () {
                              signUpNotifier.loader = true;

                              SignupModel model = SignupModel(
                                  username: username.text,
                                  email: email.text,
                                  password: password.text);

                              String newModel = signupModelToJson(model);

                              signUpNotifier.signUp(newModel);
                            },
                          );
                        }),
                        const HeightSpacer(size: 30),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Get.offAll(() => const LoginPage());
                            },
                            child: ReusableText(
                                text:
                                    '¿Ya tienes una cuenta? Inicia sesión aquí.',
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
