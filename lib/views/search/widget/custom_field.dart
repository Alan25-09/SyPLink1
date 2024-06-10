import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/views/common/app_style.dart';
import 'package:syplink/views/common/width_spacer.dart';

class CustomField extends StatelessWidget {
  const CustomField({super.key, this.onTap, required this.controller});

  final void Function()? onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45.h,
      padding: EdgeInsets.only(bottom: 5.w),
      color: Color(kLightGrey.value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const WidthSpacer(width: 5),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Ionicons.chevron_back_circle,
                  size: 30.h,
                  color: Color(kVerde.value),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.h),
                width: width * 0.75,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Busca y encuentra una vacante',
                      hintStyle:
                          appStyle(14, Color(kDarkGrey.value), FontWeight.w500),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              BorderSide(color: Colors.red, width: 0.5)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              BorderSide(color: Colors.red, width: 0.5)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                              color: Color(kDarkGrey.value), width: 0.5)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                              color: Colors.transparent, width: 0.5)),
                      border: InputBorder.none),
                  controller: controller,
                  cursorHeight: 25,
                  style: appStyle(14, Color(kDark.value), FontWeight.w500),
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Icon(
                  Ionicons.search_circle_outline,
                  size: 30.h,
                  color: Color(kVerde.value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
