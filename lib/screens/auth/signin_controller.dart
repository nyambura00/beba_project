import 'package:beba_app/repository/authrepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  static SigninController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final phoneNo = TextEditingController();

  //Get phoneNo from user (Screen) and pass it to Auth Repository for Firebase Authentication
  bool phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
    return true;
  }
}