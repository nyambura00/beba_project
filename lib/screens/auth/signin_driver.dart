import 'package:beba_app/widgets/beba_logo.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class DriverSignin extends StatefulWidget {
  const DriverSignin({Key? key}) : super(key: key);

  @override
  State<DriverSignin> createState() => DriverSigninState();
}

class DriverSigninState extends State<DriverSignin> {
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  UserType selectedUserRole = UserType.driver;

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
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
                      "Driver Sign In",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Leverage on time. Get travellers.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      controller: phoneController,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        setState(() {
                          phoneController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Enter No Eg. 0712345678",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Colors.grey,
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
                                color: Colors.black,
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
                      width: 150,
                      height: 50,
                      child: CustomButton(
                        text: "Enter",
                        onPressed: () => sendPhoneNumber(context),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/signin'),
                            child: const Text('Login as Traveller')),
                        const SizedBox(
                          width: 10.0,
                        ),
                        ElevatedButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/signin/agent'),
                            child: const Text('Login as Agent')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void sendPhoneNumber(BuildContext context) async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();

    final signinRoute = ModalRoute.of(context)!.settings.name;
    ap.signInWithPhone(
        context, "+${selectedCountry.phoneCode}$phoneNumber", signinRoute!);
  }
}
