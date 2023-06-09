class PhoneNumberValidator {
  PhoneNumberValidator({ required this.phoneValue });

  String phoneValue;

  String? validateMobile(String phoneValue) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (phoneValue.isEmpty) {
          return 'Please enter phone number';
    }
    else if (!regExp.hasMatch(phoneValue)) {
      return 'Please enter valid phone number';
    }
    return null;
  } 
}