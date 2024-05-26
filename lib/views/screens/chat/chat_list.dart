import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/agents_provider.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jobhubv2_0/views/screens/auth/non_user.dart';
import 'package:jobhubv2_0/views/screens/auth/profile_page.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
        //backgroundColor: Color(kVerde.value),
        appBar: AppBar(
          backgroundColor: Color(kLight.value),
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(12.w),
            child: DrawerWidget(
              color: Color(kDark.value),
            ),
          ),
          title: loginNotifier.loggedIn == false
              ? const SizedBox.shrink()
              : TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                      color: Color(kLight.value),
                      borderRadius: BorderRadius.all(Radius.circular(25.w))),
                  labelColor: Color(kDark.value),
                  unselectedLabelColor: Color(kDarkGrey.value),
                  padding: EdgeInsets.all(3.w),
                  labelStyle:
                      appStyle(14, Color(kLight.value), FontWeight.w500),
                  tabs: const [
                      Tab(
                        text: "Mensajes",
                      ),
                      Tab(
                        text: "Online",
                      ),
                      Tab(
                        text: "Grupos",
                      )
                    ]),
        ),
        body: loginNotifier.loggedIn == false
            ? const NonUser()
            : TabBarView(controller: tabController, children: [
                Stack(
                  children: [
                    Positioned(
                        top: 20,
                        right: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15.w, left: 25.w, right: 0.w),
                          height: 220.h,
                          decoration: BoxDecoration(
                              color: Color(kVerde.value),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.w),
                                topRight: Radius.circular(20.w),
                              )),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(
                                      text: "Prestatarios",
                                      style: appStyle(14, Color(kLight.value),
                                          FontWeight.normal)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(AntDesign.ellipsis1,
                                          color: Color(kLight.value)))
                                ],
                              ),
                              Consumer<AgentNotifier>(
                                  builder: (context, agentNotifier, child) {
                                var agents = agentNotifier.getAgents();
                                return Container();
                              })
                            ],
                          ),
                        )),
                    Positioned(
                        top: 180.h,
                        right: 0,
                        left: 0,
                        child: Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                              color: Color(kLight.value),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.w),
                                topRight: Radius.circular(20.w),
                              )),
                        ))
                  ],
                ),
                Container(
                  height: height,
                  width: width,
                  color: Colors.green,
                ),
                Container(
                  height: height,
                  width: width,
                  color: Colors.blue,
                ),
              ]));
  }
}
