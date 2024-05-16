import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhubv2_0/controllers/skills_provider.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/response/auth/skills.dart';
import 'package:jobhubv2_0/services/helpers/auth_helper.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:provider/provider.dart';

class SkillWidget extends StatefulWidget {
  const SkillWidget({super.key});

  @override
  State<SkillWidget> createState() => _SkillWidgetState();
}

class _SkillWidgetState extends State<SkillWidget> {
  TextEditingController userskills = TextEditingController();
  late Future<List<Skills>> userSkills;

  @override
  void initState() {
    userSkills = getSkills();
    super.initState();
  }

  Future<List<Skills>> getSkills() {
    var skills = AuthHelper.getSkills();
    return skills;
  }

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                    text: 'Habilidades',
                    style: appStyle(15, Color(kDark.value), FontWeight.w600)),
                Consumer<SkillsNotifier>(
                    builder: (context, skillsNotifier, child) {
                  return skillsNotifier.addSkills != true
                      ? GestureDetector(
                          onTap: () {
                            skillsNotifier.setSkills =
                                !skillsNotifier.addSkills;
                          },
                          child: const Icon(
                              MaterialCommunityIcons.plus_circle_outline,
                              size: 24),
                        )
                      : GestureDetector(
                          onTap: () {
                            skillsNotifier.setSkills =
                                !skillsNotifier.addSkills;
                          },
                          child: const Icon(AntDesign.closecircleo, size: 20),
                        );
                })
              ],
            )),
      ],
    );
  }
}
