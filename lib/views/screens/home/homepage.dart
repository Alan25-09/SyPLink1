import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jobhubv2_0/views/screens/auth/profileScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imagenUrl =
      "https://img.freepik.com/vector-premium/ola-oceano-gran-rizo-agua-corriendo-abajo_176411-4945.jpg?w=360";
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
                ))),
        body: Center(
          child: ReusableText(
            text: "Principal",
            style: appStyle(30, Color(kDark.value), FontWeight.bold),
          ),
        ));
  }
}
