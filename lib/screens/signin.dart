import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../api/user.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/form_validator.dart';
import '../utils/preferences.dart';
import '../widgets/InputWidgets/input_widget.dart';
import '../widgets/app_header.dart';
import '../widgets/common.dart';

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
  UserApi api = UserApi(addAccessToken: false);
  UserProvider _userProvider = UserProvider();
  Preference prefs = Preference();

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    emailController.text = 'aderonke@gmail.com';
    passwordController.text = 'postman';
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppHeader(
              elevation: 0,
              fontSize: 25.0,
              title: 'Sign In',
              bg: Constants.primaryColor,
              textColor: Constants.white,
              onCloseClicked: () => Navigator.pop(context),
              backgroundColor: Constants.primaryColor)),
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  right: 0.0,
                  top: -20.0,
                  child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                          'assets/images/washing_machine_illustration.png'))),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 15.0,
                        ),
                        child: Column(
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
                              'Log in to your account',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height - 180.0,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Lets make a generic input widget
                              FormInput(
                                label: AppLocalizations.of(context)!
                                    .email
                                    .toString(), //'Email Address',
                                controller: emailController,
                                passwordVisible: false,
                                obscureText: false,
                                textInputType: TextInputType.emailAddress,
                                textValidator: FormValidate.validateEmail,
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              FormInput(
                                label: AppLocalizations.of(context)!
                                    .password
                                    .toString(), //'Password',
                                controller: passwordController,
                                passwordVisible: true,
                                obscureText: true,
                                textInputType: TextInputType.text,
                                textValidator: FormValidate.validatePassword,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Forgot Password?',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: MaterialButton(
                                  elevation: 5.0,
                                  shape: btnLoading
                                      ? const CircleBorder()
                                      : RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                  onPressed: () =>
                                      btnLoading ? null : userSignIn(),
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
                                        : const Text(
                                            'Sign In',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0),
                                          ),
                                  ),
                                ),
                              ),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
        // prefs.setJWT(user.jwt);
        prefs.getJwt();
        print('GET JWTSSS ${prefs.getJwt()}');
        // provider
        _userProvider.setCurrentUser(user);
        Navigator.of(context).pushNamed('/account');
      }).catchError((error) {
        print('ERROR CAUGHT ${error}');
        Common.showSnackBar(context, title: error.toString(), duration: 3000);
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
