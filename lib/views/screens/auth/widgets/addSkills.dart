import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/textfield.dart';

class AddSkillsWidget extends StatelessWidget {
  final TextEditingController skill;
  final void Function()? onTap;
  const AddSkillsWidget({super.key, required this.skill, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2.w),
        height: 62.w,
        child: buildtextfield(
          hintText: 'Agregar una nueva habilidad',
          controller: skill,
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              Entypo.upload_to_cloud,
              size: 30,
              color: Color(kVerde.value),
            ),
          ),
          onSubmitted: (p0) {
            if (p0!.isEmpty) {
              return 'Ingrese el nombre de la habilidad';
            } else {
              return null;
            }
          },
        ));
  }
}
