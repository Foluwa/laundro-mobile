import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../providers/laundry_provider.dart';
import '../../utils/constants.dart';
import '../../utils/form_validator.dart';
import '../../widgets/Buttons/button_widget.dart';
import '../../widgets/InputWidgets/checkbox_option.dart';
import '../../widgets/InputWidgets/input_widget.dart';
import '../../widgets/app_header.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  // Declare Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  bool btnLoading = false;
  @override
  Widget build(BuildContext context) {
    final _laundryProvider = LaundryProvider();
    print(_laundryProvider.getCart);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppHeader(
            elevation: 0,
            fontSize: 25.0,
            title: 'Checkout',
            bg: const Color(0xFF607D8B),
            textColor: Constants.white,
            onCloseClicked: () => Navigator.pop(context),
            backgroundColor: const Color(0xFF607D8B)),
      ),
      body: Column(
        children: [
          // checkbox fill from user data
          // ignore: lines_longer_than_80_chars
          CheckboxOption(
            title: 'Prefill from user data',
            newValue: true,
            onPressed: prefill,
            checkedValue: true,
          ),
          FormInput(
            label: 'Email Address',
            controller: _emailController,
            passwordVisible: false,
            obscureText: false,
            textValidator: FormValidate.validateEmail,
          ),
          FormInput(
            label: 'Full Name',
            controller: _fullName,
            passwordVisible: false,
            obscureText: false,
            textValidator: FormValidate.validateEmail,
          ),
          // names
          // address
          // phone number
          // delivery location
          // list of products

          // proceed to payment
          ButtonWidget(
              text: 'Checkout',
              onClicked: () => btnLoading ? null : checkoutCart(),
              color: Colors.amber,
              paddingValue: 6.0,
              btnStatus: btnLoading,
              style: const TextStyle())
        ],
      ),
      // body: ,
    );
  }

  void prefill() {}
  void checkoutCart() {}
}
