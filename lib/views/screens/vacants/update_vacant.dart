import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/skills_provider.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/request/jobs/create_vacant.dart';
import 'package:jobhubv2_0/services/helpers/vacants_helper.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/common/textfield.dart';
import 'package:jobhubv2_0/views/screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateVacant extends StatefulWidget {
  const UpdateVacant({super.key});

  @override
  State<UpdateVacant> createState() => _UpdateVacantState();
}

class _UpdateVacantState extends State<UpdateVacant> {
  TextEditingController title =
      TextEditingController(text: vacantUpdate!.title);
  TextEditingController area = TextEditingController(text: vacantUpdate!.area);
  TextEditingController responibleId =
      TextEditingController(text: vacantUpdate!.responsibleId);
  TextEditingController responsibleName =
      TextEditingController(text: vacantUpdate!.responsibleName);
  TextEditingController description =
      TextEditingController(text: vacantUpdate!.description);
  TextEditingController schedule =
      TextEditingController(text: vacantUpdate!.schedule);
  TextEditingController imageUrl =
      TextEditingController(text: vacantUpdate!.imageUrl);
  TextEditingController rq1 =
      TextEditingController(text: vacantUpdate!.requirements[0]);
  TextEditingController rq2 =
      TextEditingController(text: vacantUpdate!.requirements[1]);
  TextEditingController rq3 =
      TextEditingController(text: vacantUpdate!.requirements[2]);
  TextEditingController rq4 =
      TextEditingController(text: vacantUpdate!.requirements[3]);
  TextEditingController rq5 =
      TextEditingController(text: vacantUpdate!.requirements[4]);

  TextEditingController imageController =
      TextEditingController(text: vacantUpdate!.imageUrl);

  String image =
      "https://d326fntlu7tb1e.cloudfront.net/uploads/b5065bb8-4c6b-4eac-a0ce-86ab0f597b1e-vinci_04.jpg";

  @override
  Widget build(BuildContext context) {
    var skillsNotifier = Provider.of<SkillsNotifier>(context);
    var zoomNotifier = Provider.of<ZoomNotifier>(context);

    return Scaffold(
      backgroundColor: Color(kVerde.value),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.w),
          child: CustomAppBar(
              actions: [
                Consumer<SkillsNotifier>(
                  builder: (context, skillsNotifier, child) {
                    return skillsNotifier.logoUrl.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(skillsNotifier.logoUrl),
                              radius: 20,
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                )
              ],
              color: Color(kVerde.value),
              text: "Actualiza Vacantes",
              child: const BackBtn())),
      body: Stack(
        children: [
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Color(kLight.value)),
                child: buildStyleContainer(
                    context,
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 20),
                      child: ListView(
                        children: [
                          const HeightSpacer(size: 20),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Por favor llene el campo");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Titulo"),
                                hintText: "Titulo",
                                controller: title),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Por favor llene el campo");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Area"),
                                hintText: "Area",
                                controller: area),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Por favor llene el campo");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Id del responsable"),
                                hintText: "Id del responable",
                                controller: responibleId),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Por favor llene el campo");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Responsable"),
                                hintText: "Responsable",
                                controller: responsibleName),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Por favor llene el campo");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Descripción"),
                                hintText: "Descripción",
                                controller: description),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Por favor llene el campo");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Horarios"),
                                hintText: "Tiempo completo | Medio tiempo",
                                controller: schedule),
                          ),
                          Consumer<SkillsNotifier>(
                            builder: (context, skillsNotifier, child) {
                              return SizedBox(
                                width: width,
                                height: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width * 0.8,
                                      height: 60,
                                      child: buildtextfield(
                                          onChanged: (value) {
                                            skillsNotifier.setLogoUrl(
                                                imageController.text);
                                          },
                                          onSubmitted: (value) {
                                            if (value!.isEmpty &&
                                                value.contains('https://')) {
                                              return ("Por favor llene el campo");
                                            } else {
                                              return null;
                                            }
                                          },
                                          label: const Text("Image Url"),
                                          hintText: "Image Url",
                                          controller: imageController),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        skillsNotifier
                                            .setLogoUrl(imageController.text);
                                      },
                                      child: Icon(Entypo.upload_to_cloud,
                                          size: 35, color: Color(kVerde.value)),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          ReusableText(
                              text: "Requerimentos",
                              style:
                                  appStyle(15, Colors.black, FontWeight.w600)),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                maxLines: 2,
                                height: 80,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Por favor llene el campo");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requerimientos"),
                                hintText: "Requerimientos",
                                controller: rq1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                maxLines: 2,
                                height: 80,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Por favor llene el campo");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requerimientos"),
                                hintText: "Requerimientos",
                                controller: rq2),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                maxLines: 2,
                                height: 80,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Por favor llene el campo");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requerimientos"),
                                hintText: "Requerimientos",
                                controller: rq3),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                maxLines: 2,
                                height: 80,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Por favor llene el campo");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requerimientos"),
                                hintText: "Requerimientos",
                                controller: rq4),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                maxLines: 2,
                                height: 80,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("Por favor llene el campo");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requerimientos"),
                                hintText: "Requerimientos",
                                controller: rq5),
                          ),
                          CustomOutlineBtn(
                              width: width,
                              onTap: () async {
                                // SharedPreferences prefs =
                                //     await SharedPreferences.getInstance();
                                // String agentName =
                                //     prefs.getString("username") ?? "";

                                CreateVacantRequest rawModel =
                                    CreateVacantRequest(
                                  title: title.text,
                                  area: area.text,
                                  responsibleId: responibleId.text,
                                  responsibleName: responsibleName.text,
                                  schedule: schedule.text,
                                  status: true,
                                  description: description.text,
                                  imageUrl: skillsNotifier.logoUrl,
                                  requirements: [
                                    rq1.text,
                                    rq2.text,
                                    rq3.text,
                                    rq4.text,
                                    rq5.text,
                                  ],
                                  //agentName: agentName)
                                );

                                var model = createVacantRequestToJson(rawModel);

                                VacantsHelper.updateVacant(
                                    model, vacantUpdate!.id);
                                zoomNotifier.currentIndex = 0;
                                Get.to(() => const Mainscreen());
                              },
                              height: 40.h,
                              text: "Submit",
                              color: Color(kVerde.value))
                        ],
                      ),
                    )),
              ))
        ],
      ),
    );
  }
}
