import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/screens/auth/non_user.dart';
import 'package:provider/provider.dart';

class AppliedVacants extends StatefulWidget {
  const AppliedVacants({super.key});

  @override
  State<AppliedVacants> createState() => _AppliedVacantsState();
}

class _AppliedVacantsState extends State<AppliedVacants> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: DrawerWidget(color: Color(kDark.value)),
            ),
          ),
        ),
        body: loginNotifier.loggedIn == false
            ? const NonUser()
            : Center(
                child: ReusableText(
                  text: "Postulaciones",
                  style: appStyle(30, Color(kDark.value), FontWeight.bold),
                ),
              ));
  }
}
