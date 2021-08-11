import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
import '../../widgets/bottom_checkout.dart';
import '../../widgets/common.dart';
import '../../widgets/single_product.dart';

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
  // Declare Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _homeAddress = TextEditingController();

  bool screenLoading = false;
  bool shouldPrefil = false;

  static final List<NewObject> items = <NewObject>[
    NewObject('Apple', Icons.access_alarms),
    NewObject('Banana', Icons.mail),
    NewObject('Orange', Icons.account_balance_wallet),
    NewObject('Other Fruit', Icons.account_box),
  ];
  NewObject value = items.first;

  @override
  void initState() {
    super.initState();
    getAllLocations().then((_) => print('fetch locations'));
  }

  @override
  Widget build(BuildContext context) {
    _laundryProvider = Provider.of<LaundryProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    print(_laundryProvider.getCart);
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
            backgroundColor: const Color(0xFF607D8B)),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        // checkbox fill from user data provider
        CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.prefill_form.toString()),
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
          textValidator: FormValidate.validateEmail,
        ),
        FormInput(
          label: AppLocalizations.of(context)!.first_name.toString(),
          controller: _firstName,
          passwordVisible: false,
          obscureText: false,
          textValidator: FormValidate.validateEmail,
        ),
        FormInput(
          label: AppLocalizations.of(context)!.last_name.toString(),
          controller: _lastName,
          passwordVisible: false,
          obscureText: false,
          textValidator: FormValidate.validateEmail,
        ),
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
          textValidator: FormValidate.validateEmail,
        ),

        ///TODO: Consider pickup time, date, delivery hour, and drop ins
        ///so a user has to select either pickup or drop in
        ///and conditional forms will display like that
        FormInput(
          label: AppLocalizations.of(context)!.pickup_address.toString(),
          controller: _homeAddress,
          passwordVisible: false,
          obscureText: false,
          textValidator: FormValidate.validateEmail,
        ),
        // list of products
        _laundryProvider.getCart!.length < 1
            ? const Center(
                child: Text('No item in cart'),
              )
            // // CupertinoScrollbar Scrollbar
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _laundryProvider
                    .getCart?.length, //item.subCategory.subcategory.length,
                itemBuilder: (context, index) => Column(children: [
                      SingleProduct(products: _laundryProvider.getCart![index])
                    ])),

        // DropdownButton(
        //   items: listUserType,
        // ),
        _laundryProvider.getLocations!.length < 1
            ? const CircularProgressIndicator()
            : buildDropdown(),
        const PaymentOptions(),
      ])),
      bottomSheet: const BottomCheckout(),
    );
  }

  void prefillForm() {
    _emailController.text = _userProvider.getUser!.email;
    _firstName.text = _userProvider.getUser!.first_name;
    _lastName.text = _userProvider.getUser!.last_name;
    _phoneNumber.text = _userProvider.getUser!.phone_number;
  }

  void clearForm() {
    _emailController.clear();
    _firstName.clear();
    _lastName.clear();
    _phoneNumber.clear();
  }

  Widget buildDropdown() => SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<NewObject>(
                  value: value,
                  items: items
                      .map((item) => DropdownMenuItem<NewObject>(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon(item.icon),
                                // const SizedBox(width: 8),
                                Text(item.title, style: const TextStyle()),
                                const SizedBox(width: 8),
                                const Text('2.00', style: TextStyle())
                              ]),
                          value: item))
                      .toList(),
                  onChanged: (value) => setState(() {
                        this.value = value!;
                      })))));

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
