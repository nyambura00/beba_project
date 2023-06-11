import 'package:beba_app/widgets/beba_logo.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/utils/utils.dart';
import 'package:beba_app/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String signinRoute;

  const OtpScreen(
      {Key? key, required this.verificationId, required this.signinRoute})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 30),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const LogoText(),
                          const SizedBox(height: 30),
                          const Text(
                            "Verification",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Enter the OTP send to your phone number",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Pinput(
                            length: 6,
                            showCursor: true,
                            defaultPinTheme: PinTheme(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            onCompleted: (value) {
                              setState(() {
                                otpCode = value;
                              });
                            },
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: CustomButton(
                              text: "Verify OTP",
                              onPressed: () {
                                if (otpCode != null) {
                                  verifyOtp(
                                      context, otpCode!, widget.signinRoute);
                                } else {
                                  showSnackBar(context, "Enter the OTP code");
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: CustomButton(
                              text: "Resend OTP",
                              onPressed: () {
                                if (otpCode == null) {
                                  // resign in
                                  Navigator.pushNamed(context, '/signin');
                                } else {
                                  showSnackBar(context, "Contact Beba?");
                                  Navigator.pushNamed(context, '/contact');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  //verify OTP
  void verifyOtp(BuildContext context, String userOtp, String? signinRoute) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        ap.checkExistingUser().then((value) async {
          if (value == true) {
            // User exists in our app
            ap.getDataFromFireStore().then(
                  (value) => ap.saveUserDataToSP().then(
                        (value) => ap.setSignIn().then(
                          (value) {
                            // Redirect based on user roles
                            final userRole = ap.getUserRole(context);

                            if (userRole == UserType.driver) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/driverhome', (route) => false);
                            } else if (userRole == UserType.agent) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/agentdashboard', (route) => false);
                            } else if (userRole == UserType.superAdmin) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/superadminhome', (route) => false);
                            } else if (userRole == UserType.defaultUser) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/userhome', (route) => false);
                            }
                          },
                        ),
                      ),
                );
          } else {
            // user does not exist -> assign to respective splash screens
            // based on sign-in screen used
            switch (widget.signinRoute) {
              case '/signin/agent':
                Navigator.pushReplacementNamed(context, '/agentsplash');
                break;
              case '/signin/driver':
                Navigator.pushReplacementNamed(context, '/driversplash');
                break;
              case '/signin':
                Navigator.pushReplacementNamed(context, '/userhome');
                break;
              default:
                Navigator.pushReplacementNamed(context, '/userhome');
            }
          }
        });
      },
    );
  }
}
