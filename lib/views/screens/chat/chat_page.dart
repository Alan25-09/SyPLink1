import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syplink/constants/app_constants.dart';
import 'package:syplink/controllers/agents_provider.dart';
import 'package:syplink/services/firebase_services.dart';
import 'package:syplink/utils/date.dart';
import 'package:syplink/views/common/BackBtn.dart';
import 'package:syplink/views/common/app_style.dart';
import 'package:syplink/views/common/reusable_text.dart';
import 'package:syplink/views/common/width_spacer.dart';
import 'package:syplink/views/screens/auth/profile_page.dart';
import 'package:syplink/views/screens/chat/widgets/chat_left_item.dart';
import 'package:syplink/views/screens/chat/widgets/chat_right_item.dart';
import 'package:syplink/views/screens/chat/widgets/messagingT_field.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FirebaseServices services = FirebaseServices();
  TextEditingController messageController = TextEditingController();
  final itemController = ItemScrollController();
  final FocusNode messageFocusNode = FocusNode();
  var uuid = Uuid();
  String imageUrl =
      "https://img.freepik.com/vector-premium/perfil-avatar-hombre-icono-redondo_24640-14044.jpg";

  sendMessage() {
    var chat = Provider.of<AgentNotifier>(context, listen: false).chat;
    // Asegúrate de definir userUid
    String profile = chat['profile']; // Asegúrate de definir profile

    Map<String, dynamic> message = {
      'message': messageController.text,
      'messageType': 'text',
      'profile': profile,
      'sender': userUid,
      'id': uuid.v4(),
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

    final Stream<QuerySnapshot> _chats = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('time')
        .snapshots();

    final Stream<QuerySnapshot> _userStatus = FirebaseFirestore.instance
        .collection('status')
        .doc(userUid)
        .collection('status')
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
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(left: 5.w, right: 20.w, top: 10.w),
              decoration: BoxDecoration(
                color: Color(kVerde.value),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.w),
                  topRight: Radius.circular(20.w),
                ),
              ),
              child: Consumer<AgentNotifier>(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: vacantDetails['title'],
                                  style: appStyle(
                                    12,
                                    Color(kLight.value),
                                    FontWeight.w600,
                                  ),
                                ),
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
                        CircularPicture(
                          image: vacantDetails['imageUrl'],
                          w: 50,
                          h: 50,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(kGris.value),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w),
                  ),
                ),
                child: StreamBuilder(
                  stream: _chats,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error ${snapshot.error}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    int msgCount = snapshot.data!.docs.length;
                    return SingleChildScrollView(
                      reverse: true,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom > 0
                            ? 16.0
                            : 0.0,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.6, // Ajusta la altura según tu diseño
                            child: ScrollablePositionedList.builder(
                              itemCount: msgCount,
                              initialScrollIndex:
                                  msgCount - 1, // Scrollear hasta el final
                              itemScrollController: itemController,
                              itemBuilder: (context, index) {
                                var message = snapshot.data!.docs[index];

                                Timestamp lastChatTime = message['time'];
                                DateTime chatTime = lastChatTime.toDate();

                                return Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Column(
                                    children: [
                                      Text(
                                        duTimeLineFormat(chatTime),
                                        style: appStyle(
                                            10, Colors.grey, FontWeight.normal),
                                      ),
                                      message['sender'] == userUid
                                          ? chatRightItem(
                                              message['messageType'],
                                              message['message'],
                                              message['profile'],
                                            )
                                          : chatLeftItem(
                                              message['messageType'],
                                              message['message'],
                                              message['profile'],
                                            ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                  maxHeight:
                      200), // Establece una altura máxima para el MessagingField
              child: MessagingField(
                sendText: () {
                  sendMessage();
                },
                messageController: messageController,
                messageFocusNode: messageFocusNode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
