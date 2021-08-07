import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/laundry.dart';
import '../../models/location.dart';
import '../../providers/laundry_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/form_validator.dart';
import '../../widgets/Buttons/button_widget.dart';
import '../../widgets/InputWidgets/input_widget.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common.dart';

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
  // Declare Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  bool btnLoading = false;
  bool screenLoading = false;
  bool shouldPrefil = false;
  LaundryProvider _laundryProvider = LaundryProvider();
  UserProvider _userProvider = UserProvider();

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
            title: 'Checkout',
            bg: const Color(0xFF607D8B),
            textColor: Constants.white,
            onCloseClicked: () => Navigator.pop(context),
            backgroundColor: const Color(0xFF607D8B)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // checkbox fill from user data
            // CheckboxOption(
            //   title: 'Prefill from user data',
            //   newValue: shouldPrefil,
            //   onPressed: prefill(),
            //   checkedValue: true,
            // ),
            CheckboxListTile(
              title: Text('Prefill from user data'),
              value: shouldPrefil,
              // onChanged: prefillFunc(),
              onChanged: (newValue) {
                setState(() {
                  shouldPrefil = !shouldPrefil;
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
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
            // _laundryProvider.getCart!.length < 1
            //     ? const Center(
            //         child: Text('No item in cart'),
            //       )
            //     : ListView.builder(
            //         shrinkWrap: true,
            //         scrollDirection: Axis.vertical,
            //         itemCount: _laundryProvider
            //             .getCart?.length, //item.subCategory.subcategory.length,
            //         itemBuilder: (context, index) => Column(children: [
            //           SingleProduct(products: _laundryProvider.getCart![index])
            //         ]),
            //       ),
            //
            // DropdownButton(
            //   items: listUserType,
            // ),
            _laundryProvider.getLocations!.length < 1
                ? CircularProgressIndicator()
                : buildDropdown(),
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
      ),
    );
  }

  void prefillForm() {
    _emailController.text = _userProvider.getUser!.email;
  }

  void clearForm() {
    //_emailController.text = "";
    _emailController.clear();
  }

  void checkoutCart() {
    print('Checking out cart');
  }

  Widget buildDropdown() => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<NewObject>(
              value: value, // currently selected item
              items: items
                  .map((item) => DropdownMenuItem<NewObject>(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Icon(item.icon),
                            // const SizedBox(width: 8),
                            Text(
                              item.title,
                              style: const TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  // fontSize: 20,
                                  ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '2.00',
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  // fontSize: 20,
                                  ),
                            ),
                          ],
                        ),
                        value: item,
                      ))
                  .toList(),
              onChanged: (value) => setState(() {
                this.value = value!;
              }),
            ),
          ),
        ),
      );

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
