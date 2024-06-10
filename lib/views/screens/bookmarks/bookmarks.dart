import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/controllers/bookmark_provider.dart';
import 'package:syplink/controllers/login_provider.dart';
import 'package:syplink/models/response/bookmarks/all_bookmarks.dart';
import 'package:syplink/views/common/pages_loader.dart';
import 'package:syplink/views/common/app_bar.dart';
import 'package:syplink/views/common/drawer/drawer_widget.dart';
import 'package:syplink/views/common/styled_container.dart';
import 'package:syplink/views/screens/auth/non_user.dart';
import 'package:syplink/views/screens/bookmarks/widgets/bookmark_tile.dart';
import 'package:provider/provider.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: !loginNotifier.loggedIn ? "" : "Favoritos",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(color: Color(kDark.value)),
          ),
        ),
      ),
      body: loginNotifier.loggedIn == false
          ? const NonUser()
          : Consumer<BookNotifier>(
              builder: (context, bookNotifier, child) {
                bookNotifier.getBookMarks();
                var bookmarks = bookNotifier.getBookMarks();
                return Stack(
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
                                child: FutureBuilder<List<AllBookMarks>>(
                                    future: bookmarks,
                                    builder: ((context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const PageLoader();
                                      } else if (snapshot.hasError) {
                                        return Text("Error: ${snapshot.error}");
                                      } else {
                                        var processedBooks = snapshot.data;
                                        return ListView.builder(
                                            itemCount: processedBooks!.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              final bookmark =
                                                  processedBooks[index];
                                              return BookMarkTile(
                                                  bookmark: bookmark);
                                            });
                                      }
                                    })),
                              )),
                        ))
                  ],
                );
              },
            ),
    );
  }
}
