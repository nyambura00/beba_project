import 'dart:io';

import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/routes_selection.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class DriverVerificationForm extends StatefulWidget {
  const DriverVerificationForm({super.key});

  @override
  State<DriverVerificationForm> createState() => _DriverVerificationFormState();
}

class _DriverVerificationFormState extends State<DriverVerificationForm> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _idNumber = '';
  String _licenseNumber = '';
  final String _plateNumber = '';
  // late final _imageAddress = '';

  String routePlaceholder = 'NRB-ELD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text('Driver Verification Form',
                    style: TextStyle(
                        fontFamily: 'SpaceMono',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox( height: 20.0,),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'As per ID',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0, // set the width here
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _fullName = value!;
                    },
                  ),
                  // TODO: Attach Driver image
                  const SizedBox( height: 10.0, ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'License Number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your license number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _licenseNumber = value!;
                    },
                  ),
                  const SizedBox( height: 10.0, ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'NTSA Number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your NTSA number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _licenseNumber = value!;
                    },
                  ),
                  // TODO: Attach NTSA image
                  const SizedBox( height: 10.0, ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ID Number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your ID Number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _idNumber = value!;
                    },
                  ),
                  // TODO: Attach ID image
                  const SizedBox( height: 10.0, ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Plate Number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Car Plate Number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _idNumber = value!;
                    },
                  ),
                  const SizedBox( height: 10.0, ),
                  Row(
                    children: [
                      const Text('Select Route: ',
                        style: TextStyle(fontFamily: 'SpaceMono', fontSize: 20.0),
                      ),
                      RoutesSelection(
                        onSelectOption: (String placeholder) { routePlaceholder = placeholder; },
                        options: const [],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Get an image from the user's device
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        // Display the selected image in an Image widget
                        Image.file(File(pickedFile.path));
                      }
                    },
                    child: const Text('Attach Vehicle Image'),
                  ),
                  const SizedBox(height: 7.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _verifyDriver(context);
                      }

                      Navigator.pushNamed(context, '/driverhome');
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
          ),
        ],
      ),
    );
  }

  void _verifyDriver(BuildContext context) {
    // Perform verification logic here, e.g. making an API call
    // to check if the driver's details are valid

    // If the verification succeeds, navigate to the driver dashboard
    Navigator.pushNamed(context, '/driverdashboard');
  }
}