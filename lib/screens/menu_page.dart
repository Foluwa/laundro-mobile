import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/preferences.dart';
import '../utils/size_config.dart';
import '../utils/utils.dart';
import '../widgets/app_header.dart';
import '../widgets/menu.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  //  LaundryProvider _laundryProvider = LaundryProvider();
  late UserProvider _userProvider;

  Preference prefs = Preference();

  late Future<void> _launched;

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
                ? Column(
                    children: [
                      Menu(
                        text: 'Create Account',
                        icon: 'assets/icons/user_icon.svg',
                        //press: () => {},
                        press: () => Navigator.of(context).pushNamed('/signup'),
                      ),
                      Menu(
                        text: 'Sign Into Account',
                        icon: 'assets/icons/user_icon.svg',
                        press: () => Navigator.of(context).pushNamed('/signin'),
                      ),
                    ],
                  )
                : user.blocked != true
                    // ? AccountDetailsAuth()
                    ? Column(
                        children: [
                          Menu(
                            text: 'My Account',
                            icon: 'assets/icons/user_icon.svg',
                            press: () => Navigator.of(context)
                                .pushNamed('/account'), //account
                          ),
                          Menu(
                              text: 'My Orders',
                              icon: 'assets/icons/user_icon.svg',
                              press: () => Navigator.of(context)
                                  .pushNamed('/order_history') //order_history,
                              ),
                        ],
                      )
                    : const Text(
                        'Your account has been blocked reach out to support'),
            const SizedBox(height: 10.0),

            // Column
            Menu(
              text: 'Help',
              icon: 'assets/icons/user_icon.svg',
              press: () => {showSimpleDialog(context)},
            ),
            Menu(
              text: 'Privacy Policy',
              icon: 'assets/icons/user_icon.svg',
              press: () => {},
            ),
            Menu(
              text: 'Terms and conditions',
              icon: 'assets/icons/user_icon.svg',
              press: () => {},
            ),
            Menu(
              text: 'Log Out',
              icon: 'assets/icons/user_icon.svg',
              press: () {
                //TODO: clear products in cart
                //prefs.clearPrefs();
                prefs.removePref('JWT');
                _userProvider.setCurrentUser(null);
                Navigator.of(context).pushNamed('/category');
              },
            ),

            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(5.0),
            //         color: Colors.white,
            //         boxShadow: [
            //           const BoxShadow(
            //               color: Colors.grey,
            //               offset: Offset(0.0, 1.0),
            //               blurRadius: 6.0)
            //         ],
            //       ),
            //       child: Column(children: <Widget>[
            //         Align(
            //             alignment: Alignment.centerLeft,
            //             child: Container(
            //                 padding:
            //                     const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0.0),
            //                 child: Text(
            //                     AppLocalizations.of(context)!
            //                         .settings
            //                         .toString(),
            //                     style: TextStyle(
            //                         fontSize:
            //                             SizeConfig.blockSizeHorizontal * 5,
            //                         fontWeight: FontWeight.bold)))),
            //         const DialogBox(),
            //         GestureDetector(
            //             // onTap: () => Navigator.of(context).pushNamed('/signup'),
            //             child: Padding(
            //                 padding:
            //                     const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
            //                 child: Row(children: [
            //                   Icon(Icons.file_copy,
            //                       color: Colors.pink,
            //                       size: 30.0,
            //                       semanticLabel: AppLocalizations.of(context)!
            //                           .terms_of_service
            //                           .toString()),
            //                   Text(
            //                       AppLocalizations.of(context)!
            //                           .terms_of_service
            //                           .toString(),
            //                       style: TextStyle(color: Constants.black)),
            //                 ]))),
            //         GestureDetector(
            //             // onTap: () => Navigator.of(context).pushNamed('/signup'),
            //             child: Padding(
            //                 padding:
            //                     const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
            //                 child: Row(children: [
            //                   Icon(Icons.file_copy_sharp,
            //                       color: Colors.pink,
            //                       size: 30.0,
            //                       semanticLabel: AppLocalizations.of(context)!
            //                           .privacy_policy
            //                           .toString()),
            //                   Text(
            //                       AppLocalizations.of(context)!
            //                           .privacy_policy
            //                           .toString(),
            //                       style: TextStyle(color: Constants.black)),
            //                 ]))),
            //         Padding(
            //             padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
            //             child: Row(children: [
            //               const LanguagePickerWidget(),
            //               Text(AppLocalizations.of(context)!.language,
            //                   style: TextStyle(color: Constants.black)),
            //             ])),
            //         GestureDetector(
            //             onTap: () {
            //               print('LOG OUT !!!');
            //               //TODO: clear products in cart
            //               //prefs.clearPrefs();
            //               prefs.removePref('JWT');
            //               _userProvider.setCurrentUser(null);
            //               Navigator.of(context).pushNamed('/category');
            //             },
            //             child: Padding(
            //                 padding:
            //                     const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
            //                 child: Row(children: [
            //                   Icon(Icons.logout,
            //                       color: Colors.pink,
            //                       size: 30.0,
            //                       semanticLabel: AppLocalizations.of(context)!
            //                           .privacy_policy
            //                           .toString()),
            //                   Text('LOGOUT',
            //                       style: TextStyle(color: Constants.black)),
            //                 ]))),
            //       ]))),
          ],
        ),
      ),
    );
  }

  /// RESET

  void showSimpleDialog(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext cx) {
        return SimpleDialog(
          title: const Align(
              alignment: Alignment.center, child: Text('How can we help ?')),
          children: <Widget>[
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              onPressed: () {
                setState(() {
                  _launched = _openUrl('mailto:moronfoluwaakintola@gmail.com');
                });
                Utils.showSnackBar(context, title: 'Selected Option 1');
                Navigator.pop(context);
              },
              // ignore: lines_longer_than_80_chars
              child: const Text('Send us an email',
                  style: TextStyle(fontSize: 16)),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: const Text('Phone call', style: TextStyle(fontSize: 16)),
              onPressed: () {
                setState(() {
                  _launched = _openUrl('tel://2348169425505');
                });
                //Utils.showSnackBar(context, title: 'Selected Option 2');
                Navigator.pop(context);
              },
            ),
          ],
        );
      });

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
