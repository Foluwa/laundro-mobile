import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import 'Buttons/button_widget.dart';

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
  // Form key
  final _formKey = GlobalKey<FormState>();

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  late UserProvider _userProvider;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    print('USER ${_userProvider.getUser}');
    final user = _userProvider.getUser;

    //firstNameController.text = user!.phone_number;

    return Form(
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
                      //controller: firstNameController,
                      initialValue: user!.username,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                      enabled: !_status,
                      autofocus: !_status,
                    ),
                  ),
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
                      //controller: firstNameController,
                      // initialValue: user.first_name,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                      enabled: !_status,
                      autofocus: !_status,
                    ),
                  ),
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
                      // initialValue: user.email,
                      decoration:
                          const InputDecoration(hintText: 'Email Address'),
                      enabled: !_status,
                    ),
                  ),
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
                      //  initialValue: user.username,
                      decoration:
                          const InputDecoration(hintText: 'Phone Number'),
                      enabled: !_status,
                    ),
                  ),
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
                      decoration:
                          const InputDecoration(hintText: 'Home Address'),
                      enabled: !_status,
                    ),
                  ),
                ],
              )),
          Padding(
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
                        decoration: const InputDecoration(hintText: 'Password'),
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
              )),
          !_status ? _getActionButtons() : Container(),
        ],
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
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ButtonWidget(
                text: 'Save',
                color: Constants.white,
                btnStatus: false,
                onClicked: () {
                  print('SAVE WAS CLICKED!!');
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                style: const TextStyle(),
                paddingValue: 8,
              ),
              // child: RaisedButton(
              //   child: Text('Save'),
              //   textColor: Constants.white,
              //   color: Constants.primaryColor,
              //   onPressed: () {
              // print('SAVE WAS CLICKED!!');
              // setState(() {
              //   _status = true;
              //   FocusScope.of(context).requestFocus(FocusNode());
              // });
              //   },
              // ),
            ),
            flex: 2,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ButtonWidget(
                text: 'Cancel',
                //color: Constants.white,
                color: Colors.red,
                btnStatus: false,
                onClicked: () {
                  print('SAVE WAS CLICKED!!');
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                style: const TextStyle(),
                paddingValue: 8,

                // child: const Text('Cancel'),
                // textColor: Constants.white,
                // color: Colors.red,
                // onPressed: () {
                //   print('CANCEL WAS CLICKED!!');
                //   setState(() {
                //     _status = true;
                //     FocusScope.of(context).requestFocus(FocusNode());
                //   });
                // },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Constants.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
