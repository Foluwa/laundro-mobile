import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _customRadioButton,
            const SizedBox(width: 12),
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Constants.secondaryColor : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? Constants.secondaryColor : Constants.lightGrey,
          width: 2,
        ),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Constants.white : Constants.thickGrey,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
