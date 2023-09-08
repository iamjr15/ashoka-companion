import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/commons/common_widgets/padding.dart';
import 'package:gojek_university_app/features/resources/chatbot/controller/chat_bot_send_controller.dart';
import 'package:gojek_university_app/features/resources/chatbot/data/model/chat_model.dart';
import 'package:gojek_university_app/features/resources/chatbot/widgets/chat_bot_appbar.dart';
import 'package:gojek_university_app/features/resources/chatbot/widgets/chatbot_chat_field.dart';
import 'package:gojek_university_app/features/resources/chatbot/widgets/my_message_card.dart';
import 'package:gojek_university_app/features/resources/chatbot/widgets/sender_message_card.dart';
import '../controller/chat_bot_controller.dart';

class ResourceChatBotScreen extends ConsumerStatefulWidget {
  const ResourceChatBotScreen({super.key});

  @override
  ConsumerState<ResourceChatBotScreen> createState() =>
      _ResourceChatBotScreenState();
}

class _ResourceChatBotScreenState extends ConsumerState<ResourceChatBotScreen> {
  late ScrollController _listScrollController;
  late TextEditingController textEditingController;
  late FocusNode focusNode;

  @override
  void initState() {
    textEditingController = TextEditingController();
    _listScrollController = ScrollController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = ref.watch(chatBotControllerProvider);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          children: [
            SizedBox(
              height: 53.h,
            ),
            ChatBotAppBar(
              verticalPadding: 10.h,
              onBackTap: () {
                Navigator.pop(context);
              },
            ),
            Flexible(
              child: ListView.builder(
                  controller: _listScrollController,
                  // physics: const BouncingScrollPhysics(),
                  itemCount: chatProvider.chatList.length, //chatList.length,
                  itemBuilder: (context, index) {
                    return chatProvider.chatList[index].chatIndex == 0
                        ? MyMessageCard(
                            message: chatProvider.chatList[index].msg)
                        : SenderMessageCard(
                            animate: false,
                            // index == chatProvider.chatList.length - 1 ? true : false,
                            message: chatProvider.chatList[index].msg,
                          );
                  }),
            ),
            padding4,
            if (ref.watch(chatBotSendControllerProvider)) ...[
              SpinKitThreeBounce(
                color: MyColors.newPinkColor,
                size: 18.h,
              ),
              padding12,
            ],
            ChatBotChatField(
              scroll: scrollListToEnd,
            )
          ],
        ),
      ),
    );
  }

  void scrollListToEnd() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent + 500,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }
}
