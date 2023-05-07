import 'package:beba_app/widgets/beba_logo.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/widgets/background_image.dart';
import 'package:beba_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() =>  SigninScreenState();
}

class  SigninScreenState extends State<SigninScreen> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "254",
    countryCode: "KE",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Kenya",
    example: "Kenya",
    displayName: "Kenya",
    displayNameNoCountryCode: "KE",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                child: Column(
                  children: [
                    const LogoText(),
                    const SizedBox(height: 70),
                    const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Add phone number and get a verification code",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      cursorColor: Colors.white,
                      controller: phoneController,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          phoneController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Enter phone number",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: Colors.blue[45],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white30),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                },
                              );
                            },
                            child: Text(
                              "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        suffixIcon: phoneController.text.length > 9
                            ? Container(
                                height: 30,
                                width: 30,
                                margin: const EdgeInsets.all(10.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomButton(
                        text: "Enter",
                        onPressed: () => sendPhoneNumber(),
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

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}