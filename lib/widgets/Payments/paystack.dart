// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
//
// class PaystackPayment extends StatefulWidget {
//   const PaystackPayment({Key? key}) : super(key: key);
//
//   @override
//   _PaystackPaymentState createState() => _PaystackPaymentState();
// }
//
// class _PaystackPaymentState extends State<PaystackPayment> {
//   String paystackPublicKey = 'pk_test_35af153bab5dcc125e1f14e61dd87308fdd5df6f';
//   // secret sk_test_e2aedcbf15f38939ea8cc003b7c27765033bcbd0
//   final plugin = PaystackPlugin();
//
//   CheckoutMethod _method = CheckoutMethod.card; //selectable
//
//   bool _inProgress = false;
//   String? _cardNumber;
//   String? _cvv;
//   int? _expiryMonth;
//   int? _expiryYear;
//
//   @override
//   void initState() {
//     plugin.initialize(publicKey: paystackPublicKey);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
//
//   // ignore: always_declare_return_types
//   _updateStatus(String? reference, String message) {
//     _showMessage('Reference: $reference \n\ Response: $message',
//         const Duration(seconds: 7));
//   }
//
//   // ignore: always_declare_return_types
//   _showMessage(String message,
//       [Duration duration = const Duration(seconds: 4)]) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       duration: duration,
//       action: SnackBarAction(
//           label: 'CLOSE',
//           onPressed: () =>
//               ScaffoldMessenger.of(context).removeCurrentSnackBar()),
//     ));
//   }
//
//   PaymentCard _getCardFromUI() {
//     // Using just the must-required parameters.
//     return PaymentCard(
//       number: _cardNumber,
//       cvc: _cvv,
//       expiryMonth: _expiryMonth,
//       expiryYear: _expiryYear,
//     );
//
//     // Using Cascade notation (similar to Java's builder pattern)
// //    return PaymentCard(
// //        number: cardNumber,
// //        cvc: cvv,
// //        expiryMonth: expiryMonth,
// //        expiryYear: expiryYear)
// //      ..name = 'Segun Chukwuma Adamu'
// //      ..country = 'Nigeria'
// //      ..addressLine1 = 'Ikeja, Lagos'
// //      ..addressPostalCode = '100001';
//
//     // Using optional parameters
// //    return PaymentCard(
// //        number: cardNumber,
// //        cvc: cvv,
// //        expiryMonth: expiryMonth,
// //        expiryYear: expiryYear,
// //        name: 'Ismail Adebola Emeka',
// //        addressCountry: 'Nigeria',
// //        addressLine1: '90, Nnebisi Road, Asaba, Deleta State');
//   }
//
//   String _getReference() {
//     String platform;
//     if (Platform.isIOS) {
//       platform = 'iOS';
//     } else {
//       platform = 'Android';
//     }
//
//     return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
//   }
//
//   // ignore: always_declare_return_types
//   handleCheckout(BuildContext context) async {
//     // if (_method != CheckoutMethod.card && _isLocal) {
//     //   _showMessage('Select server initialization method at the top');
//     //   return;
//     // }
//     setState(() => _inProgress = true);
//     //_formKey.currentState?.save();
//     Charge charge = Charge()
//       ..amount = 10000 // In base currency
//       ..email = 'customer@email.com'
//       ..card = _getCardFromUI();
//
//     // if (!_isLocal) {
//     //   var accessCode = await _fetchAccessCodeFrmServer(_getReference());
//     //   charge.accessCode = accessCode;
//     // } else {
//     //   charge.reference = _getReference();
//     // }
//
//     charge.reference = _getReference();
//
//     try {
//       CheckoutResponse response = await plugin.checkout(
//         context,
//         method: _method,
//         charge: charge,
//         fullscreen: false,
//         logo: MyLogo(),
//       );
//       print('Response = $response');
//       setState(() => _inProgress = false);
//       _updateStatus(response.reference, '$response');
//     } catch (e) {
//       setState(() => _inProgress = false);
//       _showMessage('Check console for error');
//       rethrow;
//     }
//   }
// }

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class PaystackPayment {
  var plugin;
  PaystackPayment(this.plugin);
  String paystackPublicKey = 'pk_test_35af153bab5dcc125e1f14e61dd87308fdd5df6f';
  // secret sk_test_e2aedcbf15f38939ea8cc003b7c27765033bcbd0
  final CheckoutMethod _method = CheckoutMethod.card; //selectable

  // bool _inProgress = false;
  String? _cardNumber;
  String? _cvv;
  int? _expiryMonth;
  int? _expiryYear;

  // ignore: always_declare_return_types
  // _updateStatus(String? reference, String message) {
  //   _showMessage('Reference: $reference \n\ Response: $message',
  //       const Duration(seconds: 7));
  // }

  // ignore: always_declare_return_types
  // _showMessage(String message,
  //     [Duration duration = const Duration(seconds: 4)]) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(message),
  //     duration: duration,
  //     action: SnackBarAction(
  //         label: 'CLOSE',
  //         onPressed: () =>
  //             ScaffoldMessenger.of(context).removeCurrentSnackBar()),
  //   ));
  // }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  // ignore: always_declare_return_types
  handleCheckout(BuildContext context) async {
    var charge = Charge()
      ..amount = 10000 // In base currency
      ..email = 'customer@email.com'
      ..card = _getCardFromUI();

    charge.reference = _getReference();

    try {
      final CheckoutResponse response = await plugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: false,
        logo: const BrandLogo(),
      );
      print('Response = $response');
      // setState(() => _inProgress = false);
      // _updateStatus(response.reference, '$response');
    } catch (e) {
      // setState(() => _inProgress = false);
      // _showMessage('Check console for error');
      rethrow;
    }
  }
}

class BrandLogo extends StatelessWidget {
  const BrandLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: const Text(
        'CO',
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
