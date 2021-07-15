import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/locale_provider.dart';
import '../../widgets/app_header.dart';
import '../../widgets/language_picker_widget.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<LocaleProvider>(context, listen: false);

      provider.clearLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppHeader(
          title: 'Accounts',
          elevation: 0,
          fontSize: 25.0,
          bg: Colors.blueGrey,
        ),
      ),
      body: Column(
        children: [
          LanguagePickerWidget(),
          Text(
            AppLocalizations.of(context).language,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).helloWorld,
            style: const TextStyle(fontSize: 36),
          ),
          const Center(
            child: Text('Accounts History'),
          ),
          const Center(
            child: Text('Accounts History'),

            /// FRIST
            /// Create new account
            /// sign into an account
            /// reset password
            ///
            /// SECOND
            /// Help
            /// Terms of service
            /// Privacy policy
          ),
        ],
      ),
    );
  }
}
