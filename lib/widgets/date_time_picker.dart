import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({Key? key}) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime pickedDate;
  late TimeOfDay time;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // ignore: lines_longer_than_80_chars
        ListTile(
          title: Text(
              'Date:  ${pickedDate.day}-${pickedDate.month}-${pickedDate.year}'),
          trailing: const Icon(Icons.keyboard_arrow_down),
          onTap: _pickDate,
        ),
        ListTile(
          title: Text('Time: ${time.hour}:${time.minute}'),
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
  }

  // ignore: always_declare_return_types
  _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: time);

    if (t != null)
      setState(() {
        time = t;
      });
  }
}
