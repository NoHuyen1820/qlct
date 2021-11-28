import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:qlct/model/user.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  UserNew? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return UserNew(user.uid, user.email, user.displayName);
  }

  Stream<UserNew?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  UserNew? getCurrentUser() {
    return _userFromFirebase(_firebaseAuth.currentUser);
  }

  String getCurrentUID() {
    return _userFromFirebase(_firebaseAuth.currentUser)!.uid;
  }

  Future<UserNew?> signInWithEmailAndPasswordLocal(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(credential.user);
  }

  Future<UserNew?> createUserWithEmailAndPasswordLocal(
    String email,
    String password,
    String displayName,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    credential.user!.updateDisplayName(displayName);
    credential.user!.reload();
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
