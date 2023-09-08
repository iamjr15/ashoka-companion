import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/auth/controller/auth_controller.dart';
import 'package:gojek_university_app/features/auth/data/auth_apis/auth_apis.dart';
import 'package:gojek_university_app/features/blind_chat/chat/data/apis/chat_repository.dart';
import 'package:gojek_university_app/models/user_model.dart';

// Provider definition for ChatController
final chatControllerProvider = Provider((ref) {
  // Get the ChatRepository instance from the Provider
  final chatRepository = ref.watch(ChatRepositoryProvider);
  // Create and return a ChatController instance with injected dependencies
  return ChatController(chatRepository: chatRepository, ref: ref, authApis:  ref.watch(authApisProvider), );
});


// Controller class responsible for managing chat-related functionalities
class ChatController {
  final ChatRepository chatRepository; // Repository for chat-related operations
  final AuthApis authApis; // Authentication APIs for user-related operations
  final ProviderRef ref; // Reference to the current Provider context

  // Constructor to inject dependencies
  ChatController({required this.authApis, required this.chatRepository, required this.ref});

  // Function to send a text message
  void sendTextMessage(
    BuildContext context,
    String text,
    String receiverUserId,
      UserModel userModel,
  ) {
    // Delegate the task of sending a text message to the ChatRepository
    chatRepository.sendTextMessage(
      context: context,
      text: text,
      receiverUserId: receiverUserId,
      senderUser: userModel,
    );

    //Error due to userModelData Error
    // ref.read(currentUserModelData).whenData(
    //   (value) {
    //     chatRepository.sendTextMessage(
    //       context: context,
    //       text: text,
    //       receiverUserId: receiverUserId,
    //       senderUser: value,
    //     );
    //   },
    // );
  }

  // Function to retrieve chat contacts as a stream
  Stream<List<UserModel>> chatContacts() {
    // Get a stream of chat contacts from the ChatRepository
    return chatRepository.getChatContact();
  }

  // Function to mark a chat message as seen
  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) {
    // Delegate the task of setting the chat message as seen to the ChatRepository
    chatRepository.setChatMessageSeen(context, recieverUserId, messageId);
  }

  // Function to delete chat for a specified user
  Future<void> deleteChat({required String userId}) async {
    // Delete chat for the specified user using ChatRepository
    final result =
    await chatRepository.deleteChatForOtherUser(receiverUserId: userId);
    result.fold((l) {}, (r) {});

    // Delete chat for the user himself/herself
    final result2 =
    await chatRepository.deleteChatForUserMyself(receiverUserId:userId);
    result.fold((l) {}, (r) {});
  }

  // Function to delete chat for myself (current user)
  Future<void>  deleteChatForMyself({required String userId}) async {
    // Delete chat for the current user using ChatRepository
    final result =
    await chatRepository.deleteChatForUserMyself(receiverUserId:userId);
    result.fold((l) {}, (r) {});
  }
}


