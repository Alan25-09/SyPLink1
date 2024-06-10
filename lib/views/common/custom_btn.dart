import 'package:flutter/material.dart';
import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/views/common/app_style.dart';
import 'package:syplink/views/common/reusable_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.color, this.onTap});

  final String text;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height * 0.065,
          decoration: BoxDecoration(
              color: Color(kVerde.value),
              borderRadius: const BorderRadius.all(Radius.circular(9))),
          child: Center(
            child: ReusableText(
                text: text,
                style: appStyle(
                    16, color ?? Color(kLight.value), FontWeight.w600)),
          ),
        ));
  }
}
