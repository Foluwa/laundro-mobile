import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      // color: Colors.grey,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0.0),
              child: const Text(
                'Your details (Not Signed In)',
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
                  const Text(
                    'Sign into an existing account ',
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
                  const Text(
                    'Reset password ',
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
