import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';

class FlutterwavePayment extends StatefulWidget {
  const FlutterwavePayment({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _FlutterwavePaymentState createState() => _FlutterwavePaymentState();
}

class _FlutterwavePaymentState extends State<FlutterwavePayment> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = '';

  bool isDebug = true;

  @override
  Widget build(BuildContext context) {
    currencyController.text = selectedCurrency;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: TextFormField(
                controller: amountController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(hintText: 'Amount'),
                validator: (value) =>
                    value!.isNotEmpty ? null : 'Amount is required',
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: TextFormField(
                controller: currencyController,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                readOnly: true,
                onTap: _openBottomSheet,
                decoration: InputDecoration(
                  hintText: 'Currency',
                ),
                validator: (value) =>
                    value!.isNotEmpty ? null : 'Currency is required',
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: TextFormField(
                controller: publicKeyController,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Public Key',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: TextFormField(
                controller: encryptionKeyController,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Encryption Key',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) =>
                    value!.isNotEmpty ? null : 'Email is required',
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: TextFormField(
                controller: phoneNumberController,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                ),
                validator: (value) =>
                    value!.isNotEmpty ? null : 'Phone Number is required',
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Use Debug'),
                  Switch(
                    onChanged: (value) => {
                      setState(() {
                        isDebug = value;
                      })
                    },
                    value: isDebug,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: RaisedButton(
                onPressed: _onPressed,
                color: Colors.blue,
                child: Text(
                  'Make Payment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.;
  }

  // ignore: always_declare_return_types
  _onPressed() {
    if (formKey.currentState!.validate()) {
      _handlePaymentInitialization();
    }
  }

  // ignore: always_declare_return_types
  _handlePaymentInitialization() async {
    final flutterwave = Flutterwave.forUIPayment(
        amount: amountController.text.toString().trim(),
        currency: currencyController.text,
        context: context,
        publicKey: publicKeyController.text.trim(),
        encryptionKey: encryptionKeyController.text.trim(),
        email: emailController.text.trim(),
        fullName: 'Test User',
        txRef: DateTime.now().toIso8601String(),
        narration: 'Example Project',
        isDebugMode: isDebug,
        phoneNumber: phoneNumberController.text.trim(),
        acceptAccountPayment: true,
        acceptCardPayment: true,
        acceptUSSDPayment: true);
    final response = await flutterwave.initializeForUiPayments();
    // ignore: unnecessary_null_comparison
    if (response != null) {
      showLoading(response.data!.status!);
    } else {
      showLoading('No Response!');
    }
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = [
      FlutterwaveCurrency.UGX,
      FlutterwaveCurrency.GHS,
      FlutterwaveCurrency.NGN,
      FlutterwaveCurrency.RWF,
      FlutterwaveCurrency.KES,
      FlutterwaveCurrency.XAF,
      FlutterwaveCurrency.XOF,
      FlutterwaveCurrency.ZMW
    ];
    return Container(
      height: 250,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {_handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  // ignore: always_declare_return_types
  _handleCurrencyTap(String currency) {
    setState(() {
      selectedCurrency = currency;
      currencyController.text = currency;
    });
    Navigator.pop(context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
