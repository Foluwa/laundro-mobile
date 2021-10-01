import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/location.dart';
import '../providers/laundry_provider.dart';
import '../providers/order_provider.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import 'date_time_picker.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  OrderProvider _orderProvider = OrderProvider();

  /// Dropin or Delivery
  final Map<int, Widget> _tabs = {
    // Delivery
    0: Tab(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Delivery'),
        const Icon(Icons.bike_scooter),
      ],
    )),

    // Drop in
    1: Tab(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Drop In'),
        const Icon(Icons.car_rental),
      ],
    )),
  };

  var _selectedIndex = 0;
  void _tabChanged(int index) {
    print('Selected Tab is: $index');
    setState(() {
      _selectedIndex = index;
    });

    // Is drop in tab is 1 so if selected set the state to true else the state is false
    if (index == 1) {
      _orderProvider.setIsDropIn(true);
    } else {
      _orderProvider.setIsDropIn(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _orderProvider = Provider.of<OrderProvider>(context);
    return Column(children: [
      SizedBox(
          width: double.infinity,
          child: CupertinoSegmentedControl(
              padding: const EdgeInsets.all(15),
              children: _tabs,
              onValueChanged: _tabChanged,
              borderColor: Constants.primaryColor,
              selectedColor: Constants.secondaryColor,
              unselectedColor: Constants.white,
              groupValue: _selectedIndex)),
      Container(child: _showSelectedView()),
    ]);
  }

  Widget _showSelectedView() {
    var _selectedView;
    switch (_selectedIndex) {
      case 0:
        print('Pickup was clicked ooo');

        // _orderProvider.setUserSelectedDate(null);
        // _orderProvider.setUserSelectedTime(null);

        //TODO: Reset data and time when pickup is clicked
        _selectedView = const PickUp();
        break;
      case 1:
        _selectedView = const DropIn();
        break;
      default:
        _selectedView = const DropIn();
        break;
    }
    return _selectedView;
  }
}

class PickUp extends StatefulWidget {
  const PickUp({Key? key}) : super(key: key);

  @override
  State<PickUp> createState() => _PickUpState();
}

class _PickUpState extends State<PickUp> {
  LaundryProvider _laundryProvider = LaundryProvider();
  Location? locationValue;

  @override
  Widget build(BuildContext context) {
    _laundryProvider = Provider.of<LaundryProvider>(context);
    return _laundryProvider.getLocations!.length < 1
        ? const CircularProgressIndicator()
        : SizedBox(
            child: Column(
            children: [
              buildDropdown(),
              const DateTimePicker(),
            ],
          ));
  }

  Widget buildDropdown() => SizedBox(
      width: MediaQuery.of(context).size.width / 1.1,
      child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<Location>(
              //validator: FormValidate.validateHomeAddress,
              // Todo: Use validator on DropdownButtonFormField
              value: locationValue,
              hint: const Text('Select a Location'),
              items: _laundryProvider.getLocations!
                  .map((item) => DropdownMenuItem<Location>(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.location, style: const TextStyle()),
                            const SizedBox(width: 8),
                            Text(
                                // ignore: lines_longer_than_80_chars
                                '${Utils.getCurrency(_laundryProvider.getCurrency!.currency)}${item.price.toString()}',
                                style: const TextStyle())
                          ]),
                      value: item))
                  .toList(),
              onChanged: (value) => setState(() {
                    locationValue = value;
                    // set location in state
                    _laundryProvider.setUserLocation(value);
                  }))));
}

class DropIn extends StatefulWidget {
  const DropIn({Key? key}) : super(key: key);

  @override
  State<DropIn> createState() => _DropInState();
}

class _DropInState extends State<DropIn> {
  @override
  Widget build(BuildContext context) {
    return const DateTimePicker();
  }
}
