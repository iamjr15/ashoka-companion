import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/features/blind_chat/chat/controller/chat_controller.dart';
import 'package:gojek_university_app/features/blind_chat/chat/controller/chat_screen_controller.dart';
import 'package:gojek_university_app/features/blind_chat/chat/data/models/message.dart';
import 'package:gojek_university_app/features/blind_chat/chat/widgets/sender_message_card.dart';
import 'package:gojek_university_app/utils/loading.dart';
import 'package:intl/intl.dart';
import 'my_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverUserId;
  const ChatList({required this.receiverUserId, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController _messageController = ScrollController();
  int totalMsg=0;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    return ref.watch(fetchChatsStreamByIdProvider(widget.receiverUserId)).when(
        data: (chats) {

          //Scroll down when new msg arrives
          if(totalMsg!=chats.length){
            SchedulerBinding.instance.addPostFrameCallback((_) {
              _messageController
                  .jumpTo(_messageController.position.maxScrollExtent);
            });
            totalMsg=chats.length;
            setState(() {
            });
          }

          return ListView.builder(
            padding: EdgeInsets.only(bottom: 10.h),
            physics:const BouncingScrollPhysics(),
            controller: _messageController,
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final messageData = chats[index];
              var timeSent = DateFormat.Hm().format(messageData.timeSent);

              // to set message seen if receiver sees the msg.
              if (!messageData.isSeen &&
                  messageData.receiverId ==
                      FirebaseAuth.instance.currentUser!.uid) {
                ref.read(chatControllerProvider).setChatMessageSeen(
                    context, widget.receiverUserId, messageData.messageId);
              }

              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  date: timeSent,
                  type: messageData.type,
                  isSeen: messageData.isSeen,
                );
              }
              return SenderMessageCard(
                message: messageData.text,
                date: timeSent,
                type: messageData.type,
              );
            },
          );
        },
        error: (error, st) => const SizedBox(
          child: Text('error'),
        ),
        loading: () => const LoadingWidget());
  }
}