import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/controllers/zoom_provider.dart';
import 'package:syplink/views/common/app_style.dart';
import 'package:syplink/views/common/reusable_text.dart';
import 'package:syplink/views/common/width_spacer.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  final ValueSetter indexSetter;
  const DrawerScreen({super.key, required this.indexSetter});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomNotifier, child) {
        return GestureDetector(
          onDoubleTap: () {
            ZoomDrawer.of(context)!.toggle();
          },
          child: Scaffold(
            backgroundColor: Color(kVerde.value),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                drawerItem(
                    AntDesign.home,
                    "Inicio",
                    0,
                    zoomNotifier.currentIndex == 0
                        ? Color(kLight.value)
                        : Color(kGris.value)),
                drawerItem(
                    Ionicons.chatbubble_outline,
                    "Chat",
                    1,
                    zoomNotifier.currentIndex == 1
                        ? Color(kLight.value)
                        : Color(kGris.value)),
                drawerItem(
                    Fontisto.bookmark,
                    "Favoritos",
                    2,
                    zoomNotifier.currentIndex == 2
                        ? Color(kLight.value)
                        : Color(kGris.value)),
                drawerItem(
                    Ionicons.ios_file_tray_full_outline,
                    "Postulaciones",
                    3,
                    zoomNotifier.currentIndex == 3
                        ? Color(kLight.value)
                        : Color(kGris.value)),
                drawerItem(
                    FontAwesome5Regular.user_circle,
                    "Perfil",
                    4,
                    zoomNotifier.currentIndex == 4
                        ? Color(kLight.value)
                        : Color(kGris.value))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget drawerItem(IconData icon, String text, int index, Color color) {
    return GestureDetector(
      onTap: () {
        widget.indexSetter(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, bottom: 40.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const WidthSpacer(
              width: 12,
            ),
            ReusableText(
                text: text, style: appStyle(12, color, FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
