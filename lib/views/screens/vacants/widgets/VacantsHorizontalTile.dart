import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/models/response/vacants/vacants_response.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/width_spacer.dart';

class VacantHorizontalTile extends StatelessWidget {
  const VacantHorizontalTile({super.key, this.onTap, required this.vacant});

  final void Function()? onTap;
  final VacantsResponse vacant;
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
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                decoration: BoxDecoration(
                  color: Color(kLightGrey.value),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/jobs.png'),
                    fit: BoxFit.contain,
                    opacity: 0.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(vacant.imageUrl),
                        ),
                        const WidthSpacer(width: 15),
                        Container(
                          width: 160.w,
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                              color: Color(kLight.value),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.w))),
                          child: ReusableText(
                              text: vacant.area,
                              style: appStyle(
                                  22, Color(kDark.value), FontWeight.w600)),
                        )
                      ],
                    ),
                    const HeightSpacer(size: 15),
                    ReusableText(
                        text: vacant.title,
                        style:
                            appStyle(18, Color(kDark.value), FontWeight.w600)),
                    const HeightSpacer(size: 5),
                    ReusableText(
                        text: vacant.responsibleName,
                        style: appStyle(
                            16, Color(kDarkGris.value), FontWeight.w600)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ReusableText(
                                text: vacant.schedule,
                                style: appStyle(
                                    20, Color(kDark.value), FontWeight.w600)),
                          ],
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Color(kLight.value),
                          child: const Icon(Ionicons.chevron_forward),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
