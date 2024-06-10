import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:syplink/controllers/zoom_provider.dart';
import 'package:syplink/views/applications/applied_vacants.dart';
import 'package:syplink/views/common/drawer/drawerScreen.dart';
import 'package:syplink/views/common/exports.dart';
import 'package:syplink/views/screens/auth/profile_page.dart';
import 'package:syplink/views/screens/bookmarks/bookmarks.dart';
import 'package:syplink/views/screens/chat/chat_list.dart';
import 'package:syplink/views/screens/home/homepage.dart';
import 'package:provider/provider.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    /* Método para crear el menú lateral que se despliega en pantalla
    una vez que se ingresó a la aplicación como invitado */
    return Scaffold(
      body: Consumer<ZoomNotifier>(builder: (context, zoomNotifier, child) {
        return ZoomDrawer(
            menuScreen: DrawerScreen(indexSetter: (index) {
              zoomNotifier.currentIndex = index;
            }),
            borderRadius: 30,
            menuBackgroundColor: Color(kVerde.value),
            angle: 0.0,
            slideWidth: 230,
            mainScreen: currentScreen());
      }),
    );
  }

  /* Switch para controlar a qué página redirigir al usuario,
  dependiendo su interacción con el menú de la app */
  Widget currentScreen() {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex) {
      case 0:
        return const HomePage();

      case 1:
        return const ChatList();

      case 2:
        return const Bookmarks();

      case 3:
        return const AppliedVacants();

      case 4:
        return const ProfileScreen(
          drawer: true,
        );

      default:
        return const HomePage();
    }
  }
}
