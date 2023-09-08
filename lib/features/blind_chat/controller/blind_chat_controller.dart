import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_functions/email_format_check_func.dart';
import 'package:gojek_university_app/commons/common_widgets/show_toast.dart';
import 'package:gojek_university_app/features/auth/data/auth_apis/auth_apis.dart';
import 'package:gojek_university_app/features/auth/data/auth_apis/database_apis.dart';
import 'package:gojek_university_app/features/blind_chat/data/blind_chat_apis/blind_chat_apis.dart';
import 'package:gojek_university_app/models/staff_model.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../models/user_model.dart';

final blindChatControllerProvider =
    StateNotifierProvider<BlindChatController, bool>((ref) {
  return BlindChatController(
   blindChatApis: ref.watch(blindChatApisProvider),
  );
});


final fetchUserByIdProvider = StreamProvider.family((ref, String uid) {
  final blindChatCtr = ref.watch(blindChatControllerProvider.notifier);
  return blindChatCtr.getUserInfoByUid(uid);
});


final fetchAvailableUsersCount = StreamProvider((ref,) {
  final blindChatCtr = ref.watch(blindChatControllerProvider.notifier);
  return blindChatCtr.listenToOnlineUsersCount();
});

final fetchOnlineUsersCount = StreamProvider((ref,) {
  final blindChatCtr = ref.watch(blindChatControllerProvider.notifier);
  return blindChatCtr.listenToOnlineUsersCount();
});
// final currUserAuthProvider = Provider((ref) {
//   final blindChatCtr= ref.watch(authControllerProvider.notifier);
//   return blindChatCtr.currUser();
// });


// This Controller will handle all the business logic for blind section
// It handle the field in User model related to blind chat matching, leaving chat , chat with someone else,


class BlindChatController extends StateNotifier<bool> {
  final BlindChatApis _blindChatApis;

  BlindChatController(
      { required BlindChatApis blindChatApis})
      :_blindChatApis = blindChatApis,
        super(false);


  // This function is used to listen to user that are online in the app
  // These online users will be shown on blindChat home screen
  Stream<int> listenToOnlineUsersCount() {
    try {
      return  _blindChatApis.listenToOnlineUsersCount();
    } catch (e) {
      debugPrint('Error listening to online users count: $e');
      return Stream.value(0); // Return a stream with a default value in case of an error
    }
  }

  // It will get the number on user that are ready to match with pal
  // This function will be called when enter the friend searching screen
  Future<int> getAvailableUsersCount() {
    try {
      return  _blindChatApis.getAvailableUsersCount();
    } catch (e) {
      debugPrint('Error getting the available users count: $e');
      return Future.value(0); // Return a Future with a default value in case of an error
    }
  }


  // It will get all the user that have status available
  // Means they are ready to match
  // it is called in friend matching screen
  Future<List<UserModel>> getFirstAvailableUserForChat() async {
    var users = await _blindChatApis.getFirstAvailableUserForChat();
    List<UserModel> userModels = [];
    for (var user in users.docs) {
      userModels.add(UserModel.fromMap(user.data()));
    }
    return userModels;
  }


  // It will continuously listen to a user from firestore based on his UID
  Stream<UserModel> getUserInfoByUid(String userId) {
    return _blindChatApis.getUserInfoByUid(userId);
  }



  // It will the current user status to true or false based on the value provided.
  Future<void> setMyAvailableState({required bool isAvailable}) async {
    final result =
    await _blindChatApis.setMyAvailableState(isAvailable: isAvailable);

    result.fold(
            (l) {
              debugPrintStack(
                stackTrace: l.stackTrace,
              );
              debugPrint(
                'Hola error!'
              );
            },
            (r){
              debugPrint(
                'Success! ',
              );
            });

  }


  // It will set the matched_user field to each other id when match is done.
  // Also it will make sure their available status will be set to false
  Future<void> setMatchedUserIdForBoth({required UserModel otherUserModel,required UserModel myUserModel,required BuildContext context}) async {
    state = true;
    myUserModel=myUserModel.copyWith(matcheduser: otherUserModel.uid);
    otherUserModel=otherUserModel.copyWith(matcheduser: myUserModel.uid);
    final result = await _blindChatApis.setMatchedUserIdForBoth(
        myUserModel: myUserModel, otherUserModel: otherUserModel);
    result.fold((l) {
      state = false;
      debugPrint(l.message);
      // showToast(msg: l.message);
    }, (r) {
      state = false;
      // showToast(msg: 'matched Id updated success');
    });
  }


  // when the chat ends match user id will be set to empty
  // Also it will make sure their available status will be set to false
  Future<void> resetMatchedUserIdForBoth({required String otherUserId}) async {
    state = true;
    final result = await _blindChatApis.resetMatchedUserIdForBoth(otherUserId: otherUserId);
    final result2 = await _blindChatApis.resetMatchedUserIdForMyself();
    result.fold((l) {
      state = false;
      debugPrint(l.message);
      // showToast(msg: l.message);
    }, (r) {
      state = false;
      // showToast(msg: 'reset matched user success');
    });
  }



  // when the chat ends match user id will be set to empty
  // it is called when user leave the chat to chat with someone else
  Future<void> resetOnlyMatchedUserIdForBoth({required String otherUserId}) async {
    state = true;
    final result = await _blindChatApis.resetOnlyMatchedUserIdForBoth(otherUserId: otherUserId);
    final result2 = await _blindChatApis.resetOnlyMatchedUserIdForMyself();
    result.fold((l) {
      state = false;
      debugPrint(l.message);
      // showToast(msg: l.message);
    }, (r) {
      state = false;
      // showToast(msg: 'reset matched user success');
    });
  }


  // Future<void> resetMatchedUserIdForBoth({required String otherUserId}) async {
  //   state = true;
  //   final result = await _blindChatApis.resetMatchedUserIdForBoth(otherUserId: otherUserId);
  //   final result2 = await _blindChatApis.resetMatchedUserIdForMyself();
  //   result.fold((l) {
  //     state = false;
  //     debugPrint(l.message);
  //     // showToast(msg: l.message);
  //   }, (r) {
  //     state = false;
  //     // showToast(msg: 'reset matched user success');
  //   });
  // }


  // it will set match user id to empty
  // it will also reset available status.
  Future<void> resetMatchedUserIdForMyself() async {
    state = true;
    final result = await _blindChatApis.resetMatchedUserIdForMyself();
    result.fold((l) {
      state = false;
      debugPrint(l.message);
      // showToast(msg: l.message);
    }, (r) {
      state = false;
      // showToast(msg: 'reset matched user success');
    });
  }

  // it will set match user id to empty
  // id the app crashed and match user id is not set empty so it will reset it
  // it is called mainly in main menu screen and also to some places where it is required
  Future<void> resetOnlyMatchedUserIdForMyself() async {
    state = true;
    final result = await _blindChatApis.resetOnlyMatchedUserIdForMyself();
    result.fold((l) {
      state = false;
      debugPrint(l.message);
      // showToast(msg: l.message);
    }, (r) {
      state = false;
      // showToast(msg: 'reset matched user success');
    });
  }



  Future<void> setOtherAvailableState({required bool isAvailable,required String otherUserId}) async {
    final result =
    await _blindChatApis.setOtherAvailableState(isAvailable: isAvailable, uid: otherUserId);
  }
}

