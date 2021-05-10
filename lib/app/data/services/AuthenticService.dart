import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticService {
  AuthenticService._privateConstructor();
  static final AuthenticService instance =
      AuthenticService._privateConstructor();
  FirebaseAuth _firebaseAuth;
  GoogleSignIn _googleSignIn;
  String fbAcessToken;

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    _firebaseAuth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    await Future.delayed(Duration(seconds: 1));
    return firebaseApp;
  }

  User getCurrentUser() => FirebaseAuth.instance.currentUser;

  Future<User> signInWithGoogle() async {
    User user;
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    return user;
  }

  Future signOutGoogle() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<User> signInWithFacebook() async {
    User user;
    final result = await FacebookAuth.instance.login();
    try {
      print(result.status.toString());
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken.token);
      fbAcessToken = result.accessToken.token;
      print(fbAcessToken);
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        print("lỗi 1");
      } else if (e.code == 'invalid-credential') {
        print("lỗi 2");
      }
    } catch (e) {}

    return user;
  }

  Future signOutFacebook() async {
    await FacebookAuth.instance.logOut();
    await _firebaseAuth.signOut();
  }
}
