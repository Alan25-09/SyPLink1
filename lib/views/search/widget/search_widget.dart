import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
        child: Container(
          padding: EdgeInsets.all(0.w),
          decoration: BoxDecoration(
            color: Color(kLight.value),
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
          ),
          child: Row(),
        ),
      ),
    );
  }
}
