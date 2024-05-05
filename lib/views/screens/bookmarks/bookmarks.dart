import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:jobhubv2_0/views/screens/auth/non_user.dart';
import 'package:provider/provider.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
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
                  text: "Favoritos",
                  style: appStyle(30, Color(kDark.value), FontWeight.bold),
                ),
              ));
  }
}
