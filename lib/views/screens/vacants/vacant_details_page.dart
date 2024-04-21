import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/vacants_provider.dart';
import 'package:jobhubv2_0/models/response/vacants/get_vacant.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Consumer<VacantsNotifier>(
      builder: (context, vacantsNotifier, child) {
        vacantsNotifier.getVacant(widget.id);
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppBar(actions: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: const Icon(Fontisto.bookmark_alt),
                  ),
                )
              ], child: const BackBtn())),
          body: buildStyleContainer(
            context,
            FutureBuilder<GetVacantRes>(
                future: vacantsNotifier.vacant,
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
                            children: [],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20.0.w),
                              child: CustomOutlineBtn(
                                text: "Iniciar sesión",
                                height: height * 0.06,
                                color: Color(kLight.value),
                                color2: Color(kVerde.value),
                              ),
                            ),
                          ),
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
