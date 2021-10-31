import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/user.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/form_validator.dart';
import '../utils/preferences.dart';
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
      //backgroundColor: Constants.primaryColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppHeader(
              elevation: 0,
              fontSize: 25.0,
              title: 'Sign Up',
              bg: Constants.primaryColor,
              textColor: Constants.white,
              onCloseClicked: () => Navigator.pop(context),
              backgroundColor: Constants.primaryColor)),
      body: SafeArea(
        // bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.of(context).pop();
                      //   },
                      //   child: const Icon(
                      //     // FlutterIcons.keyboard_backspace_mdi,
                      //     Icons.keyboard_arrow_down,
                      //     color: Colors.white,
                      //   ),
                      // ),

                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Create your account',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          onPressed: termsCondi(true)),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: MaterialButton(
                              elevation: 5.0,
                              shape: btnLoading
                                  ? const CircleBorder()
                                  : RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9.0)),
                              onPressed: () => btnLoading ? null : userSignUp(),
                              padding: const EdgeInsets.all(12),
                              color: Constants.secondaryColor,
                              child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: btnLoading
                                      ? CircularProgressIndicator(
                                          backgroundColor: Constants.white,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(Colors.yellow))
                                      : const Text('Register',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0))))),
                      // ButtonWidget(
                      //     text: 'Register',
                      //     //onClicked: () {},
                      //     onClicked: () =>
                      //         btnLoading ? null : userSignUp(),
                      //     color: Colors.amber,
                      //     paddingValue: 6.0,
                      //     btnStatus: btnLoading,
                      //     style: const TextStyle())

                      // Padding(
                      //   padding:
                      //   const EdgeInsets.symmetric(vertical: 3.0),
                      //   child: MaterialButton(
                      //     elevation: 5.0,
                      //     shape: btnLoading
                      //         ? const CircleBorder()
                      //         : RoundedRectangleBorder(
                      //         borderRadius:
                      //         BorderRadius.circular(9.0)),
                      //     onPressed: () =>
                      //     btnLoading ? null : userSignIn(),
                      //     padding: const EdgeInsets.all(12),
                      //     color: Constants.secondaryColor,
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(5.0),
                      //       child: btnLoading
                      //           ? CircularProgressIndicator(
                      //           backgroundColor: Constants.white,
                      //           valueColor:
                      //           const AlwaysStoppedAnimation<
                      //               Color>(Colors.yellow))
                      //           : const Text(
                      //         'Sign In',
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 18.0),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // DEFAULT BTN
                      // AppButton(
                      //   type: ButtonType.PRIMARY,
                      //   text: "Log In",
                      //   onPressed: () {
                      //     nextScreen(context, "/dashboard");
                      //   },
                      // )
                    ],
                  ),
                ],
              ),
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
        Navigator.of(context).pushNamed('/menu');
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
