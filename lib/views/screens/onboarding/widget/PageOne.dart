import 'package:flutter/material.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/views/common/exports.dart';

/* Clase donde se construye la página uno de la aplicación */
class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kAmarUpi.value),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Image.asset("assets/images/prueba1.png"),
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                Text('Encuentra vacantes\ndentro de tu institución',
                    textAlign: TextAlign.center,
                    style: appStyle(20, Color(kDark.value), FontWeight.w500)),
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
    );
  }
}
