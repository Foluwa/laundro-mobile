import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../api/user.dart';
import '../utils/form_validator.dart';
import 'Buttons/button_widget.dart';
import 'InputWidgets/input_widget.dart';
import 'common.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final _formKey = GlobalKey<FormState>();

  // Declare Controllers
  final TextEditingController emailController = TextEditingController();
  bool btnLoading = false;
  UserApi api = UserApi(addAccessToken: false);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: Column(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0.0),
                  child: const Text('Account'))),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/signup'),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
              child: Row(
                children: [
                  Icon(Icons.person,
                      color: Colors.pink,
                      size: 30,
                      semanticLabel: AppLocalizations.of(context)!
                          .create_new_account
                          .toString()),
                  Text(
                    AppLocalizations.of(context)!.create_new_account.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/signin'),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                  child: Row(
                    children: [
                      Icon(Icons.directions_transit,
                          color: Colors.pink,
                          size: 30.0,
                          semanticLabel: AppLocalizations.of(context)!
                              .sign_into_acount
                              .toString()),
                      Text(
                          AppLocalizations.of(context)!
                              .sign_into_acount
                              .toString(),
                          style: const TextStyle(color: Colors.black)),
                    ],
                  ))),
          GestureDetector(
              // onTap: () => Navigator.of(context).pushNamed('/signin'),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          content:
                              Stack(clipBehavior: Clip.none, children: <Widget>[
                        Positioned(
                            right: -40.0,
                            top: -40.0,
                            child: InkResponse(
                                onTap: () => Navigator.of(context).pop(),
                                child: const CircleAvatar(
                                    child: Icon(Icons.close),
                                    backgroundColor: Colors.red))),
                        Form(
                            key: _formKey,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FormInput(
                                          label: AppLocalizations.of(context)!
                                              .email
                                              .toString(),
                                          controller: emailController,
                                          passwordVisible: false,
                                          obscureText: false,
                                          textInputType: TextInputType.emailAddress,
                                          textValidator:
                                              FormValidate.validateEmail)),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ButtonWidget(
                                          text: 'Reset Password',
                                          onClicked: () => btnLoading
                                              ? null
                                              : userResetPassword(),
                                          color: Colors.amber,
                                          paddingValue: 6.0,
                                          btnStatus: btnLoading,
                                          style: const TextStyle()))
                                ])),
                      ]));
                    });
              },
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                  child: Row(children: [
                    const Icon(Icons.directions_transit,
                        color: Colors.pink,
                        size: 30.0,
                        semanticLabel: 'Forgot password'),
                    const Text('Forgot password',
                        style: TextStyle(color: Colors.black))
                  ])))
        ],
      ),
    );
  }

  void userResetPassword() async {
    print('I GOT HERE');
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      if (mounted) {
        setState(() {
          btnLoading = true;
        });
      }
      final data = {'email': emailController.text};
      print('DATA IS ${data.toString()}');
      await api.forgotPassword(data).then((response) {
        print('ForgotPassword ${response}');
        emailController.clear();
        // Navigator.of(context).pushNamed('/account');
        if (mounted) {
          setState(() {
            btnLoading = false;
          });
        }
      }).catchError((error) {
        print('ERROR CAUGHT ${error}');
        emailController.clear();
        if (mounted) {
          setState(() {
            btnLoading = false;
          });
        }
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
