import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
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

class AddVacant extends StatefulWidget {
  const AddVacant({super.key});

  @override
  State<AddVacant> createState() => _AddVacantState();
}

class _AddVacantState extends State<AddVacant> {
  TextEditingController title = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController responibleId = TextEditingController();
  TextEditingController responsibleName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController schedule = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
  TextEditingController rq1 = TextEditingController();
  TextEditingController rq2 = TextEditingController();
  TextEditingController rq3 = TextEditingController();
  TextEditingController rq4 = TextEditingController();
  TextEditingController rq5 = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var skillsNotifier = Provider.of<SkillsNotifier>(context);
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    return Scaffold(
      backgroundColor: Color(kVerde.value),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.w),
          child: CustomAppBar(
              color: Color(kVerde.value),
              text: "Publicar vacantes",
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
                                    return ("El campo no puede estar vacío");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Título de la vacante"),
                                hintText: "Ej. Apoyo a los docentes",
                                controller: title),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("El campo no puede estar vacío");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Área"),
                                hintText: "Prácticas | Servicio",
                                controller: area),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("El campo no puede estar vacío");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Descripción de la vacante"),
                                hintText:
                                    "UPIICSA está buscando estudiantes comprometidos y entusiastas para realizar su servicio social en diversas áreas académicas y administrativas...",
                                controller: description),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("El campo no puede estar vacío");
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
                                              return ("El campo no puede estar vacío");
                                            } else {
                                              return null;
                                            }
                                          },
                                          label: const Text("URL"),
                                          hintText: "URL de Imagen",
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
                                    return ("El campo no puede estar vacío");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requerimiento #1"),
                                hintText:
                                    "Ej. Tener interés en participar activamente en el desarrollo de proyectos institucionales.",
                                controller: rq1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                maxLines: 2,
                                height: 80,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("El campo no puede estar vacío");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requerimiento #2"),
                                hintText:
                                    "Ej. Habilidades interpersonales y capacidad para trabajar en equipo.",
                                controller: rq2),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                maxLines: 2,
                                height: 80,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("El campo no puede estar vacío");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requerimiento #3"),
                                hintText:
                                    "Ej. Compromiso con la ética y responsabilidad profesional.",
                                controller: rq3),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                maxLines: 2,
                                height: 80,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("El campo no puede estar vacío");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requerimiento #4"),
                                hintText:
                                    "Ej. Buena capacidad de comunicación verbal y escrita.",
                                controller: rq4),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildtextfield(
                                maxLines: 2,
                                height: 80,
                                onSubmitted: (value) {
                                  if (value!.isEmpty) {
                                    return ("El campo no puede estar vacío");
                                  } else {
                                    return null;
                                  }
                                },
                                label: const Text("Requerimiento #5"),
                                hintText:
                                    "Ej. Manejo básico de herramientas informáticas y software relacionado con su área de estudio.",
                                controller: rq5),
                          ),
                          CustomOutlineBtn(
                              width: width,
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String agentName =
                                    prefs.getString("username") ?? "";

                                CreateVacantRequest rawModel =
                                    CreateVacantRequest(
                                  title: title.text,
                                  area: area.text,
                                  responsibleId: userUid,
                                  responsibleName: agentName,
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
                                );
                                var model = createVacantRequestToJson(rawModel);

                                VacantsHelper.createVacant(model);
                                zoomNotifier.currentIndex = 0;
                                Get.to(() => const Mainscreen());
                              },
                              height: 40.h,
                              text: "Publicar vacante",
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
