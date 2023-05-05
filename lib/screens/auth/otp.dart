import 'package:beba_app/screens/auth/otp_controller.dart';
import 'package:beba_app/screens/auth/signin_controller.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatefulWidget {

  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late TextEditingController _otpController;
  final controller = Get.put(SigninController());

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const AppbarWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 40.0, right: 30.0, top: 70, bottom: 80),
              child: Text('Enter OTP code', style: TextStyle(fontSize: 20, fontFamily: 'SpaceMono'),),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding:
                EdgeInsets.only(left: 40.0, right: 30.0, top: 0, bottom: 0),
              child: SizedBox(width: 300,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter code',
                      hintText: 'OTP code'),
                )
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()=> {
                OTPController.instance.verifyOTP(_otpController.text.trim())
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, 
                foregroundColor: Colors.white,// background color
                elevation: 5, // button's elevation
                textStyle: const TextStyle(
                  color: Colors.white, // text color
                  fontSize: 20, // font size
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Verify OTP'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                SigninController.instance.phoneAuthentication(controller.phoneNo.text.trim());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white, // background color
                elevation: 5, // button's elevation
                textStyle: const TextStyle(
                  color: Colors.white, // text color
                  fontSize: 20, // font size
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }
}