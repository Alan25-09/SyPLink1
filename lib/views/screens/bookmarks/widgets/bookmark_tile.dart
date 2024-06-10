import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/models/response/bookmarks/all_bookmarks.dart';
import 'package:syplink/views/common/app_style.dart';
import 'package:syplink/views/common/custom_outline_btn.dart';
import 'package:syplink/views/common/reusable_text.dart';
import 'package:syplink/views/screens/vacants/vacant_details_page.dart';

class BookMarkTile extends StatelessWidget {
  const BookMarkTile({super.key, required this.bookmark});

  final AllBookMarks bookmark;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          Get.to(() => VacantDetails(
              id: bookmark.vacant.id,
              title: bookmark.vacant.title,
              responsibleName: bookmark.vacant.responsibleName));
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
                          backgroundImage:
                              NetworkImage(bookmark.vacant.imageUrl),
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
                                  text: bookmark.vacant.title,
                                  style: appStyle(
                                      16, Color(kDark.value), FontWeight.w500)),
                            ),
                            SizedBox(
                              width: width * 0.65,
                              child: ReusableText(
                                  text: bookmark.vacant.responsibleName,
                                  style: appStyle(
                                      14, Color(kDark.value), FontWeight.w500)),
                            ),
                            SizedBox(
                              width: width * 0.65,
                              child: ReusableText(
                                  text: bookmark.vacant.schedule,
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
