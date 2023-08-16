import 'package:gojek_university_app/commons/common_imports/apis_commons.dart';
import 'package:gojek_university_app/commons/common_providers/global_providers.dart';

final authApisProvider = Provider<AuthApis>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthApis(auth: auth);
});

abstract class IAuthApis {
  // FutureEither<User> signInWithEmailAndPass(
  //     {required String email, required String password});
  FutureEitherVoid logout();
  Future<User?> getCurrentUser();
  Stream<User?> getSigninStatusOfUser();
}

class AuthApis implements IAuthApis {
  final FirebaseAuth _auth;
  AuthApis({required FirebaseAuth auth}) : _auth = auth;

  @override
  FutureEitherVoid logout() async {
    try {
      final response = await _auth.signOut();
      return Right(response);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  //
  // @override
  // FutureEither<User> registerWithEmailPassword(
  //     {required String email, required String password}) async {
  //   try {
  //     final response = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     // User user = response.user!;
  //     //
  //     // await user.sendEmailVerification();
  //     return Right(response.user!);
  //   } on FirebaseAuthException catch (e, stackTrace) {
  //     return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
  //   } catch (e, stackTrace) {
  //     return Left(Failure(e.toString(), stackTrace));
  //   }
  // }

  //
  @override
  FutureEither<User> signInStaffWithUsernameAndPass(
      {required String email, required String password}) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(response.user!);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }
  User? getCurrUser()  {
    return _auth.currentUser;
  }

  @override
  Stream<User?> getSigninStatusOfUser() {
    return _auth.authStateChanges();
  }


}
