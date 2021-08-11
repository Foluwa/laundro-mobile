import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../api/user.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/form_validator.dart';
import '../../utils/preferences.dart';
import '../../widgets/Buttons/button_widget.dart';
import '../../widgets/InputWidgets/input_widget.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Declare Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
    emailController.text = 'moronfoluwaakintola@gmail.com';
    passwordController.text = 'postman';
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppHeader(
              elevation: 0,
              fontSize: 25.0,
              title: 'Sign In',
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
                  label: AppLocalizations.of(context)!
                      .email
                      .toString(), //'Email Address',
                  controller: emailController,
                  passwordVisible: false,
                  obscureText: false,
                  textValidator: FormValidate.validateEmail,
                ),
                FormInput(
                  label: AppLocalizations.of(context)!
                      .password
                      .toString(), //'Password',
                  controller: passwordController,
                  passwordVisible: true,
                  obscureText: true,
                  textValidator: FormValidate.validatePassword,
                ),
                ButtonWidget(
                    text: 'Sign In',
                    onClicked: () => btnLoading ? null : userSignIn(),
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

  void userSignIn() async {
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
        'identifier': emailController.text,
        'password': passwordController.text,
      };
      print('DATA IS ${data.toString()}');

      await api.authenticateUser(jsonEncode(data)).then((user) {
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
