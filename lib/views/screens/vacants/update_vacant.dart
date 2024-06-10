import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/views/common/app_style.dart';
import 'package:syplink/views/common/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:syplink/controllers/skills_provider.dart';
import 'package:syplink/controllers/zoom_provider.dart';
import 'package:syplink/models/request/jobs/create_vacant.dart';
import 'package:syplink/services/helpers/vacants_helper.dart';
import 'package:syplink/views/common/BackBtn.dart';
import 'package:syplink/views/common/app_bar.dart';
import 'package:syplink/views/common/custom_outline_btn.dart';
import 'package:syplink/views/common/height_spacer.dart';
import 'package:syplink/views/common/styled_container.dart';
import 'package:syplink/views/common/textfield.dart';
import 'package:syplink/views/screens/mainscreen.dart';
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
              text: "Editar vacante",
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

                                if (title.text.isEmpty ||
                                    area.text.isEmpty ||
                                    description.text.isEmpty ||
                                    schedule.text.isEmpty ||
                                    rq1.text.isEmpty ||
                                    rq2.text.isEmpty ||
                                    rq3.text.isEmpty ||
                                    rq4.text.isEmpty ||
                                    rq5.text.isEmpty) {
                                  Get.snackbar(
                                    'Error',
                                    'Todos los campos son obligatorios y deben ser llenados.',
                                    colorText: Color(kLight.value),
                                    backgroundColor: Colors.red,
                                    icon: const Icon(Icons.error_outline),
                                  );
                                  return; // Detener el proceso si algún campo obligatorio está vacío
                                }

                                // Validación de la URL de imagen
                                if (imageController.text.isEmpty) {
                                  imageController.text =
                                      "https://upload.wikimedia.org/wikipedia/commons/a/a2/UPIICSA_LOGO.jpg";
                                }

                                CreateVacantRequest rawModel =
                                    CreateVacantRequest(
                                  title: title.text,
                                  area: area.text,
                                  responsibleId: vacantUpdate!.responsibleId,
                                  responsibleName: agentName,
                                  schedule: schedule.text,
                                  status: vacantUpdate!.status,
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

                                try {
                                  await VacantsHelper.updateVacant(
                                      model, vacantUpdate!.id);
                                  Get.snackbar(
                                    'Vacante actualizada',
                                    'La vacante se ha actualizado con éxito.',
                                    colorText: Color(kLight.value),
                                    backgroundColor: Color(kVerde.value),
                                    icon:
                                        const Icon(Icons.check_circle_outline),
                                  );
                                  zoomNotifier.currentIndex = 0;
                                  Get.to(() => const Mainscreen());
                                } catch (error) {
                                  Get.snackbar(
                                    'Error',
                                    'Ocurrió un error al actualizar la vacante.',
                                    colorText: Color(kLight.value),
                                    backgroundColor: Colors.red,
                                    icon: const Icon(Icons.error_outline),
                                  );
                                }
                              },
                              height: 40.h,
                              text: "Actualizar",
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
