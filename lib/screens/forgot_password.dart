import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/constants.dart';
import '../utils/form_validator.dart';
import '../widgets/InputWidgets/input_widget.dart';
import '../widgets/app_header.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool btnLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Constants.primaryColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppHeader(
              elevation: 0,
              fontSize: 25.0,
              title: 'Forgot Password',
              bg: Constants.primaryColor,
              textColor: Constants.white,
              onCloseClicked: () => Navigator.pop(context),
              backgroundColor: Constants.primaryColor)),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              //key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Forgot password',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black))
                      ],
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Column(
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

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: MaterialButton(
                          elevation: 5.0,
                          shape: btnLoading
                              ? const CircleBorder()
                              : RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.0)),
                          onPressed: () => btnLoading ? null : forgotPassword(),
                          padding: const EdgeInsets.all(12),
                          color: Constants.secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: btnLoading
                                ? CircularProgressIndicator(
                                    backgroundColor: Constants.white,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.yellow))
                                : const Text(
                                    'Sign In',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void forgotPassword() {
    print('forgot password was clicked');
  }
}
