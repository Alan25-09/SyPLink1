import 'package:flutter/material.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/views/common/exports.dart';

/* Clase donde se construye la página uno de la introducción */
class PageOne extends StatelessWidget {
  const PageOne({super.key});

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
              height: 30,
            ),
            // Imagen que se va a utilizar
            Image.asset("assets/images/prueba1.png"),
            // Espacio vertical
            const SizedBox(
              height: 30,
            ),
            // Columna donde se organiza el texto
            Column(
              children: [
                Text('Encuentra oportunidades\ndentro de tu institución',
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
