import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/user.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/form_validator.dart';
import '../../utils/preferences.dart';
import '../../widgets/Buttons/button_widget.dart';
import '../../widgets/InputWidgets/checkbox_option.dart';
import '../../widgets/InputWidgets/input_widget.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Declare Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // Form Controls
  late User user;
  final _formKey = GlobalKey<FormState>();
  bool btnLoading = false;
  UserApi api = UserApi();
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
                  // onSaved: (String value) => user.username = value,
                ),
                FormInput(
                  label: 'Email Address',
                  controller: emailController,
                  passwordVisible: false,
                  obscureText: false,
                  textValidator: FormValidate.validateEmail,
                ),
                FormInput(
                  label: 'Phone Number',
                  controller: phoneNumberController,
                  passwordVisible: false,
                  obscureText: false,
                  textValidator: FormValidate.validatePhoneNumber,
                  //onSaved: (String value) => user = value,
                ),
                FormInput(
                  label: 'Password',
                  controller: passwordController,
                  passwordVisible: true,
                  obscureText: true,
                  textValidator: FormValidate.validatePassword,
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
    print('I GOT HERE');
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
        'role': 'authenticated',
        'password': passwordController.text,
      };
      print('DATA IS ${data.toString()}');
      await api.registerUser(jsonEncode(data)).then((user) {
        print('INSIDE AWAIT2 ${data}');
        print('INSIDE AWAIT ${data.entries}');
        // preference
        prefs.setJWT(user.jwt);
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
