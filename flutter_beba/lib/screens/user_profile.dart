import 'dart:io';

import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/model/user_model.dart';
import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/screens/home_screen.dart';
import 'package:beba_app/utils/utils.dart';
import 'package:beba_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? image;
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final bioController = TextEditingController();

  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    bioController.dispose();
  }

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: const AppbarWidget(),
          body: SafeArea(
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white70,
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 5.0),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                              onTap: () => selectImage(),
                              child: image == null
                                  ? const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/profile.png'),
                                      radius: 65,
                                      backgroundColor: Colors.white60)
                                  : CircleAvatar(
                                      backgroundImage: FileImage(image!),
                                      radius: 65,
                                    ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                textField(
                                  hintText: "Jane Doe",
                                  icon: Icons.account_circle,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: nameController,
                                ),
                                textField(
                                  hintText: "Enter bio here...",
                                  icon: Icons.edit,
                                  inputType: TextInputType.name,
                                  maxLines: 2,
                                  controller: bioController,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: CustomButton(
                              text: "Update Profile",
                              onPressed: () => storeData(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          bottomNavigationBar: const BottomNavigationBarWidget(),
        ),
      ],
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

  Future<void> storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
        bio: bioController.text.trim(),
        profilePic: "",
        uid: "",
        fullName: nameController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        role: "");
    if (image != null) {
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
        userModel: userModel,
        profilePic: image!,
        userType: UserType.defaultUser,
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
