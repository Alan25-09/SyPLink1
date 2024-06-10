import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syplink/controllers/agents_provider.dart';
import 'package:syplink/views/common/BackBtn.dart';
import 'package:syplink/views/common/exports.dart';
import 'package:syplink/views/common/styled_container.dart';
import 'package:syplink/views/common/width_spacer.dart';
import 'package:syplink/views/screens/agent/agent_vacants.dart';
import 'package:syplink/views/screens/auth/profile_page.dart';
import 'package:provider/provider.dart';

class AgentDetails extends StatelessWidget {
  const AgentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kLight.value),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(12.w),
          child: const BackBtn(),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(left: 12.w, right: 12.w),
              height: 160.h,
              decoration: BoxDecoration(
                color: Color(kVerde.value),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.w),
                  topRight: Radius.circular(20.w),
                ),
              ),
              child: Column(
                children: [
                  Consumer<AgentNotifier>(
                      builder: (context, agentNotifier, child) {
                    var agent = agentNotifier.agent;
                    return Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(
                                      text: agent!.username,
                                      style: appStyle(12, Color(kLight.value),
                                          FontWeight.w500)),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Container(
                                  height: 60.w,
                                  width: 1.w,
                                  color: Color(kLight.value),
                                ),
                              ),
                            ],
                          ),
                          const WidthSpacer(width: 20),
                          CircularPicture(image: agent.profile, w: 50, h: 50)
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          Positioned(
            top: 80.h,
            right: 0,
            left: 0,
            child: Container(
              width: width,
              height: height * 0.8,
              decoration: BoxDecoration(
                color: Color(kLight.value),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.w),
                  topRight: Radius.circular(20.w),
                ),
              ),
              child: buildStyleContainer(context, const AgentVacants()),
            ),
          )
        ],
      ),
    );
  }
}
