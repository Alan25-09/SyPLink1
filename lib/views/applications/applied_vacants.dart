import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/views/common/app_style.dart';
import 'package:syplink/views/common/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syplink/controllers/login_provider.dart';
import 'package:syplink/models/response/applied/applied.dart';
import 'package:syplink/services/helpers/applied_helper.dart';
import 'package:syplink/views/applications/widgets/applied_tile.dart';
import 'package:syplink/views/common/app_bar.dart';
import 'package:syplink/views/common/drawer/drawer_widget.dart';
import 'package:syplink/views/common/pages_loader.dart';
import 'package:syplink/views/common/styled_container.dart';
import 'package:syplink/views/screens/auth/non_user.dart';
import 'package:provider/provider.dart';

class AppliedVacants extends StatelessWidget {
  const AppliedVacants({super.key});

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: !loginNotifier.loggedIn ? "" : 'Postulaciones',
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: DrawerWidget(color: Color(kDark.value)),
            ),
          ),
        ),
        body: loginNotifier.loggedIn == false
            ? const NonUser()
            : Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.w),
                                topLeft: Radius.circular(20.w)),
                            color: Color(kLight.value)),
                        child: buildStyleContainer(
                            context,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: FutureBuilder<List<Applied>>(
                                future: AppliedHelper.getApplied(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const PageLoader();
                                  } else if (snapshot.hasError) {
                                    return Text("Error: ${snapshot.error}");
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Center(
                                      child: ReusableText(
                                          text: 'Lista de postulaciones vacía.',
                                          style: appStyle(
                                              16,
                                              Color(kDarkGris.value),
                                              FontWeight.normal)),
                                    );
                                  } else {
                                    var vacants = snapshot.data;
                                    return ListView.builder(
                                      itemCount: vacants!.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        final vacant = vacants[index].vacant;
                                        return AppliedTile(vacant: vacant);
                                      },
                                    );
                                  }
                                },
                              ),
                            )),
                      ))
                ],
              ));
  }
}
