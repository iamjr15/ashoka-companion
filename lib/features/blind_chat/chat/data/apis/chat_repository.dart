import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_providers/common_firebse_storage.dart';
import 'package:gojek_university_app/commons/common_widgets/show_toast.dart';
import 'package:gojek_university_app/commons/enums/message_enum.dart';
import 'package:gojek_university_app/core/constants/firebase_constants.dart';
import 'package:gojek_university_app/core/type_defs.dart';
import 'package:gojek_university_app/features/blind_chat/chat/data/models/chat_contact.dart';
import 'package:gojek_university_app/features/blind_chat/chat/data/models/message.dart';
import 'package:uuid/uuid.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../models/user_model.dart';

// Define a provider for ChatRepository with required dependencies
final ChatRepositoryProvider = Provider((ref) => ChatRepository(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

// Class representing the ChatRepository
class ChatRepository {
  final FirebaseFirestore firestore; // Firestore instance for database operations
  final FirebaseAuth auth; // FirebaseAuth instance for authentication

  // Constructor to inject dependencies
  ChatRepository({required this.firestore, required this.auth});

  // Function to get a stream of messages for a chat
  Stream<List<Message>> getChatStream(String receiverUserId) {
    List<Message> messages = [];
    try{
      // Retrieve a stream of messages from Firestore
      return firestore
          .collection(FirebaseConstants.userCollection)
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(receiverUserId)
          .collection('messages')
          .orderBy('timeSent')
          .snapshots()
          .map((event) {
            messages = [];
        for (var document in event.docs) {
          messages.add(Message.fromMap(document.data()));
        }
        return messages;
      });
    }catch(e){
      print(e.toString());
      return Stream.error('Error fetching chat stream: $e');
    }
  }

  // Function to get the current user
  @override
  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  // Function to delete chat for the current user
  FutureEitherVoid deleteChatForUserMyself({required String receiverUserId}) async {
    try {
      // Delete messages collection for the specified chat
      var messagesCollectionRef = FirebaseFirestore.instance
          .collection(FirebaseConstants.userCollection)
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(receiverUserId)
          .collection('messages');

      var messagesQuerySnapshot = await messagesCollectionRef.get();
      for (var messageSnapshot in messagesQuerySnapshot.docs) {
        await messageSnapshot.reference.delete();
      }
      // Delete the chat document itself
      await firestore
          .collection(FirebaseConstants.userCollection)
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(receiverUserId).delete();
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  FutureEitherVoid deleteChatForOtherUser({required String receiverUserId}) async {
    try {
      var messagesCollectionRef = FirebaseFirestore.instance
          .collection(FirebaseConstants.userCollection)
          .doc(receiverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages');

      var messagesQuerySnapshot = await messagesCollectionRef.get();
      for (var messageSnapshot in messagesQuerySnapshot.docs) {
        await messageSnapshot.reference.delete();
      }
      await firestore
          .collection(FirebaseConstants.userCollection)
          .doc(receiverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid).delete();
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }



  // Function to get a stream of user contacts for chat
  Stream<List<UserModel>> getChatContact() {
    return firestore
        .collection(FirebaseConstants.userCollection).where('uid',isNotEqualTo: auth.currentUser!.uid)
        .snapshots()
        .asyncMap((event) async {
      List<UserModel> contacts = [];
      for (var document in event.docs) {
        var user = UserModel.fromMap(document.data());
        contacts.add(user);
      }
      return contacts;
    });
  }



  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel? receiverUserData,
    String text,
    DateTime timeSent,
    String receiverUserId,
  ) async {
    //users => receiver id => chats => curr user id => set data

      var receiverChatContact = ChatContact(
        name: senderUserData.name!,
        profilePic: senderUserData.profileImage!,
        contactId: senderUserData.uid!,
        timeSent: timeSent,
        lastMessage: text,
      );
      await firestore
          .collection(FirebaseConstants.userCollection)
          .doc(receiverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .set(receiverChatContact.toMap());

      //users =>  curr user id=> chats  =>receiver id => set data
      var senderChatContact = ChatContact(
        name: receiverUserData!.name!,
        profilePic: receiverUserData.profileImage!,
        contactId: receiverUserData.uid!,
        timeSent: timeSent,
        lastMessage: text,
      );
      await firestore
          .collection(FirebaseConstants.userCollection)
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(receiverUserId)
          .set(senderChatContact.toMap());
  }

  void _saveMessageToMessageSubcollection(
      {required String receiverUserId,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required String username,
      required MessageEnum messageType,
      required String senderUsername,
      required String? recieverUsername,}) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      receiverId: receiverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );

      //user => sender Id => receiver id -> messages -> message id -> store message
      firestore
          .collection(FirebaseConstants.userCollection)
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(receiverUserId)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap());
      //user =>receiver id -> sender Id =>  messages -> message id -> store message
      firestore
          .collection(FirebaseConstants.userCollection)
          .doc(receiverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap());
  }

  // Function to send a text message
  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
    required UserModel senderUser,
  }) async {
    try {
      // Record the time of sending
      var timeSent = DateTime.now();
      UserModel? receiverUserData;

      // Retrieve receiver's user data from Firestore
        var userDataMap =
            await firestore.collection(FirebaseConstants.userCollection).doc(receiverUserId).get();
        receiverUserData = UserModel.fromMap(userDataMap.data()!);

      //users => receiver id => chats => curr user id => set
      // Save the chat and messages data
      _saveDataToContactsSubcollection(
        senderUser,
        receiverUserData,
        text,
        timeSent,
        receiverUserId,
      );

      var messageId = const Uuid().v1();
      _saveMessageToMessageSubcollection(
        receiverUserId: receiverUserId,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUser.name!,
        messageType: MessageEnum.text,
        senderUsername: senderUser.name!,
        recieverUsername: receiverUserData?.name!,
      );
    } catch (e) {
      print(e);
      showSnackBar( context,  e.toString());
    }
  }




// Function to mark a chat message as seen
  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) async {
    try {
      // Update the isSeen status for the specified message
      //user => sender Id => receiver id -> messages -> message id -> store message
      firestore
          .collection(FirebaseConstants.userCollection)
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});
      //user =>receiver id -> sender Id =>  messages -> message id -> store message
      firestore
          .collection(FirebaseConstants.userCollection)
          .doc(recieverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});
    } catch (e) {
      showSnackBar(context,  e.toString());
    }
  }
}

