import 'package:flutter/material.dart';
import 'package:laundro/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/utils.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({Key? key}) : super(key: key);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  late Future<void> _launched;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => showSimpleDialog(context),
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
                'Help',
                style: TextStyle(color: Constants.black),
              ),
            ],
          ),
        ),
      );

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
                Utils.showSnackBar(context, title: 'Selected Option 2');
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
