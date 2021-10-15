import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../api/laundry.dart';
import '../api/order.dart';
import '../models/location.dart';
import '../models/payment/flutterwave.dart';
import '../providers/laundry_provider.dart';
import '../providers/order_provider.dart';
import '../providers/user_provider.dart';
import '../utils/boxes.dart';
import '../utils/constants.dart';
import '../utils/form_validator.dart';
import '../utils/size_config.dart';
import '../utils/utils.dart';
import '../widgets/Buttons/button_widget.dart';
import '../widgets/InputWidgets/input_widget.dart';
import '../widgets/Payments/payment_options.dart';
import '../widgets/Payments/paystack.dart';
import '../widgets/app_header.dart';
import '../widgets/checkout_tab_screen.dart';
import '../widgets/common.dart';
import '../widgets/single_product.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  LaundryApi api = LaundryApi(addAccessToken: true);
  OrderApi orderAPI = OrderApi(addAccessToken: true);
  LaundryProvider _laundryProvider = LaundryProvider();
  UserProvider _userProvider = UserProvider();
  OrderProvider _orderProvider = OrderProvider();

  // Declare Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _homeAddress = TextEditingController();
  final TextEditingController _orderNotes = TextEditingController();

  /// Paystack
  final plugin = PaystackPlugin();
  String paystackPublicKey =
      'pk_test_35af153bab5dcc125e1f14e61dd87308fdd5df6f'; // secret sk_test_e2aedcbf15f38939ea8cc003b7c27765033bcbd0

  /// Razorpay
  late Razorpay _razorpay;

  /// States
  bool screenLoading = false;
  bool shouldPrefil = false;
  // Location? locationValue;

  @override
  void initState() {
    super.initState();

    /// API Fetch
    getAllLocations().then((_) => print('fetch locations'));
    getFlutterwaveKeys().then((_) => print('fetch fluttwerwave'));

    // paystack
    plugin.initialize(publicKey: paystackPublicKey);

    // razor
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Set states to empty on screenload
    _laundryProvider.setSelectedPayment('null');
  }

  bool btnLoading = false;
  bool checkoutBtnLoading = false;

  final bottomCartStyle = TextStyle(
    color: Constants.white,
    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
    fontWeight: FontWeight.w900,
  );

  @override
  Widget build(BuildContext context) {
    _laundryProvider = Provider.of<LaundryProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    _orderProvider = Provider.of<OrderProvider>(context);
    if (shouldPrefil) {
      // prefill from user provider
      prefillForm();
    } else {
      clearForm();
    }
    return Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppHeader(
                elevation: 0,
                fontSize: 25.0,
                title: AppLocalizations.of(context)!.checkout.toString(),
                bg: Constants.primaryColor,
                textColor: Constants.white,
                onCloseClicked: () => Navigator.pop(context),
                backgroundColor: Constants.primaryColor)),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                /// checkbox fill from user data provider
                CheckboxListTile(
                    title: Text(
                        AppLocalizations.of(context)!.prefill_form.toString()),
                    value: shouldPrefil,
                    onChanged: (newValue) {
                      setState(() {
                        shouldPrefil = !shouldPrefil;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading),
                FormInput(
                    label: AppLocalizations.of(context)!.email.toString(),
                    controller: _emailController,
                    passwordVisible: false,
                    obscureText: false,
                    textInputType: TextInputType.emailAddress,
                    textValidator: FormValidate.validateEmail),
                FormInput(
                    label: AppLocalizations.of(context)!.first_name.toString(),
                    controller: _firstName,
                    passwordVisible: false,
                    obscureText: false,
                    textInputType: TextInputType.text,
                    textValidator: FormValidate.validateName),
                FormInput(
                    label: AppLocalizations.of(context)!.last_name.toString(),
                    controller: _lastName,
                    passwordVisible: false,
                    obscureText: false,
                    textInputType: TextInputType.text,
                    textValidator: FormValidate.validateName),
                FormInput(
                    label:
                        AppLocalizations.of(context)!.phone_number.toString(),
                    controller: _phoneNumber,
                    passwordVisible: false,
                    obscureText: false,
                    textInputType: TextInputType.number,
                    textValidator: FormValidate.validatePhoneNumber),
                FormInput(
                    label:
                        AppLocalizations.of(context)!.pickup_address.toString(),
                    controller: _homeAddress,
                    passwordVisible: false,
                    obscureText: false,
                    textInputType: TextInputType.streetAddress,
                    textValidator: FormValidate.validateHomeAddress),

                /// list of products
                _laundryProvider.getCart!.length < 1
                    ? const Center(child: Text('No item in cart'))
                    : Column(
                        children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              // CupertinoScrollbar Scrollbar
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _laundryProvider.getCart
                                  ?.length, //item.subCategory.subcategory.length,
                              itemBuilder: (context, index) =>
                                  Column(children: [
                                    SingleProduct(
                                        products:
                                            _laundryProvider.getCart![index]),
                                  ])),
                        ],
                      ),

                ///TODO: Consider pickup time, date, delivery hour, and drop ins
                /// so a user has to select either pickup or drop in
                /// and conditional forms will display like that

                /// Delivery tab
                const TabScreen(),

                /// Order Notes
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _orderNotes,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 2,
                        maxLines: 15,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Order notes'))),

                /// Payment option list
                const PaymentOptions(),

                /// CHECKOUT BUTTON
                Container(
                  height: SizeConfig.safeBlockHorizontal * 20,
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: Constants.primaryColor),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Price Value
                      Padding(
                          padding: EdgeInsets.all(
                              SizeConfig.safeBlockHorizontal * 3.34),
                          child: Text(
                              // ignore: lines_longer_than_80_chars
                              '${Utils.getCurrency(_laundryProvider.getCurrency!.currency)} ${_laundryProvider.getTotalPrice()}',
                              style: bottomCartStyle)),
                      // Checkout Btn
                      Padding(
                          padding: EdgeInsets.all(
                              SizeConfig.safeBlockHorizontal * 3.34),
                          child: _laundryProvider.getCart!.length < 1
                              ? ButtonWidget(
                                  text: 'No item in cart',
                                  onClicked: () {},
                                  color: Colors.amber,
                                  paddingValue: 6.0,
                                  btnStatus: btnLoading,
                                  style: const TextStyle())
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
                                  child: MaterialButton(
                                      elevation: 5.0,
                                      shape: checkoutBtnLoading
                                          ? const CircleBorder()
                                          : RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(9.0)),
                                      onPressed: () => checkoutBtnLoading
                                          ? null
                                          : checkoutCart(),
                                      padding: const EdgeInsets.all(3.0),
                                      color: Constants.secondaryColor,
                                      child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: checkoutBtnLoading
                                              ? CircularProgressIndicator(
                                                  backgroundColor:
                                                      Constants.white,
                                                  valueColor:
                                                      const AlwaysStoppedAnimation<
                                                          Color>(Colors.yellow))
                                              : const Text(
                                                  'Checkout',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0),
                                                ))))),
                    ],
                  ),
                )
              ]),
            )));
  }

  // Prefill information with checkbox
  void prefillForm() {
    _emailController.text = _userProvider.getUser!.email;
    _firstName.text = _userProvider.getUser!.first_name;
    _lastName.text = _userProvider.getUser!.last_name;
    _phoneNumber.text = _userProvider.getUser!.phone_number;
    _homeAddress.text = _userProvider.getUser!.home_address;
  }

  // Clear Form
  void clearForm() {
    _emailController.clear();
    _firstName.clear();
    _lastName.clear();
    _phoneNumber.clear();
    _homeAddress.clear();
  }

  /// Fetch Delivery/Pickup regions
  Future<LocationList> getAllLocations() async {
    if (mounted) {
      setState(() {
        screenLoading = true;
      });
    }

    var data;
    await api.fetchAllLocations().then((locations) {
      final all_locations = locations;
      print('ALL LOCATIONS ARE ${all_locations.location}');
      _laundryProvider.setLocations(all_locations.location);
      setState(() {
        screenLoading = false;
      });
      data = locations;
      //return products;
    }).catchError((error) {
      print('ERROR CAUGHT ${error}');
      if (mounted) {
        Common.showSnackBar(context, title: error.toString(), duration: 300);
      }
      // return error;
    });
    return data;
  }

  /// Initiate checkout
  void checkoutCart() async {
    print('Checkout initiated');
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      /// Loading checkout btn
      if (mounted) {
        setState(() {
          checkoutBtnLoading = true;
        });
      }

      /// Generate User products and QTY from list
      final productsAndQty = [];
      _laundryProvider.getCart!.forEach((element) {
        final dd = {'id': element.id, 'qty': element.qty};
        productsAndQty.add(dd);
      });
      print('RESULT ==> ${productsAndQty}');

      /// Validate Drop in
      if (_orderProvider.isDropIn) {
        // Check drop in date and time
        if (_orderProvider.getUserSelectedTime == null ||
            _orderProvider.getUserSelectedDate == null) {
          print('I AM NULL');
          Common.showSnackBar(context,
              title: 'You have not selected delivery date / time',
              duration: 3000);
          if (mounted) {
            setState(() {
              checkoutBtnLoading = false;
            });
          }
        }
      }

      /// Validate Delivery
      if (!_orderProvider.isDropIn) {
        // check selected location
        if (_laundryProvider.getSelectedLocation == null) {
          if (mounted) {
            Common.showSnackBar(context,
                title: 'You have not selected a delivery location',
                duration: 3000);
            if (mounted) {
              setState(() {
                checkoutBtnLoading = false;
              });
            }
          }
        }
        // Check pick up date and time
      }

      final data = {
        'order_first_name': _firstName.text,
        'order_last_name': _lastName.text,
        'order_phone_number': _phoneNumber.text,
        'order_address': _homeAddress.text,
        'order_notes': _orderNotes.text,
        'is_drop_in': _orderProvider.isDropIn,
        'drop_in_time': _orderProvider.getUserSelectedTime.toString(),
        'delivery_pickup_time': _orderProvider.getUserSelectedDate.toString(),
        'location_id': _laundryProvider.getSelectedLocation!.id,
        'delivery_address': _homeAddress.text,
        'user_products': productsAndQty,
        'payment_method': _laundryProvider.getSelectedPayment,
      };

      print('ORDER $data');
      print('ORDER TIME ${data['drop_in_time']}');
      print('ORDER DATE ${data['delivery_pickup_time']}');
      print('ORDER PAYMENT ${data['payment_method']}');

      await orderAPI.createOrder(data).then((response) {
        setState(() {
          checkoutBtnLoading = false;
        });

        print('CREATE ORDER RESPONSE ${response['payment_method']}');

        final command = response['payment_method'];
        switch (command) {
          case 'cash':
            //_flutterwaveSheet(context);
            print('CASH PAYMENT');
            break;
          case 'flutterwave':
            _flutterwaveSheet(context);
            break;
          case 'paystack':
            final payment = PaystackPayment(plugin);
            payment.handleCheckout(context);
            break;
          case 'razorpay':
            razorCheckout();
            break;
          default:
            razorCheckout();
        }

        //TODO: Clear cart, checkout page data, form field
        Boxes.clearCart();
        clearForm();
      });
    }
  }

  /// Fetch Payment API keys
  Future<FlutterwaveModel> getFlutterwaveKeys() async {
    var keys;
    await orderAPI.fetchFlutterWaveKeys().then((keys) {
      print('KEYS ${keys}');
      print('KEYS ${keys.encryptionKey}');
      return keys;
    }).catchError((error) {
      print('ERROR CAUGHT ${error}');
      Common.showSnackBar(context, title: error.toString(), duration: 300);
    });
    return keys;
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

  /// Flutterwave payment sheet
  void _flutterwaveSheet(context) async {
    final customer = Customer(
        name: 'FLW Developer',
        phoneNumber: '1234566677777',
        email: 'customer@customer.com');

    final flutterwave = Flutterwave(
        context: context,
        publicKey: 'FLWPUBK_TEST-73d06f2967dae6825c3586ee265afc9a-X',
        currency: 'NGN',
        txRef: 'unique_transaction_reference8000',
        amount: '3000',
        customer: customer,
        paymentOptions: 'ussd, card, barter, payattitude',
        customization: Customization(title: 'Laundro Payment'),
        isTestMode: true);

    final response = await flutterwave.charge();
    if (response != null) {
      showLoading(response.status!);
      print('I GOT HERE !!!!!');
      print('${response}');
      print('${response.toJson()}');
      Navigator.of(context).pushNamed('/payment_success');
    } else {
      showLoading('No Response!');
    }
  }

  /// Razor pay
  void razorCheckout() async {
    final options = {
      'key': 'rzp_test_JuJyqyFSpUvQOp',
      'amount': 2000,
      'name': Constants.businessName,
      'description': 'Landromat Ordes',
      'prefill': {'contact': '8888888888', 'email': 'support@raftware.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Common.showSnackBar(context,
        title: 'SUCCESS: ' + response.paymentId!, duration: 3000);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Common.showSnackBar(context,
        title: 'ERROR: ' + response.code.toString() + ' - ' + response.message!,
        duration: 3000);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Common.showSnackBar(context,
        title: 'EXTERNAL_WALLET: ' + response.walletName!, duration: 3000);
  }
}
