import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laundro/models/payment/flutterwave.dart';
import 'package:laundro/utils/boxes.dart';
import 'package:laundro/widgets/Payments/flutterwave_payment.dart';
import 'package:provider/provider.dart';

import '../api/laundry.dart';
import '../api/order.dart';
import '../models/location.dart';
import '../providers/laundry_provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/form_validator.dart';
import '../utils/size_config.dart';
import '../utils/utils.dart';
import '../widgets/Buttons/button_widget.dart';
import '../widgets/InputWidgets/input_widget.dart';
import '../widgets/Payments/payment_options.dart';
import '../widgets/app_header.dart';
import '../widgets/checkout_tab_screen.dart';
import '../widgets/common.dart';
import '../widgets/single_product.dart';

/// FLUTTER DROP IN
/// https://www.coderzheaven.com/2019/04/16/dropdown-list-in-flutter/
///

class NewObject {
  final String title;
  final IconData icon;

  NewObject(this.title, this.icon);
}

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  LaundryApi api = LaundryApi(addAccessToken: true);
  OrderApi orderAPI = OrderApi(addAccessToken: true);
  LaundryProvider _laundryProvider = LaundryProvider();
  UserProvider _userProvider = UserProvider();
  final _formKey = GlobalKey<FormState>();
  // Declare Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _homeAddress = TextEditingController();
  final TextEditingController _orderNotes = TextEditingController();

  bool screenLoading = false;
  bool shouldPrefil = false;
  // Location? locationValue;

  @override
  void initState() {
    super.initState();
    getAllLocations().then((_) => print('fetch locations'));
    getFlutterwaveKeys().then((_) => print('fetch fluttwerwave'));
    // locationValue = initialVal;
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
    if (shouldPrefil) {
      // prefill from user provider
      prefillForm();
    } else {
      clearForm();
    }
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppHeader(
              elevation: 0,
              fontSize: 25.0,
              title: AppLocalizations.of(context)!.checkout.toString(),
              bg: const Color(0xFF607D8B),
              textColor: Constants.white,
              onCloseClicked: () => Navigator.pop(context),
              backgroundColor: const Color(0xFF607D8B))),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(children: [
          /// checkbox fill from user data provider
          CheckboxListTile(
              title:
                  Text(AppLocalizations.of(context)!.prefill_form.toString()),
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
              label: AppLocalizations.of(context)!.phone_number.toString(),
              controller: _phoneNumber,
              passwordVisible: false,
              obscureText: false,
              textInputType: TextInputType.number,
              textValidator: FormValidate.validatePhoneNumber),

          ///TODO: Consider pickup time, date, delivery hour, and drop ins
          /// so a user has to select either pickup or drop in
          /// and conditional forms will display like that
          FormInput(
              label: AppLocalizations.of(context)!.pickup_address.toString(),
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
                        itemBuilder: (context, index) => Column(children: [
                              SingleProduct(
                                  products: _laundryProvider.getCart![index]),
                            ])),
                  ],
                ),

          /// Delivery tab
          const SizedBox(height: 200, child: TabScreen()),

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
                      border: OutlineInputBorder(), hintText: 'Order notes'))),

          /// Payment option list
          const PaymentOptions(),
        ]),
      )),
      bottomSheet: Container(
        height: SizeConfig.safeBlockHorizontal * 20,
        width: double.maxFinite,
        decoration: BoxDecoration(color: Constants.primaryColor),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Price Value
            Padding(
                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34),
                child: Text(
                    // ignore: lines_longer_than_80_chars
                    '${Utils.getCurrency(_laundryProvider.getCurrency!.currency)} ${_laundryProvider.getTotalPrice()}',
                    style: bottomCartStyle)),
            // Checkout Btn
            Padding(
                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34),
                child: _laundryProvider.getCart!.length < 1
                    ? ButtonWidget(
                        text: 'No item in cart',
                        onClicked: () {},
                        color: Colors.amber,
                        paddingValue: 6.0,
                        btnStatus: btnLoading,
                        style: const TextStyle())
                    // TODO: proceed to payment
                    // : ButtonWidget(
                    //     text: AppLocalizations.of(context)!.checkout.toString(),
                    //     // onClicked: () => btnLoading ? null : checkoutCart(),
                    //     onClicked: submitCheckoutForm,
                    //     // onClicked: () {
                    //     //   print('I was cliecked!!');
                    //     // },
                    //     color: Colors.amber,
                    //     paddingValue: 6.0,
                    //     btnStatus: btnLoading,
                    //     style: const TextStyle())),

                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: MaterialButton(
                            elevation: 5.0,
                            shape: checkoutBtnLoading
                                ? const CircleBorder()
                                : RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9.0)),
                            onPressed: () =>
                                checkoutBtnLoading ? null : checkoutCart(),
                            padding: const EdgeInsets.all(3.0),
                            color: Constants.bgColor,
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: checkoutBtnLoading
                                    ? CircularProgressIndicator(
                                        backgroundColor: Constants.white,
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Colors.yellow))
                                    : const Text(
                                        'Checkout',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ))))),
          ],
        ),
      ),
    );
  }

  /*void submitCheckoutForm() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      // print(
      //     // ignore: lines_longer_than_80_chars
      //     'Location and Payment${locationValue!.location}
      //     ${locationValue!.id} ${_laundryProvider.getSelectedPayment}');
      print('Details ${_emailController.text} ${_firstName.text}');
      final data = {
        'email': _emailController.text,
        'firstname': _firstName.text
      };
      print('DATA $data');
    }
  }*/

  void prefillForm() {
    _emailController.text = _userProvider.getUser!.email;
    _firstName.text = _userProvider.getUser!.first_name;
    _lastName.text = _userProvider.getUser!.last_name;
    _phoneNumber.text = _userProvider.getUser!.phone_number;
    _homeAddress.text = _userProvider.getUser!.home_address;
  }

  void clearForm() {
    _emailController.clear();
    _firstName.clear();
    _lastName.clear();
    _phoneNumber.clear();
    _homeAddress.clear();
  }

  // Widget buildDropdown() => SizedBox(
  //     width: MediaQuery.of(context).size.width,
  //     child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: DropdownButtonHideUnderline(
  //             child: DropdownButton<Location>(
  //                 //items: items
  //                 // isExpanded: true,
  //                 value: locationValue,
  //                 hint: const Text('Select a Location'),
  //                 items: _laundryProvider.getLocations!
  //                     .map((item) => DropdownMenuItem<Location>(
  //                         child: Row(
  //                             mainAxisAlignment:
  //                             MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               // Icon(item.icon),
  //                               // const SizedBox(width: 8),
  //                               Text(item.location,
  //                               style: const TextStyle()),
  //                               const SizedBox(width: 8),
  //                               const Text('2.00', style: TextStyle())
  //                             ]),
  //                         value: item))
  //                     .toList(),
  //                 onChanged: (value) => setState(() {
  //                       locationValue = value;
  //                     })))));

  // Fetch all locations

  void _bottomSheetMore(context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return const FlutterwavePayment(
          title: 'Foluwa Fulttewww',
        );
      },
    );
  }

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
      Common.showSnackBar(context, title: error.toString(), duration: 300);
      // return error;
    });
    return data;
  }

  void checkoutCart() async {
    print('PRINT USER CLICKED SIGNOUT');
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      if (mounted) {
        setState(() {
          checkoutBtnLoading = true;
        });
      }

      final cartData = Boxes.getCart();
      //final result = cartData.values.cast<Map<CartDB, dynamic>>();

      // final result = <List>[];
      // for (final inCart in cartData.values) {
      //   result.add(inCart);
      // }
      final result = [
        {'id': 11, 'qty': 2},
        {'id': 10, 'qty': 4},
        {'id': 5, 'qty': 6}
      ];

      print('ROQEEB ${result}');

      var data = {
        'order_first_name': _firstName.text,
        'order_last_name': _lastName.text,
        'order_phone_number': _phoneNumber.text,
        'order_address': _homeAddress.text,
        'order_notes': _orderNotes.text,
        'is_drop_in': true,

        'drop_in_time': '2021-09-29T15:48:58.000Z',
        'delivery_pickup_time': '2021-09-28T15:48:58.000Z',
        'location_id': 1,

        'delivery_address': _homeAddress.text,
        'user_products': result, //cartData,
        'location': _laundryProvider.getSelectedLocation!.id,
        'payment_method': 'stripe',
      };

      print('ORDER $data');

      await orderAPI.createOrder(data).then((response) {
        print('CREATE ORDER RESPONSE $response');
        setState(() {
          checkoutBtnLoading = false;
        });
        _bottomSheetMore(context);
      });
    }
  }

  /// Fetch Payment API keys
  Future<Flutterwave> getFlutterwaveKeys() async {
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
}
