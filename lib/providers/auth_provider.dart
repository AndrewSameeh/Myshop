import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_shop/Services/utility_service.dart';
import 'package:my_shop/Utility/enums.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Services/user_service.dart';
import '../Services/pus_notification_service.dart' as pus_notification_service;
import '../locator.dart';

class Auth with ChangeNotifier {
  fire.FirebaseAuth get _auth {
    return fire.FirebaseAuth.instance;
  }

  String _verificationId;

  Future<void> initializeApp() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
        // _auth = fire.FirebaseAuth.instance;
      }
    } catch (error) {
      print(error);
    }
    return;
  }

  String _token;
  DateTime _expiredate;
  String _userId;
  Timer _myauthTimer;
  String get userId {
    return _userId;
  }

  bool get isAuth {
    return true; //token != null;
  }

  String get token {
    // if (_expiredate != null && _expiredate.isAfter(DateTime.now()))
    return _token;
  }

  //#region signInWithGoogle
  Future<void> signInWithGoogle() async {
    await initializeApp();
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final fire.AuthCredential credential = fire.GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return firebaseSignIn(credential, LoginTypeEnum.Gmail);
    } catch (error) {
      print("error" + error);
    }
  }

  //#endregion

  Future<void> firebaseSignIn(
      fire.AuthCredential credential, LoginTypeEnum loginType) async {
    await initializeApp();
    final fire.UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final fire.User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      _token = await user.getIdToken();

      final fire.User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      UserService().registerUser(user, loginType);
      notifyListeners();
      locator<UtiltiyService>().setToken(token);
    }
  }

  //#region Phone
  Future<void> verivyPhone(String phone) async {
    await initializeApp();

    await fire.FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted:
            (fire.PhoneAuthCredential phoneAuthCredential) async {},
        verificationFailed: (FirebaseException ex) {
          print('verificationFailed');
          print(ex.message);
          print(ex);
        },
        codeSent: (String code, int forceresen) {
          _verificationId = code;
          print("codeSent");
        },
        codeAutoRetrievalTimeout: (code) {
          print("codeAutoRetrievalTimeout");
        });
  }

  Future<void> completePhoneVerifications(String smsCode) async {
    fire.AuthCredential credential = fire.PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);
    await firebaseSignIn(credential, LoginTypeEnum.Phone);
  }
  //#endregion Phone

//#region
  Future<void> sighnup(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await sighnin(email, password);
    //return _authanticate(email, password, 'signUp');
  }

  Future<void> sighnin(String email, String password) async {
    final fire.AuthCredential credential =
        fire.EmailAuthProvider.credential(email: email, password: password);
    await firebaseSignIn(credential, LoginTypeEnum.EmailAndPassword);
    //return _authanticate(email, password, 'signInWithPassword');
  }
//#endregion

  // Future<void> _authanticate(String email, String password, String syg) async {
  //   try {
  //     final url =
  //         'https://identitytoolkit.googleapis.com/v1/accounts:$syg?key=AIzaSyA727iUCRr0hmO8elM2R6j0zMw2wLopxdk';
  //     final response = await http.post(url,
  //         body: json.encode({
  //           'email': email,
  //           'password': password,
  //           'returnSecureToken': true
  //         }));
  //     final reponseobject = json.decode(response.body);
  //     if (reponseobject['error'] != null) {
  //       throw HttpException(reponseobject['error']['message']);
  //     }
  //     _token = reponseobject['idToken'];
  //     //  var x = userCredential.credential.token;
  //     _userId = reponseobject['localId'];
  //     _expiredate = DateTime.now()
  //         .add(Duration(seconds: int.parse(reponseobject['expiresIn'])));
  //     autoLogout();
  //     notifyListeners();
  //     var pref = await SharedPreferences.getInstance();
  //     var userData = json.encode({
  //       'token': _token,
  //       'userId': userId,
  //       'expiredate': _expiredate.toIso8601String()
  //     });
  //     pref.setString('userData', userData);
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future logout() async {
    _userId = null;
    _token = null;
    _expiredate = null;
    if (_myauthTimer != null) {
      _myauthTimer.cancel();
      _myauthTimer = null;
    }
    await pus_notification_service.PusNotificationService().unsubscribe();
    locator<UtiltiyService>().clearToken();
    notifyListeners();
  }

  void autoLogout() {
    final timediv = _expiredate.difference(DateTime.now()).inSeconds;
    if (_myauthTimer != null) _myauthTimer.cancel();
    _myauthTimer = Timer(Duration(seconds: timediv), logout);
  }

  Future<bool> autoLogin() async {
    _token = await locator<UtiltiyService>().getToken();
    if (isAuth) notifyListeners();
    return true;
  }
}
