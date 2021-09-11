import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laundro/utils/size_config.dart';
import 'package:laundro/utils/utils.dart';
import 'package:laundro/widgets/Buttons/button_widget.dart';
import 'package:provider/provider.dart';

import '../../api/laundry.dart';
import '../../models/location.dart';
import '../../providers/laundry_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/form_validator.dart';
import '../../widgets/InputWidgets/input_widget.dart';
import '../../widgets/Payments/payment_options.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common.dart';
import '../tab_screen.dart';

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
  LaundryApi api = LaundryApi();
  LaundryProvider _laundryProvider = LaundryProvider();
  UserProvider _userProvider = UserProvider();
  final _formKey = GlobalKey<FormState>();
  // Declare Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _homeAddress = TextEditingController();

  bool screenLoading = false;
  bool shouldPrefil = false;
  // Location? locationValue;

  @override
  void initState() {
    super.initState();
    getAllLocations().then((_) => print('fetch locations'));
    // locationValue = initialVal;
  }

  bool btnLoading = false;

  final bottomCartStyle = TextStyle(
    color: Constants.white,
    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
    fontWeight: FontWeight.w900,
  );

  @override
  Widget build(BuildContext context) {
    _laundryProvider = Provider.of<LaundryProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);

    // value = _laundryProvider.getLocations!.first;
    print(_laundryProvider.getCart);
    print('_laundryProvider.getLocations  ${_laundryProvider.getLocations}');
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
            // FormInput(
            //   label: 'Email Address',
            //   controller: _fullName,
            //   passwordVisible: false,
            //   obscureText: false,
            //   textValidator: FormValidate.validateEmail,
            // ),

            FormInput(
              label: AppLocalizations.of(context)!.phone_number.toString(),
              controller: _phoneNumber,
              passwordVisible: false,
              obscureText: false,
              textInputType: TextInputType.number,
              textValidator: FormValidate.validatePhoneNumber,
            ),

            ///TODO: Consider pickup time, date, delivery hour, and drop ins
            /// so a user has to select either pickup or drop in
            /// and conditional forms will display like that
            FormInput(
                label: AppLocalizations.of(context)!.pickup_address.toString(),
                controller: _homeAddress,
                passwordVisible: false,
                obscureText: false,
                textInputType:
                    TextInputType.streetAddress, //TextInputType.text,
                textValidator: FormValidate.validateHomeAddress),

            /// list of products
            /* _laundryProvider.getCart!.length < 1
                ? const Center(child: Text('No item in cart'))
                : ListView.builder(
                    // CupertinoScrollbar Scrollbar
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _laundryProvider
                        .getCart?.length, //item.subCategory.subcategory.length,
                    itemBuilder: (context, index) => Column(children: [
                          SingleProduct(
                              products: _laundryProvider.getCart![index])
                        ])),*/

            SizedBox(height: 200, child: TabScreen()),

            /// Payment option list
            // _laundryProvider.getLocations!.length < 1
            //     ? const CircularProgressIndicator()
            //     : buildDropdown(),
            const PaymentOptions(),
          ]),
        )),

        /// Bottom sheet
        // bottomSheet: BottomCheckout(submitForm: submitCheckoutForm));

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
                  padding:
                      EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34),
                  child: Text(
                      // ignore: lines_longer_than_80_chars
                      '${Utils.getCurrency(_laundryProvider.getCurrency!.currency)} ${_laundryProvider.getTotalPrice()}',
                      style: bottomCartStyle)),

              // Checkout Btn
              Padding(
                  padding:
                      EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34),
                  child: _laundryProvider.getCart!.length < 1
                      ? ButtonWidget(
                          text: 'No item in cart',
                          onClicked: () {},
                          color: Colors.amber,
                          paddingValue: 6.0,
                          btnStatus: btnLoading,
                          style: const TextStyle())
                      // TODO: proceed to payment
                      : ButtonWidget(
                          text:
                              AppLocalizations.of(context)!.checkout.toString(),
                          // onClicked: () => btnLoading ? null : checkoutCart(),
                          onClicked: submitCheckoutForm,
                          // onClicked: () {
                          //   print('I was cliecked!!');
                          // },
                          color: Colors.amber,
                          paddingValue: 6.0,
                          btnStatus: btnLoading,
                          style: const TextStyle())),
            ],
          ),
        ));
  }

  void submitCheckoutForm() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      // print(
      //     // ignore: lines_longer_than_80_chars
      //     'Location and Payment${locationValue!.location} ${locationValue!.id} ${_laundryProvider.getSelectedPayment}');
      print('Details ${_emailController.text} ${_firstName.text}');
      var data = {'email': _emailController.text, 'firstname': _firstName.text};
      print('DATA $data');
    }
  }

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
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               // Icon(item.icon),
  //                               // const SizedBox(width: 8),
  //                               Text(item.location, style: const TextStyle()),
  //                               const SizedBox(width: 8),
  //                               const Text('2.00', style: TextStyle())
  //                             ]),
  //                         value: item))
  //                     .toList(),
  //                 onChanged: (value) => setState(() {
  //                       locationValue = value;
  //                     })))));

  // Fetch all locations
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
}
