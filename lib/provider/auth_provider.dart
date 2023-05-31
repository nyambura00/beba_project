// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/model/user_model.dart';
import 'package:beba_app/screens/auth/otp_screen.dart';
import 'package:beba_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserType {
  superAdmin,
  agent,
  driver,
  defaultUser,
}

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  UserType _currentUserRole = UserType.defaultUser;
  UserType get currentUserRole => _currentUserRole;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    String userRouteName = ModalRoute.of(context)?.settings.name ?? '';
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);

            //Get user's ID
            final uid = _firebaseAuth.currentUser?.uid;
            try {
              if (uid == null) {
                // if id is null, assign user role respectively
                String role = '';
                String? routeName = userRouteName;

                switch (routeName) {
                  case '/signin/superadmin':
                    role = 'SUPER_ADMIN';
                    break;
                  case '/signin/agent':
                    role = 'AGENT';
                    break;
                  case '/signin/driver':
                    role = 'DRIVER';
                    break;
                  case '/signin':
                    role = 'DEFAULT_USER';
                    break;
                  default:
                    role = 'DEFAULT_USER';
                }

                assignUserRole(
                  _firebaseAuth.currentUser!.uid,
                  role,
                );

                // UserType userType = getUserRoleFromRoleString(role);

                setSignIn();
                // Set user sign-in status
              } else {
                // Fetch user claims from the user's ID token
                final idTokenResult =
                    await _firebaseAuth.currentUser?.getIdTokenResult();

                // Access the custom claims from the user's ID token
                final customClaims = idTokenResult?.claims;

                // Check if the custom claims contain a 'role' claim
                if (customClaims != null && customClaims.containsKey('role')) {
                  // Retrieve the user role from the custom claims
                  final userRole = customClaims['role'];

                  switch (userRole) {
                    case 'SUPER_ADMIN':
                      Navigator.pushNamed(context, '/superadmin');
                      break;
                    case 'AGENT':
                      Navigator.pushNamed(context, '/agentdashboard');
                      break;
                    case 'DRIVER':
                      Navigator.pushNamed(context, '/driverhome');
                      break;
                    case 'DEFAULT_USER':
                      Navigator.pushNamed(context, '/userhome');
                      break;
                    default:
                      Navigator.pushNamed(context, '/userhome');
                  }

                  setSignIn();
                }
              }
            } catch (e) {
              print(e);
              showSnackBar(
                  context, 'Error accessing the authenticated user ID');
            }
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  verificationId: verificationId,
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void assignUserRole(String userId, String role) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'role': role}, SetOptions(merge: true)).then((value) {
      print('User role assigned successfully');
    }).catchError((error) {
      print('Failed to assign user role: $error');
    });
  }

  UserType getUserRoleFromRoleString(String role) {
    switch (role) {
      case 'SUPER_ADMIN':
        return UserType.superAdmin;
      case 'AGENT':
        return UserType.agent;
      case 'DRIVER':
        return UserType.driver;
      case 'DEFAULT_USER':
        return UserType.defaultUser;
      default:
        return UserType.defaultUser;
    }
  }

  UserType getUserRole(BuildContext context) {
    if (_firebaseAuth.currentUser != null) {
      // Access the user's role from your user data
      String userRole =
          _userModel?.role ?? ''; // Update with the actual user role field

      if (userRole.isNotEmpty) {
        // Map the user role string to the corresponding UserType enum value
        return getUserRoleFromRoleString(userRole);
      } else {
        print('User role not available');
        showSnackBar(context, 'User role not available');
      }
    } else {
      print('There is no user');
      showSnackBar(context, 'Please Sign In');
    }

    return UserType
        .defaultUser; // Return a default role if the user role is not available
  }

  void setUserRole(UserType userType) {
    _currentUserRole = userType;
    notifyListeners();
  }

  //verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user!;

      _uid = user.uid;
      onSuccess();
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
    required UserType userType,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Set the initial user role
      setUserRole(userType);

      await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        userModel.profilePic = value;
        userModel.createdAt = DateTime.now();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _uid!;
        userModel.role = getUserRole(context).toString();
      });
      _userModel = userModel;

      // uploading to database
      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getDataFromFireStore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        bio: snapshot['bio'],
        profilePic: snapshot['profilePic'],
        phoneNumber: snapshot['phoneNumber'],
        uid: snapshot['uid'],
        fullName: snapshot['fullName'],
        role: snapshot['role'],
      );
      _uid = userModel.uid;
    });
  }

  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  Future userSignOut(context) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    try {
      await _firebaseAuth.signOut();
      _isSignedIn = false;
      notifyListeners();
      s.clear();
      Navigator.pushNamedAndRemoveUntil(context, "/signin", (route) => false);
    } catch (e) {
      print(e);
    }
  }
}
