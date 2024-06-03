import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/screens/auth/profile_page.dart';

Widget chatRightItem(String type, String message, String profile) {
  return Align(
    alignment: Alignment.centerRight,
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 10.w, 15.w, 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 230.w,
                  minHeight: 40.w,
                ),
                child: Container(
                    margin: EdgeInsets.only(left: 10.w),
                    padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 167, 201, 87),
                          Color.fromARGB(255, 167, 201, 87),
                        ], transform: GradientRotation(120))),
                    child: Text(
                      message,
                      style: appStyle(12, Colors.white, FontWeight.normal),
                    )),
              )
            ],
          ),
        ),
        Positioned(
            right: 4,
            child: CircularPicture(
              image: profile,
              w: 20,
              h: 20,
            ))
      ],
    ),
  );
}
