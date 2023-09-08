import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gojek_university_app/commons/common_imports/apis_commons.dart';
import 'package:gojek_university_app/commons/common_providers/global_providers.dart';
import 'package:gojek_university_app/core/constants/firebase_constants.dart';
import '../../../../core/type_defs.dart';
import '../../../../models/user_model.dart';

// Provider definition for accessing BlindChatApis instance
final blindChatApisProvider = Provider<BlindChatApis>((ref) {
  final fireStore = ref.watch(firebaseDatabaseProvider);
  final auth = ref.watch(firebaseAuthProvider);
  return BlindChatApis(firestore: fireStore, auth: auth);
});

// Interface defining the contract for BlindChatApis functions
abstract class IBlindChatApis {
  // User Functions
  FutureEitherVoid saveUserInfo({required UserModel userModel});
  Future<DocumentSnapshot> getCurrentUserInfo({required String uid});
}

class BlindChatApis extends IBlindChatApis {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  // Constructor to inject dependencies
  BlindChatApis(
      {required FirebaseAuth auth, required FirebaseFirestore firestore})
      : _firestore = firestore,
        _auth = auth;

  // Implementation of saveUserInfo
  @override
  FutureEitherVoid saveUserInfo({required UserModel userModel}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userModel.uid)
          .set(userModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  // Implementation of getCurrentUserInfo
  @override
  Future<DocumentSnapshot> getCurrentUserInfo({required String uid}) async {
    final DocumentSnapshot document = await _firestore
        .collection(FirebaseConstants.userCollection)
        .doc(uid)
        .get();
    return document;
  }

  // Function to get user info by UID as a Stream
  getUserInfoByUid(String userId) {
    return _firestore
        .collection(FirebaseConstants.userCollection)
        .doc(userId)
        .snapshots()
        .map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  // Function to listen to online users count as a Stream
  listenToOnlineUsersCount() {
    return _firestore
        .collection(FirebaseConstants.userCollection)
        .where('isOnline', isEqualTo: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);
  }

  // Function to get available users count
  Future<int> getAvailableUsersCount() async {
    QuerySnapshot snapshot = await _firestore
        .collection(FirebaseConstants.userCollection)
        .where('isOnline', isEqualTo: true)
        .where('isAvailable', isEqualTo: true)
        .where('uid', isNotEqualTo: _auth.currentUser!.uid)
        .get();
    return snapshot.size;
  }

  // Function to get the first available user for chat
  @override
  Future<QuerySnapshot<Map<String, dynamic>>>
      getFirstAvailableUserForChat() async {
    return _firestore
        .collection(FirebaseConstants.userCollection)
        .where('isOnline', isEqualTo: true)
        .where('isAvailable', isEqualTo: true)
        .where('uid', isNotEqualTo: _auth.currentUser!.uid)
        .limit(1)
        .get();
  }

  // Function to reset matched user IDs for both users
  @override
  Future<DocumentSnapshot> getsStaffInfo() async {
    final DocumentSnapshot document = await _firestore
        .collection(FirebaseConstants.staffCollection)
        .doc(FirebaseConstants.staffDocument)
        .get();
    return document;
  }

  // Function to reset only matched user IDs for both users
  FutureEitherVoid setOtherAvailableState(
      {required bool isAvailable, required String uid}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(uid)
          .update({
        'isAvailable': isAvailable,
      });
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  // Function to reset matched user ID for myself
  FutureEitherVoid setMyAvailableState({required bool isAvailable}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(_auth.currentUser!.uid)
          .update({
        'isAvailable': isAvailable,
      });
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  // Future<Map<String, dynamic>> getFirstAvailableOnlineUser() async {
  //   try {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('users') // Replace 'users' with your collection name
  //         .where('isOnline', isEqualTo: true)
  //         .orderBy('availabilityTimestamp') // Replace 'availabilityTimestamp' with the field that represents user availability (e.g., lastOnlineTimestamp)
  //         .limit(1)
  //         .get();
  //
  //     if (snapshot.docs.isNotEmpty) {
  //       // Get the first available user from the query results
  //       DocumentSnapshot firstUser = snapshot.docs.first;
  //       return firstUser.data(); // Return the user data as a Map
  //     } else {
  //       return null; // No available online users found
  //     }
  //   } catch (e) {
  //     print('Error fetching first available online user: $e');
  //     return null; // Return null in case of an error
  //   }
  // }


  // Function to set o matched user IDs  for both users to each other and update the user models
  @override
  FutureEitherVoid setMatchedUserIdForBoth({
    required UserModel myUserModel,
    required UserModel otherUserModel
  }) async {
    try {
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(myUserModel.uid)
          .update(myUserModel.toMap());
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(otherUserModel.uid)
          .update(otherUserModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  // Function to reset only matched user IDs and available status to false for both users
  @override
  FutureEitherVoid resetMatchedUserIdForBoth({
    required String otherUserId,
  }) async {
    try {
      final  uid=_auth.currentUser!.uid;
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(otherUserId)
          .update({
        'matcheduser': '', 'isAvailable': false,
      });
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(uid)
          .update({
        'matcheduser': '','isAvailable': false,
      });
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  // Function to reset only matched user IDs for both users
  FutureEitherVoid resetOnlyMatchedUserIdForBoth({
    required String otherUserId,
  }) async {
    try {
      final  uid=_auth.currentUser!.uid;
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(otherUserId)
          .update({
        'matcheduser': '',
      });
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(uid)
          .update({
        'matcheduser': '',
      });
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

// Function to reset matched user ID and available to false for myself
  @override
  FutureEitherVoid resetMatchedUserIdForMyself() async {
    try {
     final  uid=_auth.currentUser!.uid;
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(uid)
          .update({
        'matcheduser': '','isAvailable': false,
      });
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

 // Function to reset only matched user ID for myself
  FutureEitherVoid resetOnlyMatchedUserIdForMyself() async {
    try {
      final  uid=_auth.currentUser!.uid;
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(uid)
          .update({
        'matcheduser': '',
      });
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  // FutureEitherVoid saveStaffInfo({required StaffModel staffModel}) async {
  //   try {
  //     await _firestore
  //         .collection(FirebaseConstants.staffCollection)
  //         .doc(staffModel.uid)
  //         .set(staffModel.toMap());
  //     return const Right(null);
  //   } on FirebaseException catch (e, stackTrace) {
  //     return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
  //   } catch (e, stackTrace) {
  //     return Left(Failure(e.toString(), stackTrace));
  //   }
  // }
}
