import 'package:beba_app/screens/auth/otp.dart';
import 'package:beba_app/screens/auth/signin_controller.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SigninController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: const AppbarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.phoneNo,
                decoration: const InputDecoration(label: Text('Phone Number'), prefixIcon: Icon(Icons.numbers)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if(formKey.currentState!.validate()) {
                      SigninController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                      Get.to(() => const OtpVerificationScreen());
                    }
                  },
                  child: Text('Sign In'.toUpperCase()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}