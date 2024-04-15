import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/views/applications/applied_Jobs.dart';
import 'package:jobhubv2_0/views/common/drawer/drawerScreen.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/screens/auth/profileScreen.dart';
import 'package:jobhubv2_0/views/screens/bookmarks/bookmarks.dart';
import 'package:jobhubv2_0/views/screens/chat/chat_list.dart';
import 'package:jobhubv2_0/views/screens/home/homepage.dart';
import 'package:provider/provider.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ZoomNotifier>(builder: (context, zoomNotifier, child) {
        return ZoomDrawer(
            menuScreen: DrawerScreen(indexSetter: (index) {
              zoomNotifier.currentIndex = index;
            }),
            mainScreen: currentScreen());
      }),
    );
  }

  Widget currentScreen() {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex) {
      case 0:
        return HomePage();

      case 1:
        return ChatList();

      case 2:
        return Bookmarks();

      case 3:
        return AppliedJobs();

      case 4:
        return ProfileScreen(
          drawer: true,
        );

      default:
        return HomePage();
    }
  }
}
