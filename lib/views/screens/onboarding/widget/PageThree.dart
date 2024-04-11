import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/screens/mainscreen.dart';

/* Clase donde se construye la página tres de la introducción */
class PageThree extends StatelessWidget {
  const PageThree({super.key});

/* Método donde se construye la estructura de la página */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      // Fondo de la página
      child: Container(
        width: width,
        height: height,
        color: Color(kAmarillo.value),
        child: Column(
          children: [
            // Imagen que se va a utilizar
            Image.asset("assets/images/prueba3.png"),
            // Espacio vertical
            const SizedBox(
              height: 20,
            ),
            // Texto
            Text(
              '¡Bienvenid@ a SPyLink!',
              style: appStyle(28, Color(kDark.value), FontWeight.w500),
            ),
            // Espacio vertical
            const SizedBox(
              height: 30,
            ),
            // Texto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                  'Te ayudamos con el proceso de búsqueda y postulación, todo desde una simple aplicación.',
                  textAlign: TextAlign.center,
                  style: appStyle(14, Color(kDark.value), FontWeight.normal)),
            ),
            // Espacio vertical
            const SizedBox(
              height: 30,
            ),
            // Botón que dirige a la página de inicio
            CustomOutlineBtn(
                // Al hacer click, ejecutar acción de ir a la página de inicio
                onTap: () {
                  Get.to(() => Mainscreen());
                },
                // Propiedades del botón
                height: height * 0.05,
                width: width * 0.9,
                text: 'Continuar como invitad@',
                color: Color(kDark.value)),
          ],
        ),
      ),
    ));
  }
}
