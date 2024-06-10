import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:syplink/controllers/skills_provider.dart';
import 'package:syplink/controllers/zoom_provider.dart';
import 'package:syplink/models/request/auth/add_skills.dart';
import 'package:syplink/models/response/auth/skills.dart';
import 'package:syplink/services/helpers/auth_helper.dart';
import 'package:syplink/views/common/exports.dart';
import 'package:syplink/views/common/height_spacer.dart';
import 'package:syplink/views/common/width_spacer.dart';
import 'package:syplink/views/screens/auth/widgets/addSkills.dart';
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

  void _addSkill() {
    AddSkill rawModel = AddSkill(skill: userskills.text);
    var model = addSkillToJson(rawModel);
    AuthHelper.addSkill(model).then((_) {
      setState(() {
        userSkills = getSkills();
      });
      userskills.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var skillsNotifier = Provider.of<SkillsNotifier>(context);
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
                          skillsNotifier.setSkills = !skillsNotifier.addSkills;
                        },
                        child: const Icon(
                            MaterialCommunityIcons.plus_circle_outline,
                            size: 24),
                      )
                    : GestureDetector(
                        onTap: () {
                          skillsNotifier.setSkills = !skillsNotifier.addSkills;
                        },
                        child: const Icon(AntDesign.closecircleo, size: 20),
                      );
              })
            ],
          ),
        ),
        const HeightSpacer(size: 5),
        skillsNotifier.addSkills == true
            ? AddSkillsWidget(
                skill: userskills,
                onTap: _addSkill,
              )
            : SizedBox(
                height: 40.w,
                child: FutureBuilder(
                    future: userSkills,
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        var skills = snapshot.data;
                        return ListView.builder(
                            itemCount: skills!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var skill = skills[index];
                              return GestureDetector(
                                onLongPress: () {
                                  skillsNotifier.setSkillsId = skill.id;
                                },
                                onTap: () {
                                  skillsNotifier.setSkillsId = '';
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5.w),
                                  margin: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.w)),
                                      color: Color(kVerde.value)),
                                  child: Row(
                                    children: [
                                      ReusableText(
                                          text: skill.skill,
                                          style: appStyle(
                                              12,
                                              Color(kLight.value),
                                              FontWeight.w500)),
                                      const WidthSpacer(width: 5),
                                      skillsNotifier.addSkillId == skill.id
                                          ? GestureDetector(
                                              onTap: () {
                                                AuthHelper.deleteSkill(
                                                    skillsNotifier.addSkillId);
                                                skillsNotifier.setSkillsId = '';
                                                userSkills = getSkills();
                                              },
                                              child: Icon(
                                                AntDesign.delete,
                                                size: 15,
                                                color: Color(kLight.value),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    })),
              )
      ],
    );
  }
}
