import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../api/user.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import 'Buttons/button_widget.dart';
import 'common.dart';

class AccountDetailsAuth extends StatefulWidget {
  const AccountDetailsAuth({Key? key}) : super(key: key);

  @override
  _AccountDetailsAuthState createState() => _AccountDetailsAuthState();
}

class _AccountDetailsAuthState extends State<AccountDetailsAuth> {
  // Declare Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController homeAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  // Form key
  final _formKey = GlobalKey<FormState>();
  //UserApi api = UserApi();
  UserApi api = UserApi(addAccessToken: true);

  bool _status = true;
  bool btnLoading = false;

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

    return Card(
      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text('Personal Information',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 5,
                            fontWeight: FontWeight.bold)),
                    _status ? _getEditIcon() : Container()
                  ],
                )),
            Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
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
                            enabled: !_status))
                  ],
                )),
            Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
                child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Flexible(
                      child: TextFormField(
                          controller: firstNameController,
                          decoration:
                              const InputDecoration(hintText: 'First Name'),
                          enabled: !_status,
                          autofocus: !_status))
                ])),
            Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
                child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Flexible(
                      child: TextFormField(
                          controller: lastNameController,
                          decoration:
                              const InputDecoration(hintText: 'Last Name'),
                          enabled: !_status,
                          autofocus: !_status)),
                ])),
            Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                        child: TextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: 'Phone Number'),
                            enabled: !_status))
                  ],
                )),
            Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 20.0, bottom: 10.0),
                child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Flexible(
                      child: TextFormField(
                    controller: homeAddressController,
                    decoration: const InputDecoration(hintText: 'Home Address'),
                    enabled: !_status,
                  )),
                ])),
            !_status ? _getActionButtons() : Container(),
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
                          enabled: !_status,
                          obscureText: true,
                        ),
                      ),
                      flex: 2,
                    ),
                    Flexible(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Confirm Password'),
                        enabled: !_status,
                        obscureText: true,
                      ),
                      flex: 2,
                    ),
                  ],
                )),*/
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
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
                      onClicked: updateAccount,
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
                    onClicked: () {
                      setState(() {
                        btnLoading = false;
                        _status = true;
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                    style: const TextStyle(),
                    paddingValue: 8,
                  ))),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: btnLoading
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
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  void updateAccount() async {
    print('SAVE WAS CLICKED!!');
    if (mounted) {
      setState(() {
        btnLoading = true;
        _status = true;
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
      print('SPENSER  ${error}');
      Common.showSnackBar(context,
          //  'Profile NOT updated successfully'
          title: 'Error encountered',
          duration: 300);
    });

    // Setting state
    if (mounted) {
      setState(() {
        btnLoading = false;
      });
    }
  }
}
