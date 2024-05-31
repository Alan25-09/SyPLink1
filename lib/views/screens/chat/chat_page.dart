import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/agents_provider.dart';
import 'package:jobhubv2_0/services/firebase_services.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/width_spacer.dart';
import 'package:jobhubv2_0/views/screens/auth/profile_page.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FirebaseServices services = FirebaseServices();
  TextEditingController messageController = TextEditingController();
  final FocusNode messageFocusNode = FocusNode();
  String imageUrl =
      "https://img.freepik.com/vector-premium/perfil-avatar-hombre-icono-redondo_24640-14044.jpg";

  sendMessage() {
    var chat = Provider.of<AgentNotifier>(context, listen: false).chat;
    Map<String, dynamic> message = {
      'message': messageController.text,
      'messageType': 'text',
      'profile': profile,
      'sender': userUid,
      'time': Timestamp.now()
    };
    services.createChat(chat['chatRoomId'], message);
    messageController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    String chatRoomId =
        Provider.of<AgentNotifier>(context, listen: false).chat['chatRoomId'];
    final Stream<QuerySnapshot> _typingStatus = FirebaseFirestore.instance
        .collection('typing')
        .doc(chatRoomId)
        .collection('typing')
        .snapshots();

    return Scaffold(
      backgroundColor: Color(kLight.value),
      appBar: AppBar(
        backgroundColor: Color(kLight.value),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(12.w),
          child: const BackBtn(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: _typingStatus,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox.shrink();
                        } else if (snapshot.data!.docs.isEmpty) {
                          return const Text('');
                        }
                        List<String> documentIds =
                            snapshot.data!.docs.map((doc) => doc.id).toList();
                        return ReusableText(
                            text: documentIds.isNotEmpty &&
                                    !documentIds.contains(userUid)
                                ? 'Escribiendo...'
                                : '',
                            style: appStyle(
                                9, Color(kDarkGris.value), FontWeight.normal));
                      },
                    ),
                    ReusableText(
                        text: 'En línea',
                        style: appStyle(
                            9, Color(kVerde.value), FontWeight.normal)),
                  ],
                ),
                Stack(
                  children: [
                    CircularPicture(image: imageUrl, w: 30, h: 30),
                    Positioned(
                        child: CircleAvatar(
                      backgroundColor: Color(kVerde.value),
                      radius: 4,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0.h,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 20.w, top: 10.w),
                width: width,
                height: 100.h,
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
                        var vacantDetails = agentNotifier.chat['vacant'];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                          text: vacantDetails['title'],
                                          style: appStyle(
                                              12,
                                              Color(kLight.value),
                                              FontWeight.w600)),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Container(
                                      height: 60.w,
                                      width: 1.w,
                                      color: Color(kLight.value),
                                    ),
                                  ),
                                ],
                              ),
                              const WidthSpacer(width: 20),
                              CircularPicture(
                                  image: vacantDetails['imageUrl'],
                                  w: 50,
                                  h: 50)
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
