import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
  fire.FirebaseAuth _auth;

  String _verificationId;

  Future<void> initializeApp() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
        _auth = fire.FirebaseAuth.instance;
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
    return token != null;
  }

  String get token {
    // if (_expiredate != null && _expiredate.isAfter(DateTime.now()))
    return _token;
  }

  //#region signInWithGoogle
  Future<void> signInWithGoogle() async {
    await initializeApp();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final fire.AuthCredential credential = fire.GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    return firebaseSignIn(credential);
  }

  //#endregion

  Future<void> firebaseSignIn(fire.AuthCredential credential) async {
    final fire.UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final fire.User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      _token = await user.getIdToken();

      final fire.User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      notifyListeners();
    }
  }

  // Future<void> signOutGoogle() async {
  //   await googleSignIn.signOut();

  //   print("User Signed Out");
  // }
  //#region Phone
  Future<void> verivyPhone(String phone) async {
    await initializeApp();

    await fire.FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted:
            (fire.PhoneAuthCredential phoneAuthCredential) async {},
        verificationFailed: (FirebaseException ex) {
          // print('verificationFailed');
          // print(ex.message);
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
    firebaseSignIn(credential);
  }
  //#endregion Phone

  // Future<fire.UserCredential> signInWithGoogle() async {
  //   //await GoogleSignIn().signOut();
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;

  //   // Create a new credential
  //   final fire.GoogleAuthCredential credential =
  //       fire.GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await fire.FirebaseAuth.instance.signInWithCredential(credential);
  // }

  Future<fire.UserCredential> sighinwithuserNameandpassword(
      String email, String password) async {
    fire.UserCredential userCredential = await fire.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<void> _authanticate(String email, String password, String syg) async {
    //  sighinwithuserNameandpassword
    // await signInWithGoogle1();
    try {
      //await initializeApp();
      // await VerivyPhone(email);
      ////  return;
      // await signInWithGoogle();
      //  return;
      // fire.UserCredential userCredential = await sighinwithuserNameandpassword(
      //   email,
      //   password,
      // );

      final url =
          'https://identitytoolkit.googleapis.com/v1/accounts:$syg?key=AIzaSyA727iUCRr0hmO8elM2R6j0zMw2wLopxdk';
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final reponseobject = json.decode(response.body);
      if (reponseobject['error'] != null) {
        throw HttpException(reponseobject['error']['message']);
      }
      _token = reponseobject['idToken'];
      //  var x = userCredential.credential.token;
      _userId = reponseobject['localId'];
      _expiredate = DateTime.now()
          .add(Duration(seconds: int.parse(reponseobject['expiresIn'])));
      autoLogout();
      notifyListeners();
      var pref = await SharedPreferences.getInstance();
      var userData = json.encode({
        'token': _token,
        'userId': userId,
        'expiredate': _expiredate.toIso8601String()
      });
      pref.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> sighnup(String email, String password) async {
    return _authanticate(email, password, 'signUp');
  }

  Future<void> sighnin(String email, String password) async {
    return _authanticate(email, password, 'signInWithPassword');
  }

  void logout() async {
    _userId = null;
    _token = null;
    _expiredate = null;
    if (_myauthTimer != null) {
      _myauthTimer.cancel();
      _myauthTimer = null;
    }
    notifyListeners();
    var pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  void autoLogout() {
    final timediv = _expiredate.difference(DateTime.now()).inSeconds;
    if (_myauthTimer != null) _myauthTimer.cancel();
    _myauthTimer = Timer(Duration(seconds: timediv), logout);
  }

  Future<bool> autoLogin() async {
    var pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) return false;
    final userdata =
        json.decode(pref.getString('userData')) as Map<String, dynamic>;
    final expire = DateTime.parse(userdata['expiredate']);
    if (expire.isBefore(DateTime.now())) return false;
    _token = userdata['token'];
    _userId = userdata['userId'];
    _expiredate = expire;
    notifyListeners();
    return true;
  }
}
