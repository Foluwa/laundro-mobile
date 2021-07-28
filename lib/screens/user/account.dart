import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/laundry_provider.dart';
import '../../utils/size_config.dart';
import '../../widgets/app_header.dart';
import '../../widgets/dialog.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  LaundryProvider _laundryProvider = LaundryProvider();

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   final provider = Provider.of<LocaleProvider>(context, listen: false);
    //
    //   provider.clearLocale();
    // });
  }

  @override
  Widget build(BuildContext context) {
    _laundryProvider = Provider.of<LaundryProvider>(context);
    SizeConfig().init(context);
    // SizeConfig.safeBlockHorizontal * 7.65;
    print(SizeConfig.safeBlockHorizontal * 20.65);

    // print('ACCOUNT ${SizeConfig.safeBlockHorizontal * 6.45}');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppHeader(
          elevation: 0,
          fontSize: 25.0,
          title: 'Accounts',
          bg: Color(0xFF607D8B),
          textColor: Colors.black,
          onCloseClicked: () => Navigator.pop(context),
          backgroundColor: Color(0xFF607D8B),
          //backgroundColor: null,
        ),
      ),
      body: Column(
        children: [
          /// FRIST
          /// Create new account
          /// sign into an account
          /// reset password
          ///
          /// SECOND
          /// Help
          /// Terms of service
          /// Privacy policy
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
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/signup'),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.directions_transit,
                          color: Colors.pink,
                          size: 30,
                          semanticLabel: 'accessibility modes',
                        ),
                        const Text(
                          'Create a new account',
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
                          'Sign into an exisiting account ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

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
                DialogBox(),
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
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     const LanguagePickerWidget(),
          //     Text(
          //       AppLocalizations.of(context)!.language,
          //       style:
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
    );
  }
}
