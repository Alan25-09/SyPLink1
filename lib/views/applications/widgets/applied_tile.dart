import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/models/response/applied/applied.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/screens/vacants/vacant_details_page.dart';

class AppliedTile extends StatelessWidget {
  const AppliedTile({super.key, required this.vacant});

  final Vacant vacant;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          Get.to(() => VacantDetails(
              id: vacant.id,
              title: vacant.title,
              responsibleName: vacant.responsibleName));
        },
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.w,
            ),
            height: height * 0.143,
            width: width,
            decoration: BoxDecoration(
              color: const Color(0x09000000),
              borderRadius: BorderRadius.all(Radius.circular(9.w)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(vacant.imageUrl),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width * 0.65,
                              child: ReusableText(
                                  text: vacant.title,
                                  style: appStyle(
                                      16, Color(kDark.value), FontWeight.w500)),
                            ),
                            SizedBox(
                              width: width * 0.65,
                              child: ReusableText(
                                  text: vacant.responsibleName,
                                  style: appStyle(
                                      14, Color(kDark.value), FontWeight.w500)),
                            ),
                            SizedBox(
                              width: width * 0.65,
                              child: ReusableText(
                                  text: vacant.schedule,
                                  style: appStyle(
                                      14, Color(kDark.value), FontWeight.w500)),
                            )
                          ],
                        ),
                        CustomOutlineBtn(
                            width: 45.w,
                            height: 36.h,
                            text: "Ver",
                            color: Color(kLightBlue.value))
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
