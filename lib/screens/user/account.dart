import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../../widgets/account_details.dart';
import '../../widgets/account_details_auth.dart';
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
              textColor: Constants.white,
              onCloseClicked: () => Navigator.of(context).pushNamed('/'),
              backgroundColor: const Color(0xFF607D8B))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            user == null
                ? const AccountDetails()
                : user.blocked != true
                    ? const AccountDetailsAuth()
                    : const Text(
                        'Your account has been blocked reach out to support'),

            Container(
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0, 0.0),
                // color: Constants.white,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0.0),
                        child: Text('Settings',
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 5,
                                fontWeight: FontWeight.bold)),
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
                            Text(
                              'Terms of service',
                              style: TextStyle(color: Constants.black),
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
                            Text(
                              'Privacy policy',
                              style: TextStyle(color: Constants.black),
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
                            Text(
                              'Change Language',
                              style: TextStyle(color: Constants.black),
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
}
