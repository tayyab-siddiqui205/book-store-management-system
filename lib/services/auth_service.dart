import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  // ==========================
  // REGISTER
  // ==========================

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // ==========================
  // LOGIN
  // ==========================

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // ==========================
  // RESET PASSWORD
  // ==========================

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email.trim(),
    );
  }

  // ==========================
  // GOOGLE LOGIN
  // ==========================

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? account =
        await googleSignIn.signIn();

    if (account == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await account.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    return await _auth.signInWithCredential(
      credential,
    );
  }

  // ==========================
  // LOGOUT
  // ==========================

 // ==========================
// LOGOUT
// ==========================

Future<void> logout() async {
  await _auth.signOut();
}
}