import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/resources/chatbot/data/api/ApiService.dart';
import 'package:gojek_university_app/features/resources/chatbot/data/model/chat_model.dart';

final chatBotControllerProvider =
    ChangeNotifierProvider((ref) => ChatBotController());

class ChatBotController extends ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg,int chatIndex=0}) {
    chatList.add(ChatModel(msg: msg, chatIndex: chatIndex));
    notifyListeners();
  }


  Future<void> updateChatList(
      { required List<ChatModel> models}) async {
    chatList.addAll(models);
    notifyListeners();
  }


  void clearChatList() {
    chatList = [];
    notifyListeners();
  }
}
