import 'package:beba_app/screens/splash.dart';
import 'package:beba_app/screens/userhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:beba_app/models/user.dart' as user_model;

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;

  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const SplashScreen()) : Get.offAll(() => const HomeScreen());
  }

  final _databaseRef = FirebaseDatabase.instance.ref(); // reference to the Firebase Realtime Database
  Future<void> addUserToDatabase(user_model.User user) async {
    final userRef = _databaseRef.child('users').child(user.userId.toString());
    await userRef.set({
      'phoneNumber': user.phoneNumber,
      'role': user.role,
      'verificationStatus': user.verificationStatus,
    });
  }

  Future<void> phoneAuthentication( String phoneNo) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          UserCredential result = await _auth.signInWithCredential(credential);
          User? user = result.user;
          
          if(user != null){
            await addUserToDatabase(user_model.User(
              userId: user.uid,
              phoneNumber: user.phoneNumber!,
              role: 'traveller',
              verificationStatus: false,
            ));
            Navigator.push(context as BuildContext, MaterialPageRoute(
              builder: (context) => HomeScreen(user: user,)
            ));
          }else{
            print("Error");
          }
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
        verificationFailed: (e) {
          if(e.code == 'Invalid Phone Number') {
            Get.snackbar('Input Error', 'Phone Number provided is not valid.');
          } else {
            Get.snackbar('Error', 'Something went wrong. Try again later');
          }
        }
      );
    } catch (e) {
      print(e);
    }
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth
      .signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<void> logout() async {
    _auth.signOut();
  }

  // notifylisteners();
}