import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/widgets/Payments/radio_list_tile.dart';
import 'package:provider/provider.dart';

import '../../providers/laundry_provider.dart';

class PaymentPlatforms {
  String platform;
  int index;
  PaymentPlatforms({required this.platform, required this.index});
}

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({Key? key}) : super(key: key);

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  List<PaymentPlatforms> platforms = [
    PaymentPlatforms(index: 1, platform: 'flutterwave'),
    PaymentPlatforms(index: 2, platform: 'paystack'),
    PaymentPlatforms(index: 3, platform: 'razorpay'),
  ];

  LaundryProvider _laundryProvider = LaundryProvider();

  int _value = 0;

  @override
  Widget build(BuildContext context) {
    _laundryProvider = Provider.of<LaundryProvider>(context);
    return Column(
        children: platforms
            .map((item) => MyRadioListTile<int>(
                value: item.index,
                groupValue: _value,
                leading: '${item.platform[0].toUpperCase()}',
                title: Text(item.platform.toUpperCase()),
                onChanged: (value) {
                  setState(() => _value = value!);
                  print('SELECTED VALUE IS ${item.platform}');
                  _laundryProvider.setSelectedPayment(item.platform);
                }))
            .toList());
  }
}
