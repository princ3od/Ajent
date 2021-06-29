import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

enum LoginType {
  withGoogle,
  withFacebook,
  byPhone,
}

class AuthenticService {
  AuthenticService._privateConstructor();
  static final AuthenticService instance =
      AuthenticService._privateConstructor();
  FirebaseAuth _firebaseAuth;
  GoogleSignIn _googleSignIn;
  String fbAcessToken;

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    FirebaseAuth.instance.setLanguageCode("vn");
    _firebaseAuth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    await Future.delayed(Duration(seconds: 1));
    return firebaseApp;
  }

  LoginType getLoginType() {
    if (FirebaseAuth.instance.currentUser != null) {
      switch (FirebaseAuth.instance.currentUser.providerData[0].providerId) {
        case "google.com":
          return LoginType.withGoogle;
        case "facebook.com":
          return LoginType.withFacebook;
        case "phone":
          return LoginType.byPhone;
        default:
          return LoginType.withGoogle;
      }
    }
    return LoginType.withGoogle;
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

  Future verifyPhoneNumber(
      String phone,
      Function(PhoneAuthCredential) onCompleted,
      Function onFailed,
      Function(String) onSent,
      Function(String) onTimeOut) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        timeout: Duration(seconds: 30),
        phoneNumber: phone,
        verificationCompleted: onCompleted,
        verificationFailed: (e) {
          onFailed();
        },
        codeSent: (verifiedID, _) {
          onSent(verifiedID);
        },
        codeAutoRetrievalTimeout: (verifiedID) {
          onTimeOut(verifiedID);
        },
      );
    } catch (e) {
      //
    }
  }

  Future<User> signInByPhone(String verificationID, String code) async {
    User user;
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: code,
      );

      user = (await _firebaseAuth.signInWithCredential(credential)).user;
    } catch (e) {
      return null;
    }
    return user;
  }
}
