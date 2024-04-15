import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jobhubv2_0/views/screens/auth/profile_page.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  String imagenUrl =
      "https://img.freepik.com/vector-premium/perfil-avatar-hombre-icono-redondo_24640-14044.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            actions: [
              Padding(
                padding: EdgeInsets.all(12.0.h),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const ProfileScreen(drawer: false));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: CachedNetworkImage(
                      height: 25.w,
                      width: 25.w,
                      imageUrl: imagenUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: DrawerWidget(color: Color(kDark.value)),
            ),
          ),
        ),
        body: Center(
          child: ReusableText(
            text: "Favoritos",
            style: appStyle(30, Color(kDark.value), FontWeight.bold),
          ),
        ));
  }
}
