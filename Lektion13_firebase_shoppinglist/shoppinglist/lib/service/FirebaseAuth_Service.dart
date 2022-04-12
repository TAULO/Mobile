import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthSerivce {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseAuth get getAuth => auth;

  User? get currentUser => auth.currentUser;
  Stream<User?> get authStateChanges => auth.authStateChanges();
  FirebaseAuthSerivce(this.auth);

  Future<void> logout() async {
    print("logout");
    await auth.signOut();
  }

  String? getUsername({required User? user}) {
    if (user != null) {
      return user.displayName;
    }
    return "Username not found";
  }

  Future<String> createUserWithEmail(
      {required String email,
      required String password,
      required String username}) async {
    try {
      if (password.length <= 6) return "Password is too weak";
      if (username.length >= 10) {
        return "Username must NOT be greater than 10 characters";
      }
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      user?.updateDisplayName(username);
      return credential.user!.email.toString() + " has been signed up";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> signInWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user!.email.toString() + " logged in";
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") return "e-mail is invalid";
      if (e.code == "user-disabled") return "This user is disabled";
      if (e.code == "user-not-found") return "The user was not found";
      if (e.code == "wrong-password") return "Wrong password";
      return "Something went wrong";
    }
  }
}
