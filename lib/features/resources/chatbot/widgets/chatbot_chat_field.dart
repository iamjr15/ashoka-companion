import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gojek_university_app/features/resources/chatbot/controller/chat_bot_send_controller.dart';
import 'package:gojek_university_app/features/resources/chatbot/data/model/chat_model.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/thems/my_colors.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';

import '../controller/chat_bot_controller.dart';

class ChatBotChatField extends ConsumerStatefulWidget {
  const ChatBotChatField({
    required this.scroll,
    Key? key,
  }) : super(key: key);
  final Function() scroll;

  @override
  ConsumerState<ChatBotChatField> createState() => _BottomChatFieldState();
}

// State class for the BottomChatField widget
class _BottomChatFieldState extends ConsumerState<ChatBotChatField> {
  final TextEditingController _messageController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // Function to send a text message
  void sendTextMessage() async {
    if (_messageController.text == '') {
      return;
    }
    await sendMessageFCT();
    setState(() {
      _messageController.text = '';
    });
  }

  Future<void> sendMessageFCT() async {
    final chatBotCTrPdr = ref.read(chatBotControllerProvider);
    chatBotCTrPdr.addUserMessage(msg: _messageController.text);
    focusNode.unfocus();
    widget.scroll();
    final chatBotSendController =
        ref.read(chatBotSendControllerProvider.notifier);
    List<ChatModel> models = await chatBotSendController.sendMessageAndGetAns(
        msg: _messageController.text,
        chosenModelID: 'text-davinci-003',
        context: context);

    await chatBotCTrPdr.updateChatList(models: models);
    setState(() {
      _messageController.clear();
    });
    widget.scroll();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, right: 10.w, left: 10.w),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 54.h,
              child: TextFormField(
                focusNode: focusNode,
                controller: _messageController,
                onChanged: (val) {},
                onFieldSubmitted: (val){
                  sendTextMessage();
                },
                style: getRegularStyle(
                    fontSize: MyFonts.size13,
                    color: MyColors.black,
                    isMontserrat: true),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyColors.chatBotTextFieldBg,
                  hintStyle: getRegularStyle(
                      fontSize: MyFonts.size13,
                      color: MyColors.black.withOpacity(0.7),
                      isMontserrat: true),
                  hintText: 'enter message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.r),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 22.h, horizontal: 20.w),
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: sendTextMessage,
                  icon: Image.asset(
                    AppAssets.sendChatBotIcon,
                    width: 30.w,
                    height: 30.w,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
