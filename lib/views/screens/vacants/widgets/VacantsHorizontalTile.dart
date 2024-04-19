import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/models/response/vacants/vacants_response.dart';

class VacantHorizontalTile extends StatelessWidget {
  const VacantHorizontalTile({super.key, this.onTap, required this.vacn});

  final void Function()? onTap;
  final VacantsResponse vacn;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(12.w),
              ),
              child: Container(
                height: height * 0.27,
                width: width * 0.7,
                decoration: BoxDecoration(color: Color(kLightGrey.value)),
              ),
            )));
  }
}
