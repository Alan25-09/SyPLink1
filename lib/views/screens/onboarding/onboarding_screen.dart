import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syplink/controllers/onboarding_provider.dart';
import 'package:syplink/views/common/exports.dart';
import 'package:syplink/views/screens/onboarding/widget/PageOne.dart';
import 'package:syplink/views/screens/onboarding/widget/PageThree.dart';
import 'package:syplink/views/screens/onboarding/widget/PageTwo.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  /*Método que crea el estado mutable de la pantalla de inicio*/
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();

  /* Método que "limpia" el pageController cuando el widget
  OnboardingScreen no se utiliza */
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  /*Método donde se construye la UI de la pantalla de inicio*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<OnBoardNotifier>(
      builder: (context, onBoardNotifier, child) {
        return Stack(
          children: [
            PageView(
              controller: pageController,
              /* Físicas de la interacción (scroll) de la pantalla.
                  Verifica si se ha llegado a la última pantalla de
                  introducción: si es cierto, entonces no deja desplazar
                  de regreso la pantalla. */
              physics: onBoardNotifier.isLastPage
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              onPageChanged: (page) {
                onBoardNotifier.isLastPage = page == 2;
              },
              children: const [PageOne(), PageTwo(), PageThree()],
            ),
            onBoardNotifier.isLastPage
                ? const SizedBox.shrink()
                /* Parámetros para definir la estética y e interacción del
                indicador de página que se muestra en la parte inferior
                de la pantalla */
                : Positioned(
                    bottom: height * 0.08,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        // Estética del indicador
                        effect: WormEffect(
                            dotColor: Color(kVerde.value),
                            activeDotColor: Color(kDarkVerde.value),
                            dotHeight: 12,
                            dotWidth: 12,
                            spacing: 10),
                      ),
                    )),
            onBoardNotifier.isLastPage
                ? const SizedBox.shrink()
                /* Botones para navegar a través de las pantallas de
                introducción, proporcionan la opción de navegar entre
                las pantallas o bien, saltar hasta la última de ellas
                para ingresar a la aplicación */
                : Positioned(
                    child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                pageController.jumpToPage(2);
                              },
                              child: ReusableText(
                                  text: 'Omitir',
                                  style: appStyle(13, Color(kDark.value),
                                      FontWeight.normal)),
                            ),
                            GestureDetector(
                              onTap: () {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              },
                              child: ReusableText(
                                  text: 'Siguiente',
                                  style: appStyle(13, Color(kDark.value),
                                      FontWeight.normal)),
                            )
                          ],
                        )),
                  ))
          ],
        );
      },
    ));
  }
}
