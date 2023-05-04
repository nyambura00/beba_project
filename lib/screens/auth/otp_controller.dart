import 'package:beba_app/repository/authrepo.dart';
import 'package:beba_app/screens/userhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final otp = TextEditingController();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomeScreen()) : Get.back();
  }

}

