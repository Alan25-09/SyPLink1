import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jobhubv2_0/views/screens/auth/profile_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.drawer});

  final bool drawer;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: widget.drawer == false
                  ? BackBtn()
                  : DrawerWidget(
                      color: Color(kDark.value),
                    ),
            ),
          ),
        ),
        body: Center(
          child: ReusableText(
            text: "Perfil",
            style: appStyle(30, Color(kDark.value), FontWeight.bold),
          ),
        ));
  }
}
