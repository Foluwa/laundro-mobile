import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/location.dart';
import '../providers/laundry_provider.dart';
import 'date_time_picker.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // LaundryProvider _laundryProvider = LaundryProvider();
  final Map<int, Widget> _tabs = {
    0: Tab(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Pick up'),
        const Icon(Icons.bike_scooter),
      ],
    )),
    1: Tab(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Drop in'),
        const Icon(Icons.car_rental),
      ],
    )),
    // 2: Tab(child: Icon(Icons.airline_seat_flat)),
  };

  var _selectedIndex = 0;

  void _tabChanged(int index) {
    setState(() {
      _selectedIndex = index;
      print('Selected Index: $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          width: 500,
          child: CupertinoSegmentedControl(
            padding: const EdgeInsets.all(15),
            children: _tabs,
            onValueChanged: _tabChanged,
            borderColor: Colors.teal,
            selectedColor: Colors.teal,
            unselectedColor: Colors.white,
            groupValue: _selectedIndex,
          )),
      Expanded(child: _showSelectedView()),
    ]);
  }

  Widget _showSelectedView() {
    var _selectedView;
    switch (_selectedIndex) {
      case 0:
        _selectedView = const PickUp();
        break;
      // case 1:
      //   _selectedView = DropIn();
      //   break;
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
        : SizedBox(child: buildDropdown());
  }

  Widget buildDropdown() => SizedBox(
      width: MediaQuery.of(context).size.width / 1.1,
      child: DropdownButtonHideUnderline(
          child: DropdownButton<Location>(
              //items: items
              // isExpanded: true,
              value: locationValue,
              hint: const Text('Select a Location'),
              items: _laundryProvider.getLocations!
                  .map((item) => DropdownMenuItem<Location>(
                      child: Row(
                          // width: MediaQuery.of(context).size.width / 1.1,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Icon(item.icon),
                            // const SizedBox(width: 8),
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
