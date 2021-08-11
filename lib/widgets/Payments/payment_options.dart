import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PaymentPlatforms { flutterwave, stripe, paytm }

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({Key? key}) : super(key: key);

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  PaymentPlatforms? _paymentPlatforms = PaymentPlatforms.flutterwave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: const Text('Flutterwave'),
            leading: Radio<PaymentPlatforms>(
                value: PaymentPlatforms.flutterwave,
                groupValue: _paymentPlatforms,
                onChanged: (PaymentPlatforms? value) {
                  setState(() {
                    _paymentPlatforms = value;
                  });
                })),
        ListTile(
            title: const Text('Stripe'),
            leading: Radio<PaymentPlatforms>(
                value: PaymentPlatforms.stripe,
                groupValue: _paymentPlatforms,
                onChanged: (PaymentPlatforms? value) {
                  setState(() {
                    _paymentPlatforms = value;
                  });
                })),
        ListTile(
            title: const Text('Paytm'),
            leading: Radio<PaymentPlatforms>(
                value: PaymentPlatforms.paytm,
                groupValue: _paymentPlatforms,
                onChanged: (PaymentPlatforms? value) {
                  setState(() {
                    _paymentPlatforms = value;
                  });
                }))
      ],
    );
  }
}
