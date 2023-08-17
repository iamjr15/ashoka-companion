import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_functions/email_format_check_func.dart';
import 'package:gojek_university_app/commons/common_widgets/show_toast.dart';
import 'package:gojek_university_app/features/auth/data/auth_apis/auth_apis.dart';
import 'package:gojek_university_app/features/auth/data/auth_apis/database_apis.dart';
import 'package:gojek_university_app/features/blind_chat/chat/controller/chat_controller.dart';
import 'package:gojek_university_app/features/resources/chatbot/controller/chat_bot_controller.dart';
import 'package:gojek_university_app/features/resources/chatbot/data/api/ApiService.dart';
import 'package:gojek_university_app/models/staff_model.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/model/chat_model.dart';

final chatBotSendControllerProvider =
    StateNotifierProvider<ChatBotSendController, bool>((ref) {
  return ChatBotSendController(
    chatBotApiService: ref.watch(chatBotApiServiceProvider),
  );
});

class ChatBotSendController extends StateNotifier<bool> {
  final ChatBotApiService _chatBotApiService;

  ChatBotSendController({
    required ChatBotApiService chatBotApiService,
  })  : _chatBotApiService = chatBotApiService,
        super(false);

  Future<List<ChatModel>> sendMessageAndGetAns({
    required String msg,
    required String chosenModelID,
    required BuildContext context,
  }) async {
    List<ChatModel> response=[];
    state = true;
    // final result = await _chatBotApiService.sendMessageGPT(
    //     message: msg, modelId: chosenModelID);
    final result =await _chatBotApiService.sendMessageSonic(
        message: msg,);
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      state = false;
      showAwesomeSnackBar(
          context: context,
          title: 'Oh No!',
          msg: 'Server Error Occurred! Need your patience!',
          type: ContentType.failure);
    }, (r) async {
      state = false;
      response=r;
    });
    return response;
  }
}
