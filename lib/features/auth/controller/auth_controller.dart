import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_functions/email_format_check_func.dart';
import 'package:gojek_university_app/commons/common_widgets/show_toast.dart';
import 'package:gojek_university_app/features/auth/data/auth_apis/auth_apis.dart';
import 'package:gojek_university_app/features/auth/data/auth_apis/database_apis.dart';
import 'package:gojek_university_app/models/staff_model.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(databaseApisProvider),
  );
});

final userStateStreamProvider = StreamProvider((ref) {
  final authProvider = ref.watch(authControllerProvider.notifier);
  return authProvider.getSigninStatusOfUser();
});

final currentUserAuthProvider = FutureProvider((ref) {
  final authCtr = ref.watch(authControllerProvider.notifier);
  return authCtr.currentUser();
});
final currentUserModelData = FutureProvider((ref) {
  final authCtr = ref.watch(authControllerProvider.notifier);
  return authCtr.getCurrentUserInfo();
});

final fetchUserByIdProvider = StreamProvider.family((ref, String uid) {
  final profileController = ref.watch(authControllerProvider.notifier);
  return profileController.getUserInfoByUid(uid);
});



// final currUserAuthProvider = Provider((ref) {
//   final authCtr = ref.watch(authControllerProvider.notifier);
//   return authCtr.currUser();
// });

class AuthController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final DatabaseApis _databaseApis;

  AuthController(
      {required AuthApis authApis, required DatabaseApis databaseApis})
      : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

  Future<User?> currentUser() async {
    return _authApis.getCurrentUser();
  }

  // Future<void> registerWithEmailAndPassword({
  //   required String name,
  //   required String password,
  //   required BuildContext context,
  // }) async {
  //   state = true;
  //   final result = await _authApis.registerWithEmailPassword(
  //       email: 'staff@gmail.com', password: 'Staff@1234');
  //
  //   result.fold((l) {
  //     state = false;
  //     showSnackBar(context, l.message);
  //   }, (r) async {
  //     StaffModel staffModel = StaffModel(uid: r.uid, username: name, password: 'Staff@1234');
  //
  //     final result2 = await _databaseApis.saveStaffInfo(staffModel: staffModel);
  //     // await _databaseApis.getCurrentUserInfo(uid: r.uid);
  //     result2.fold((l) {
  //       state = false;
  //       showToast(msg: l.message);
  //     }, (r) async {
  //       state = false;
  //       Navigator.pushNamed(context, AppRoutes.staffPortalHomeScreen);
  //       showToast(msg: 'Account Created Successfully!');
  //     });
  //   });
  // }

  //google sign in
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      state = true;

      final GoogleSignInAccount? googleUser =
          Theme.of(context).platform == TargetPlatform.iOS
              ? await GoogleSignIn(
                  clientId:
                      "201535661836-ahfe9gta8t1c2mteg9gpqt04pfb9c1rn.apps.googleusercontent.com",
                  scopes: ['email', 'profile'],
                  hostedDomain: "",
                ).signIn()
              : await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Removed to allow all the Gmail
      // if (!isValidEmailFormat(googleUser!.email)) {
      //   showToast(msg: "Email format didn't match", long: true);
      //   state = false;
      //   return;
      // }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          UserModel userModel = UserModel(
              uid: userCredential.user!.uid,
              name: userCredential.additionalUserInfo!.profile!['name'],
              email: userCredential.additionalUserInfo!.profile!['email'],
              profileImage:
                  userCredential.additionalUserInfo!.profile!['picture'],
              createdAt: DateTime.now(),
              isOnline: true,
              instagramHandle: '',
              interests: [], isAvailable: false, matcheduser: '', notificationToken: '');
          final result2 =
              await _databaseApis.saveUserInfo(userModel: userModel);
          result2.fold((l) {
            state = false;
            debugPrintStack(stackTrace: l.stackTrace);
            debugPrint(l.message);
            showToast(msg: l.message);
          }, (r) async {
            state = false;
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.mainMenuScreen, (route) => false);
          });
        } else {
          setUserState(true);
          state = false;
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.mainMenuScreen, (route) => false);
          return;
        }
      }
      state = false;
    } on FirebaseAuthException catch (e, st) {
      debugPrintStack(stackTrace: st);
      debugPrint(e.toString());
      state = false;
      if (e.toString() == 'Null check operator used on a null value') {
        return;
      }
      showSnackBar(context, e.message!);
    } catch (e, st) {
      debugPrintStack(stackTrace: st);
      debugPrint(e.toString());
      state = false;
      if (e.toString() == 'Null check operator used on a null value') {
        return;
      }
      showSnackBar(context, e.toString());
    }
  }

  // Login Staff
  Future<void> signInStaffWithUsernameAndPassword({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.signInStaffWithUsernameAndPass(
        email: 'staff@gmail.com', password: 'Staff@1234');
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      final userId = await _authApis.getCurrentUser();
      userId!.uid;
      final result = await _databaseApis.getsStaffInfo();
      StaffModel staffModel =
          StaffModel.fromMap(result.data() as Map<String, dynamic>);
      if (staffModel.username == username && staffModel.password == password) {
        state = false;
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.staffPortalHomeScreen, (route) => false);
      } else {
        _authApis.logout();
        showSnackBar(context, 'Incorrect username or password');
        state = false;
      }
    });
  }



  Future<UserModel> getCurrentUserInfo() async {
    final userId = await _authApis.getCurrentUser();
    final result = await _databaseApis.getCurrentUserInfo(uid: userId!.uid);
    UserModel userModel =
        UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }

  Future<UserModel> getUserInfoByUidFuture(String uid) async {
    final result = await _databaseApis.getCurrentUserInfo(uid:  uid);
    UserModel userModel =
    UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }

  Stream<UserModel> getUserInfoByUid(String userId) {
    return _databaseApis.getUserInfoByUid(userId);
  }

  // LogOut User
  Future<void> logout({
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.logout();
    state = false;
    result.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.signInScreen, (route) => false);
    });
  }

  Future<void> logoutStudent({
    required BuildContext context,
  }) async {
    state = true;
    await GoogleSignIn().signOut();
    setUserState(false);
    final result = await _authApis.logout();
    state = false;
    result.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.signInScreen, (route) => false);
    });
  }

  void setUserState(bool isOnline) async {
    final userId = await _authApis.getCurrentUser();
    final result =
        await _databaseApis.setUserState(isOnline: isOnline, uid: userId!.uid);
  }

  // getSigninStatusOfUser
  Stream<User?> getSigninStatusOfUser() {
    return _authApis.getSigninStatusOfUser();
  }

  Future<bool> getSignMethodGoogle() async {
    final userId = await _authApis.getCurrentUser();
    UserInfo userInfo = userId!.providerData[0];
    if (userInfo.providerId == 'google.com') {
      return true;
    }
    return false;
  }

