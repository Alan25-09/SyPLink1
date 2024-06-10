import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/views/common/app_style.dart';

/* Clase donde se construye la página dos de la introducción */
class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

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
            // Espacio vertical
            const SizedBox(
              height: 50,
            ),
            // Imagen que se va a utilizar
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: Image.asset("assets/images/prueba2.png"),
            ),
            // Espacio vertical
            const SizedBox(
              height: 20,
            ),
            // Columna donde se organiza el texto
            Column(
              children: [
                Text(
                    'Pon en práctica tus habilidades\nen el área de tu interés',
                    textAlign: TextAlign.center,
                    style: appStyle(20, Color(kDark.value), FontWeight.w500)),
                // Espacio vertical
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                      'Te ayudamos con el proceso de búsqueda y postulación, todo desde una simple aplicación.',
                      textAlign: TextAlign.center,
                      style:
                          appStyle(14, Color(kDark.value), FontWeight.normal)),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
