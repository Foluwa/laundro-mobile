import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({Key? key}) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime pickedDate;
  late TimeOfDay time;

  OrderProvider _orderProvider = OrderProvider();

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    _orderProvider = Provider.of<OrderProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title:
              //Text(
              // ignore: lines_longer_than_80_chars
              // 'Date:  ${pickedDate.day}-${pickedDate.month}-${pickedDate.year}'),
              // 'Date:  ${pickedDate.toString()}'),
              Text(_orderProvider.getUserSelectedDate == null
                  ? 'Select date'
                  : _orderProvider.getUserSelectedDate!.toIso8601String()),
          trailing: const Icon(Icons.keyboard_arrow_down),
          onTap: _pickDate,
        ),
        ListTile(
          // title: Text('Time: ${time.hour}:${time.minute}'),
          // title: Text('Time: ${time.toString()}}'),
          title: Text(_orderProvider.getUserSelectedTime == null
              ? 'Select a time'
              : _orderProvider.getUserSelectedTime.toString()),
          trailing: const Icon(Icons.keyboard_arrow_down),
          onTap: _pickTime,
        ),
      ],
    );
  }

  // ignore: always_declare_return_types
  _pickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );

    if (date != null)
      setState(() {
        pickedDate = date;
      });
    _orderProvider.setUserSelectedDate(date);
  }

  // ignore: always_declare_return_types
  _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: time);

    if (t != null)
      setState(() {
        time = t;
      });

    _orderProvider.setUserSelectedTime(t);
  }
}
