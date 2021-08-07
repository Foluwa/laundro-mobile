import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/Buttons/button_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../../widgets/account_details.dart';
import '../../widgets/app_header.dart';
import '../../widgets/dialog.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  //  LaundryProvider _laundryProvider = LaundryProvider();
  late UserProvider _userProvider;
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(SizeConfig.safeBlockHorizontal * 20.65);
    _userProvider = Provider.of<UserProvider>(context);
    print('USER ${_userProvider.getUser}');
    final user = _userProvider.getUser;
    print('USER $user');

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppHeader(
              elevation: 0,
              fontSize: 25.0,
              title: 'Accounts',
              bg: const Color(0xFF607D8B),
              textColor: Colors.black,
              // onCloseClicked: () => Navigator.pop(context),
              onCloseClicked: () => Navigator.of(context).pushNamed('/'),
              backgroundColor: const Color(0xFF607D8B))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            user == null
                ? const AccountDetails()
                : user.blocked != true
                    ? Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 35.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Personal Information',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 6,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _status ? _getEditIcon() : Container()
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
                                      initialValue: user.username,
                                      //
                                      decoration: const InputDecoration(
                                        hintText: 'Full Name',
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      initialValue: user.email,
                                      decoration: const InputDecoration(
                                          hintText: 'Email Address'),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      initialValue: user.username,
                                      decoration: const InputDecoration(
                                          hintText: 'Phone Number'),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            hintText: 'Password'),
                                        enabled: !_status,
                                        obscureText: true,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: 'Confirm Password'),
                                      enabled: !_status,
                                      obscureText: true,
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          !_status ? _getActionButtons() : Container(),
                        ],
                      )
                    : const Text(
                        'Your account has been blocked reach out to support'),
            Container(
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0, 0.0),
                color: Colors.grey,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0.0),
                        child: const Text(
                          'Your details',
                        ),
                      ),
                    ),
                    const DialogBox(),
                    GestureDetector(
                      // onTap: () => Navigator.of(context).pushNamed('/signup'),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.directions_transit,
                              color: Colors.pink,
                              size: 30.0,
                              semanticLabel: 'accessibility modes',
                            ),
                            const Text(
                              'Terms of service',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      // onTap: () => Navigator.of(context).pushNamed('/signup'),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.directions_transit,
                              color: Colors.pink,
                              size: 30.0,
                              semanticLabel: 'accessibility modes',
                            ),
                            const Text(
                              'Privacy policy',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     const LanguagePickerWidget(),
            //     Text(
            //       AppLocalizations.of(context)!.language,
            //       style:
            // ignore: lines_longer_than_80_chars
            //           const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            //     ),
            //     Text(
            //       AppLocalizations.of(context)!.helloWorld,
            //       style: const TextStyle(fontSize: 16),
            //     ),
            //     Text(
            //       AppLocalizations.of(context)!.accounts,
            //       style: const TextStyle(fontSize: 16),
            //     ),
            //   ],
            // )
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
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
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
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                child: const Text('Cancel'),
                textColor: Constants.white,
                color: Colors.red,
                onPressed: () {
                  print('CANCEL WAS CLICKED!!');
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              )),
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
