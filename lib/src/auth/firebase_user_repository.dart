import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<bool> isAuthenticated() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future<void> authenticate() {
    return _firebaseAuth.signInAnonymously();
  }

  @override
  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> logout() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return;
  }

  @override
  Future<int> getCustomClaimLevel(User user) async {
    final results = await user.getIdTokenResult();
    final claims = results.claims;
    if (claims?['admin'] as bool) {
      return 4;
    } else if (claims?['moderator'] as bool) {
      return 3;
    } else if (claims?['writer'] as bool) {
      return 2;
    }
    return 1;
  }
}
