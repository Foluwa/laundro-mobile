import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../api/user.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../widgets/Buttons/button_widget.dart';
import '../widgets/app_header.dart';
import '../widgets/common.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  // Declare Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController homeAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // Chnage password
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Form key
  final _formKey = GlobalKey<FormState>();
  //UserApi api = UserApi();
  UserApi api = UserApi(addAccessToken: true);

  bool _updateAccountStatus = true;
  bool _updatePasswordStatus = true;
  bool accountBtnLoading = false;
  bool passwordBtnLoading = false;

  final FocusNode myFocusNode = FocusNode();
  late UserProvider _userProvider;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    print('USER ${_userProvider.getUser}');
    final user = _userProvider.getUser;

    emailController.text = user!.email;
    firstNameController.text = user.first_name;
    lastNameController.text = user.last_name;
    homeAddressController.text = user.home_address;
    phoneNumberController.text = user.phone_number;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppHeader(
                elevation: 0,
                fontSize: 25.0,
                title: AppLocalizations.of(context)!.accounts,
                bg: Constants.primaryColor,
                textColor: Constants.white,
                onCloseClicked: () => Navigator.pop(context),
                backgroundColor: Constants.primaryColor)),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text('Personal Information',
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 5,
                                  fontWeight: FontWeight.bold)),
                          _updateAccountStatus
                              ? _getEditIcon(accountBtnLoading, () {
                                  if (mounted) {
                                    setState(() {
                                      _updateAccountStatus = false;
                                    });
                                  }
                                })
                              : Container()
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                              child: TextFormField(
                                  controller: emailController,
                                  readOnly: true,
                                  style: const TextStyle(color: Colors.grey),
                                  decoration: const InputDecoration(
                                      hintText: 'Email Address'),
                                  enabled: !_updateAccountStatus))
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 20.0),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                                child: TextFormField(
                                    controller: firstNameController,
                                    decoration: const InputDecoration(
                                        hintText: 'First Name'),
                                    enabled: !_updateAccountStatus,
                                    autofocus: !_updateAccountStatus))
                          ])),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 20.0),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                                child: TextFormField(
                                    controller: lastNameController,
                                    decoration: const InputDecoration(
                                        hintText: 'Last Name'),
                                    enabled: !_updateAccountStatus,
                                    autofocus: !_updateAccountStatus)),
                          ])),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                              child: TextFormField(
                                  controller: phoneNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: 'Phone Number'),
                                  enabled: !_updateAccountStatus))
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 20.0, bottom: 10.0),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                                child: TextFormField(
                              controller: homeAddressController,
                              decoration: const InputDecoration(
                                  hintText: 'Home Address'),
                              enabled: !_updateAccountStatus,
                            )),
                          ])),
                  !_updateAccountStatus
                      ? _getActionButtons(updateAccount, () {
                          if (mounted) {
                            setState(() {
                              accountBtnLoading = false;
                              _updateAccountStatus = true;
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                          }
                        })
                      : Container(),
                  /*  Padding(
                    padding:
                        const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            // ignore: lines_longer_than_80_chars
                            padding: const EdgeInsets.only(right: 10.0),
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(hintText: 'Password'),
                              enabled: !_updateAccountStatus,
                              obscureText: true,
                            ),
                          ),
                          flex: 2,
                        ),
                        Flexible(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(hintText: 'Confirm Password'),
                            enabled: !_updateAccountStatus,
                            obscureText: true,
                          ),
                          flex: 2,
                        ),
                      ],
                    )),*/
                ],
              ),
            ),
            Form(
                child: Column(children: [
              Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text('Change Password',
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 5,
                              fontWeight: FontWeight.bold)),
                      _updatePasswordStatus
                          ? _getEditIcon(passwordBtnLoading, () {
                              if (mounted) {
                                setState(() {
                                  _updatePasswordStatus = false;
                                });
                              }
                            })
                          : Container()
                    ],
                  )),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: TextFormField(
                                controller: currentPasswordController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: 'Current Password'),
                                enabled: !_updatePasswordStatus)),
                      ])),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                            child: TextFormField(
                                controller: newPasswordController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: 'New Password'),
                                enabled: !_updatePasswordStatus)),
                      ])),
              Padding(
                //padding: const EdgeInsets.all(8.0),
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        child: TextFormField(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Confirm Password'),
                            enabled: !_updatePasswordStatus)),
                  ],
                ),
              ),
              !_updatePasswordStatus
                  ? _getActionButtons(updatePassword, () {
                      if (mounted) {
                        setState(() {
                          passwordBtnLoading = false;
                          _updatePasswordStatus = true;
                          FocusScope.of(context).requestFocus(FocusNode());
                        });
                      }
                    })
                  : Container(),
            ]))
          ],
        )));
  }

  //account_page
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  ///  Action Edit Btn
  Widget _getActionButtons(updateAction, cancelAction) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ButtonWidget(
                      text: 'Save',
                      color: Constants.white,
                      btnStatus: false,
                      onClicked: updateAction, //updateAccount,
                      style: const TextStyle(),
                      paddingValue: 8))),
          Expanded(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ButtonWidget(
                    text: 'Cancel',
                    color: Colors.red,
                    btnStatus: false,
                    onClicked: cancelAction,
                    style: const TextStyle(),
                    paddingValue: 8,
                  ))),
        ],
      ),
    );
  }

  /// Action Edit status
  Widget _getEditIcon(btnLoadingStatus, action) {
    return GestureDetector(
        child: btnLoadingStatus //btnLoading
            ? const SizedBox(
                height: 20.0, width: 20.0, child: CircularProgressIndicator())
            : CircleAvatar(
                backgroundColor: Colors.red,
                radius: 14.0,
                child: Icon(
                  Icons.edit,
                  color: Constants.white,
                  size: 16.0,
                )),
        onTap: action
        // onTap: () {
        //   if (mounted) {
        //     setState(() {
        //       _updateAccountStatus = false;
        //     });
        //   }
        // },
        );
  }

  /// Update Account Dtails
  void updateAccount() async {
    print('SAVE WAS CLICKED!!');
    if (mounted) {
      setState(() {
        accountBtnLoading = true;
        _updateAccountStatus = true;
        FocusScope.of(context).requestFocus(FocusNode());
      });
    }

    //TODO: Check if user is putting emojis in comment it is causing 500 error
    // get all the data
    final data = {
      'firstName': firstNameController.text.toString(),
      'lastName': lastNameController.text.toString(),
      'homeAddress': homeAddressController.text.toString(),
      'phoneNumber': phoneNumberController.text.toString()
    };

    // Make request
    await api.updateInfo(_userProvider.getUser!.id, data).then((user) {
      print('USER_UPDATED_DATA $user');
      _userProvider.setCurrentUser(user);

      Common.showSnackBar(context,
          title: 'Profile updated successfully', duration: 3000);
    }).catchError((error) {
      print('${error}');
      Common.showSnackBar(context,
          //  'Profile NOT updated successfully'
          title: 'Error encountered',
          duration: 300);
    });

    // Setting state
    if (mounted) {
      setState(() {
        accountBtnLoading = false;
      });
    }
  }

  /// Update Password
  void updatePassword() async {
    print('SAVE WAS CLICKED!!');
    if (mounted) {
      setState(() {
        passwordBtnLoading = true;
        _updatePasswordStatus = true;
        FocusScope.of(context).requestFocus(FocusNode());
      });
    }

    // check if password match
    if (newPasswordController.text.toString() !=
        confirmPasswordController.text.toString()) {
      Common.showSnackBar(context,
          title: 'Password does not match successfully', duration: 3000);
      return;
    }

    final data = {
      'identifier': emailController.text.toString(),
      'password': currentPasswordController.text.toString(),
      'newPassword': newPasswordController.text.toString(),
      'confirmPassword': confirmPasswordController.text.toString()
    };
    await api.changePassword(data).then((user) {
      print('USER_UPDATED_DATA $user');

      ///TODO: Reset the JWT too from the response
      _userProvider.setCurrentUser(user);
      Common.showSnackBar(context,
          title: 'Password changed successfully', duration: 3000);
    }).catchError((error) {
      print('${error}');
      Common.showSnackBar(context,
          //  'Error updating password'
          title: 'Error encountered',
          duration: 3000);
    });

    // simulate delay
    // Timer(const Duration(seconds: 5), () {
    //   print(' This line is execute after 5 seconds');
    //   if (mounted) {
    //     setState(() {
    //       passwordBtnLoading = false;
    //       _updatePasswordStatus = true;
    //       FocusScope.of(context).requestFocus(FocusNode());
    //     });
    //   }
    // });
  }
}
