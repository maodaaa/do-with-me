import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User get user => _auth.currentUser!;

  Stream<User?> get authState => _auth.authStateChanges();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        await _auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      e.stackTrace.toString();
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email.toString(),
          password: password.toString(),
        );
      }
    } on FirebaseAuthException catch (e) {
      e.stackTrace.toString();
    }
  }

  Future<void> signUpInWitEmail(String name, String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.createUserWithEmailAndPassword(
          email: email.toString(),
          password: password.toString(),
        );
        await _auth.currentUser?.updateDisplayName(name);
      }
    } on FirebaseAuthException catch (e) {
      e.stackTrace.toString();
    }
  }

  Future<void> signOut() async {
    _auth.signOut();
  }
}
