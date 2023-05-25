import 'package:beba_app/utils/utils.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class AgentRegistration extends StatefulWidget {
  const AgentRegistration({Key? key}) : super(key: key);

  @override
  State<AgentRegistration> createState() => _AgentRegistrationState();
}

class _AgentRegistrationState extends State<AgentRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _fullName;
  String? _idNo;
  String? _phoneNumber;
  String? _location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Agent Registration',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _fullName = value;
                },
              ),
              const SizedBox(
                height: 5.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ID No'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your ID number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _idNo = value;
                },
              ),
              const SizedBox(
                height: 5.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value;
                },
              ),
              const SizedBox(
                height: 5.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
                onSaved: (value) {
                  _location = value;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Row(
                  children: [
                    Text(
                      'Upload ID:',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    ImagePickerButton(),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   _formKey.currentState!.save();
                  //   // TODO: Handle form submission
                  //   Navigator.pushNamed(context, '/agentdashboard');
                  // }
                  showSnackBar(context,
                      'Thank you for your interest in supervising Beba.');
                  showSnackBar(
                      context, 'Please await verification notification.');
                  Navigator.pushNamed(context, '/agentdashboard');
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
