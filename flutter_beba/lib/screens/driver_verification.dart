import 'dart:io';

import 'package:beba_app/model/driver_model.dart';
import 'package:beba_app/model/user_model.dart';
import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/screens/home_screen.dart';
import 'package:beba_app/utils/utils.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverVerificationForm extends StatefulWidget {
  const DriverVerificationForm({super.key});

  @override
  State<DriverVerificationForm> createState() => _DriverVerificationFormState();
}

class _DriverVerificationFormState extends State<DriverVerificationForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final ntsaNumberController = TextEditingController();
  final idNumberController = TextEditingController();
  final plateNumberController = TextEditingController();
  final roleController = TextEditingController();
  final selectedRouteController = TextEditingController();
  File? idImage;
  File? ntsaImage;
  File? driverImage;
  File? vehicleImage;

  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    licenseNumberController.dispose();
    ntsaNumberController.dispose();
    idNumberController.dispose();
    plateNumberController.dispose();
    roleController.dispose();
    selectedRouteController.dispose();
  }

  void selectImage() async {
    idImage = await pickImage(context);
    ntsaImage = await pickImage(context);
    driverImage = await pickImage(context);
    vehicleImage = await pickImage(context);
    setState(() {});
  }

  String routePlaceholder = 'NRB-ELD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Driver Verification Form',
              style: TextStyle(
                fontFamily: 'SpaceMono',
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '- Fill details carefully',
              style: TextStyle(
                fontFamily: 'SpaceMono',
                fontSize: 15.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(children: [
                              textField(
                                hintText: "Jane Doe",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: nameController,
                              ),
                              textField(
                                hintText: "+25471234567",
                                icon: Icons.phone,
                                inputType: TextInputType.phone,
                                maxLines: 1,
                                controller: phoneNumberController,
                              ),
                              textField(
                                hintText: 'License Number',
                                icon: Icons.numbers,
                                inputType: TextInputType.text,
                                maxLines: 1,
                                controller: licenseNumberController,
                              ),
                              textField(
                                hintText: 'NTSA Number',
                                icon: Icons.numbers,
                                inputType: TextInputType.text,
                                maxLines: 1,
                                controller: ntsaNumberController,
                              ),
                              textField(
                                hintText: 'ID Number',
                                icon: Icons.numbers,
                                inputType: TextInputType.text,
                                maxLines: 1,
                                controller: idNumberController,
                              ),
                              textField(
                                hintText: 'Plate Number',
                                icon: Icons.numbers,
                                inputType: TextInputType.text,
                                maxLines: 1,
                                controller: plateNumberController,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text('Upload ID: '),
                                    ImagePickerButton(),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text('Upload NTSA: '),
                                    ImagePickerButton(),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text('Upload driver Image: '),
                                    ImagePickerButton(),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text('Upload vehicle Image: '),
                                    ImagePickerButton(),
                                  ],
                                ),
                              ),
                            ]))
                      ]),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _storeData();
                }

                showSnackBar(context,
                    'Form submitted Successfully. Please await verification');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(fontSize: 18.0),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.black,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.white60,
          filled: true,
        ),
      ),
    );
  }

  Future<void> _storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    DriverModel driverModel = DriverModel(
      uid: "",
      fullName: nameController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      licenseNumber: licenseNumberController.text.trim(),
      ntsaNumber: ntsaNumberController.text.trim(),
      idNumber: idNumberController.text.trim(),
      plateNumber: plateNumberController.text.trim(),
      role: roleController.text.trim(),
      selectedRoute: "",
      idImage: "",
      ntsaImage: "",
      driverImage: "",
      vehicleImage: "",
    );
    if (driverImage != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child:
                CircularProgressIndicator(), // Show a circular progress indicator
          );
        },
      );

      await ap.saveUserDataToFirebase(
        context: context,
        userModel: driverModel as UserModel,
        profilePic: driverImage!,
        userType: UserType.driver,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );

      Navigator.of(_dialogKey.currentContext!)
          .pop(); // Hide the progress indicator
    } else {
      showSnackBar(context, "Please update your profile pic");
    }
  }
}
