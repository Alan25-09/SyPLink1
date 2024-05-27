import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/agents_provider.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/models/request/agents/agents.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jobhubv2_0/views/screens/agent/agent_details.dart';
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
  String imageUrl =
      "https://img.freepik.com/vector-premium/perfil-avatar-hombre-icono-redondo_24640-14044.jpg";
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
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 5.w, left: 25.w, right: 0.w),
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
                                return FutureBuilder<List<Agents>>(
                                    future: agents,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return SizedBox(
                                            height: 90.h,
                                            child: ListView.builder(
                                                itemCount: 7,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {},
                                                    child: buildAgentAvatar(
                                                      "Agente $index",
                                                      imageUrl,
                                                    ),
                                                  );
                                                }));
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return SizedBox(
                                          height: 90.h,
                                          child: ListView.builder(
                                              itemCount: snapshot.data!.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                var agent =
                                                    snapshot.data![index];
                                                return GestureDetector(
                                                  onTap: () {
                                                    agentNotifier.agent = agent;
                                                    Get.to(() =>
                                                        const AgentDetails());
                                                  },
                                                  child: buildAgentAvatar(
                                                    agent.username,
                                                    agent.profile,
                                                  ),
                                                );
                                              }),
                                        );
                                      }
                                    });
                              })
                            ],
                          ),
                        )),
                    Positioned(
                        top: 140.h,
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

Padding buildAgentAvatar(String name, String filename) {
  return Padding(
    padding: EdgeInsets.only(right: 20.w),
    child: Column(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(99.w)),
                border: Border.all(width: 1, color: Color(kLight.value))),
            child: CircularPicture(image: filename, w: 50, h: 50)),
        const HeightSpacer(size: 5),
        ReusableText(
            text: name,
            style: appStyle(11, Color(kLight.value), FontWeight.normal))
      ],
    ),
  );
}
