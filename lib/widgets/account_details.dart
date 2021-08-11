import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0, 0.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0.0),
              child: const Text(
                'Account',
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/signup'),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    //color: Colors.pink,
                    size: 30,
                    semanticLabel: AppLocalizations.of(context)!
                        .create_new_account
                        .toString(), //'Create a new account',
                  ),
                  Text(
                    //'Create a new account',
                    AppLocalizations.of(context)!.create_new_account.toString(),
                    style: TextStyle(color: Colors.black),
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
                  Icon(
                    Icons.directions_transit,
                    color: Colors.pink,
                    size: 30.0,
                    semanticLabel: AppLocalizations.of(context)!
                        .sign_into_acount
                        .toString(),
                    //'Sign into an existing account',
                  ),
                  Text(
                    AppLocalizations.of(context)!.sign_into_acount.toString(),
                    //'Sign into an existing account',
                    style: TextStyle(color: Colors.black),
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
                  const Icon(
                    Icons.directions_transit,
                    color: Colors.pink,
                    size: 30.0,
                    semanticLabel: 'accessibility modes',
                  ),
                  Text(
                    AppLocalizations.of(context)!.reset_password.toString(),
                    //'Reset password ',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
