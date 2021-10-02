import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/preferences.dart';
import '../utils/size_config.dart';
import '../widgets/account_details.dart';
import '../widgets/account_details_auth.dart';
import '../widgets/app_header.dart';
import '../widgets/dialog.dart';
import '../widgets/language_picker_widget.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  //  LaundryProvider _laundryProvider = LaundryProvider();
  late UserProvider _userProvider;

  Preference prefs = Preference();

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
              title: AppLocalizations.of(context)!.accounts,
              bg: Constants.primaryColor,
              textColor: Constants.white,
              onCloseClicked: () =>
                  Navigator.of(context).pushNamed('/category'),
              backgroundColor: Constants.primaryColor)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            user == null
                ? const AccountDetails()
                : user.blocked != true
                    ? const AccountDetailsAuth()
                    : const Text(
                        'Your account has been blocked reach out to support'),
            Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: Column(children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0.0),
                          child: Text(
                              AppLocalizations.of(context)!.settings.toString(),
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 5,
                                  fontWeight: FontWeight.bold)))),
                  const DialogBox(),
                  GestureDetector(
                      // onTap: () => Navigator.of(context).pushNamed('/signup'),
                      child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                          child: Row(children: [
                            Icon(Icons.file_copy,
                                color: Colors.pink,
                                size: 30.0,
                                semanticLabel: AppLocalizations.of(context)!
                                    .terms_of_service
                                    .toString()),
                            Text(
                                AppLocalizations.of(context)!
                                    .terms_of_service
                                    .toString(),
                                style: TextStyle(color: Constants.black)),
                          ]))),
                  GestureDetector(
                      // onTap: () => Navigator.of(context).pushNamed('/signup'),
                      child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                          child: Row(children: [
                            Icon(Icons.file_copy_sharp,
                                color: Colors.pink,
                                size: 30.0,
                                semanticLabel: AppLocalizations.of(context)!
                                    .privacy_policy
                                    .toString()),
                            Text(
                                AppLocalizations.of(context)!
                                    .privacy_policy
                                    .toString(),
                                style: TextStyle(color: Constants.black)),
                          ]))),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                      child: Row(children: [
                        const LanguagePickerWidget(),
                        Text(AppLocalizations.of(context)!.language,
                            style: TextStyle(color: Constants.black)),
                      ])),
                  GestureDetector(
                      onTap: () {
                        print('LOG OUT !!!');
                        //TODO: clear products in cart
                        //prefs.clearPrefs();
                        prefs.removePref('JWT');
                        _userProvider.setCurrentUser(null);
                        Navigator.of(context).pushNamed('/category');
                      },
                      child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
                          child: Row(children: [
                            Icon(Icons.logout,
                                color: Colors.pink,
                                size: 30.0,
                                semanticLabel: AppLocalizations.of(context)!
                                    .privacy_policy
                                    .toString()),
                            Text('LOGOUT',
                                style: TextStyle(color: Constants.black)),
                          ]))),
                ])),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     const LanguagePickerWidget(),
            //     Text(
            //       AppLocalizations.of(context)!.language,
            //     ),
            //     Text(AppLocalizations.of(context)!.helloWorld),
            //     Text(
            //       AppLocalizations.of(context)!.accounts,
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  /// RESET

}
