import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/bookmark_provider.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/controllers/vacants_provider.dart';
import 'package:jobhubv2_0/models/response/bookmarks/book_res.dart';
import 'package:jobhubv2_0/models/response/vacants/get_vacant.dart';
import 'package:jobhubv2_0/services/helpers/vacants_helper.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/screens/vacants/update_vacant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VacantDetails extends StatefulWidget {
  const VacantDetails(
      {super.key,
      required this.id,
      required this.title,
      required this.responsibleName});

  final String id;
  final String title;
  final String responsibleName;

  @override
  State<VacantDetails> createState() => _VacantDetailsState();
}

class _VacantDetailsState extends State<VacantDetails> {
  late Future<GetVacantRes> vacant;
  bool isAgent = false;
  @override
  void initState() {
    getVacant();
    getPrefs();
    super.initState();
  }

  getVacant() {
    vacant = VacantsHelper.getVacant(widget.id);
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAgent = prefs.getBool('isAgent') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<VacantsNotifier>(
      builder: (context, vacantsNotifier, child) {
        vacantsNotifier.getVacant(widget.id);
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppBar(actions: [
                loginNotifier.loggedIn != false
                    ? Consumer<BookNotifier>(
                        builder: (context, bookNotifier, child) {
                          bookNotifier.getBookMark(widget.id);
                          return GestureDetector(
                            onTap: () {
                              if (bookNotifier.bookmark == true) {
                                bookNotifier
                                    .deleteBookMark(bookNotifier.bookmarkId);
                              } else {
                                BookMarkReqRes model =
                                    BookMarkReqRes(vacant: widget.id);
                                var newModel = bookMarkReqResToJson(model);
                                bookNotifier.addBookMark(newModel);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: Icon(bookNotifier.bookmark == false
                                  ? Fontisto.bookmark
                                  : Fontisto.bookmark_alt),
                            ),
                          );
                        },
                      )
                    : const SizedBox.shrink()
              ], child: const BackBtn())),
          body: buildStyleContainer(
            context,
            FutureBuilder<GetVacantRes>(
                future: vacant,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const PageLoader();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    final vacant = snapshot.data;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Stack(
                        children: [
                          ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Container(
                                width: width,
                                height: height * 0.27,
                                decoration: BoxDecoration(
                                    color: Color(kGris.value),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/jobs.png'),
                                        opacity: 0.35),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9.w))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30.w,
                                      backgroundImage:
                                          NetworkImage(vacant!.imageUrl),
                                    ),
                                    const HeightSpacer(size: 10),
                                    ReusableText(
                                        text: vacant.title,
                                        style: appStyle(16, Color(kDark.value),
                                            FontWeight.w600)),
                                    const HeightSpacer(size: 5),
                                    ReusableText(
                                        text: vacant.area,
                                        style: appStyle(16, Color(kDark.value),
                                            FontWeight.w600)),
                                    const HeightSpacer(size: 15),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 50.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomOutlineBtn(
                                              width: width * 0.40,
                                              height: height * 0.04,
                                              text: vacant.schedule,
                                              color: Color(kDarkVerde.value)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const HeightSpacer(size: 20),
                              ReusableText(
                                  text: 'Descripción de la vacante',
                                  style: appStyle(
                                      16, Color(kDark.value), FontWeight.w600)),
                              const HeightSpacer(size: 10),
                              Text(
                                vacant.description,
                                textAlign: TextAlign.justify,
                                style: appStyle(
                                    13, Color(kDark.value), FontWeight.normal),
                              ),
                              const HeightSpacer(size: 20),
                              ReusableText(
                                  text: 'Requisitos',
                                  style: appStyle(
                                      16, Color(kDark.value), FontWeight.w600)),
                              const HeightSpacer(size: 10),
                              SizedBox(
                                height: height * 0.6,
                                child: ListView.builder(
                                  itemCount: vacant.requirements.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var requirement =
                                        vacant.requirements[index];
                                    String bullet = '\u2022';
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 12.w),
                                      child: Text(
                                        "$bullet $requirement",
                                        style: appStyle(13, Color(kDark.value),
                                            FontWeight.normal),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 20.0.w),
                                child: !isAgent
                                    ? CustomOutlineBtn(
                                        text: !loginNotifier.loggedIn
                                            ? "Iniciar sesión"
                                            : "Postularse",
                                        height: height * 0.06,
                                        onTap: () {},
                                        color: Color(kLight.value),
                                        color2: Color(kVerde.value),
                                      )
                                    : CustomOutlineBtn(
                                        text: 'Editar Vacante',
                                        onTap: () {
                                          vacantUpdate = vacant;
                                          Get.off(() => const UpdateVacant());
                                        },
                                        height: height * 0.06,
                                        color: Color(kLight.value),
                                        color2: Color(kVerde.value),
                                      )),
                          )
                          //),
                        ],
                      ),
                    );
                  }
                }),
          ),
        );
      },
    );
  }
}
