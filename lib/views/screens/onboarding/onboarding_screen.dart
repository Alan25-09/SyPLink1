import 'package:flutter/material.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/views/screens/onboarding/widget/PageOne.dart';
import 'package:jobhubv2_0/views/screens/onboarding/widget/PageThree.dart';
import 'package:jobhubv2_0/views/screens/onboarding/widget/PageTwo.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            /* Físicas de la interacción (scroll) de la pantalla */
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [PageOne(), PageTwo(), PageThree()],
          ),
          Positioned(child: Center()),
          Positioned(child: Center())
        ],
      ),
    );
  }
}
