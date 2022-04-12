import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppinglist/service/FirebaseAuth_Service.dart';

class LoginState {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseAuthSerivce _authSerivce =
      FirebaseAuthSerivce(FirebaseAuth.instance);

  Stream<User?> get getUserChanges => _authSerivce.authStateChanges;
  User? get currentUser => _authSerivce.currentUser;

  LoginState();

  // Future<void> setUserName(
  //     {required User? user, required String username}) async {
  //   print(username.length);
  //   return await _authSerivce.setUserName(user: user, username: username);
  // }

  String? getUsername({required User? user}) {
    if (user != null) {
      return _authSerivce.getUsername(user: user);
    }
    return "User not found";
  }

  Future<String> createUserWithEmail(
      {required String email,
      required String password,
      required String username}) async {
    return await _authSerivce.createUserWithEmail(
        email: email, password: password, username: username);
  }

  Future<String> signInWithEmail(
      {required String email, required String password}) async {
    return await _authSerivce.signInWithEmail(email: email, password: password);
  }

  Future<void> logout() async {
    await _authSerivce.logout();
  }
}