// Update User Information
  Future<void> updateCurrentUserInfo(
      {required BuildContext context,
      required List<String> interests,
      required String instagramHandle,
      required UserModel userModel}) async {
    state = true;
    UserModel updateProfileUserModel = userModel;
    updateProfileUserModel= updateProfileUserModel.copyWith(
        interests: interests, instagramHandle: instagramHandle);
    final result2 = await _databaseApis.updateCurrentUserInfo(
        userModel: updateProfileUserModel);
    result2.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'Profile Updated Successfully');
    });
  }

  Future<void> updateCurrentUserInstagramInfo(
      {required BuildContext context,
        required String instagramHandle,
        required UserModel userModel}) async {
    state = true;
    UserModel updateProfileUserModel = userModel;
    updateProfileUserModel= updateProfileUserModel.copyWith(instagramHandle: instagramHandle);
    final result2 = await _databaseApis.updateCurrentUserInfo(
        userModel: updateProfileUserModel);
    result2.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'Instagram Handle Updated Successfully');
    });
  }
}

// Google format email check
// print(isValidEmailFormat("roberto.fernandes.gjk31@gmail.com"));
// print(",,,,,,,");
// print(isValidEmailFormat("john_doe.ab12@gmail.com"));
// print(",,,,,,,");// Should print false (contains underscore)
// print(isValidEmailFormat("emma.xyz1234@gmail.com"));
// print(",,,,,,,");// Should print false (more than 4 letters)
// print(isValidEmailFormat("alice.def123@gmail.com"));
// print(",,,,,,,");// Should print false (less than 4 letters)
// print(isValidEmailFormat("jim.gh12@gmail.com"));
// print(",,,,,,,");// Should print false (wrong format)
// print(isValidEmailFormat("wrong.format@gmail.com"));
// print(",,,,,,,");
