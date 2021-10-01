import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/user.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/form_validator.dart';
import '../utils/preferences.dart';
import '../widgets/Buttons/button_widget.dart';
import '../widgets/InputWidgets/checkbox.dart';
import '../widgets/InputWidgets/input_widget.dart';
import '../widgets/app_header.dart';
import '../widgets/common.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Declare Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController homeAddressController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // Form Controls
  late User user;
  final _formKey = GlobalKey<FormState>();
  bool btnLoading = false;
  UserApi api = UserApi(addAccessToken: false);
  UserProvider _userProvider = UserProvider();
  Preference prefs = Preference();

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppHeader(
              elevation: 0,
              fontSize: 25.0,
              title: 'Sign Up',
              bg: const Color(0xFF607D8B),
              textColor: Constants.white,
              onCloseClicked: () => Navigator.pop(context),
              backgroundColor: const Color(0xFF607D8B))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FormInput(
                  label: 'User Name',
                  controller: usernameController,
                  passwordVisible: false,
                  obscureText: false,
                  textValidator: FormValidate.validateName,
                  textInputType: TextInputType.text,
                  // onSaved: (String value) => user.username = value,
                ),
                FormInput(
                  label: 'First Name',
                  controller: firstNameController,
                  passwordVisible: false,
                  obscureText: false,
                  textValidator: FormValidate.validateName,
                  textInputType: TextInputType.text,
                ),
                FormInput(
                  label: 'Last Name',
                  controller: lastNameController,
                  passwordVisible: false,
                  obscureText: false,
                  textValidator: FormValidate.validateName,
                  textInputType: TextInputType.text,
                ),
                FormInput(
                  label: 'Email Address',
                  controller: emailController,
                  passwordVisible: false,
                  obscureText: false,
                  textValidator: FormValidate.validateEmail,
                  textInputType: TextInputType.emailAddress,
                ),
                FormInput(
                  label: 'Phone Number',
                  controller: phoneNumberController,
                  passwordVisible: false,
                  obscureText: false,
                  textValidator: FormValidate.validatePhoneNumber,
                  textInputType: TextInputType.phone,
                  //onSaved: (String value) => user = value,
                ),
                FormInput(
                  label: 'Home Address',
                  controller: homeAddressController,
                  passwordVisible: false,
                  obscureText: false,
                  textValidator: FormValidate.validateName,
                  textInputType: TextInputType.text,
                ),
                FormInput(
                  label: 'Password',
                  controller: passwordController,
                  passwordVisible: true,
                  obscureText: true,
                  textValidator: FormValidate.validatePassword,
                  textInputType: TextInputType.text,
                ),
                CheckboxOption(
                  title: 'Terms and conditions',
                  checkedValue: true,
                  newValue: true,
                  onPressed: termsCondi(true),
                ),
                ButtonWidget(
                    text: 'Register',
                    //onClicked: () {},
                    onClicked: () => btnLoading ? null : userSignUp(),
                    color: Colors.amber,
                    paddingValue: 6.0,
                    btnStatus: btnLoading,
                    style: const TextStyle())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Function(bool?)? termsCondi(bool value) {}

  void userSignUp() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      if (mounted) {
        setState(() {
          btnLoading = true;
        });
      }
      final data = {
        'email': emailController.text,
        'username': usernameController.text,
        'password': passwordController.text,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'phoneNumber': phoneNumberController.text,
        'homeAddress': homeAddressController.text,
        'role': 'authenticated',
      };
      await api.registerUser(jsonEncode(data)).then((user) {
        print('INSIDE AWAIT2 ${data}');
        print('INSIDE AWAIT ${data.entries}');
        // preference
        // prefs.setJWT(user.jwt);
        // provider
        _userProvider.setCurrentUser(user);
        Navigator.of(context).pushNamed('/account');
      }).catchError((error) {
        print('ERROR CAUGHT ${error}');
        Common.showSnackBar(context, title: error.toString(), duration: 300);
        // return error;
      });
      if (mounted) {
        setState(() {
          btnLoading = false;
        });
      }
    }
  }
}
