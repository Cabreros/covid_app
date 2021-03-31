import 'package:flutter/material.dart';

class DropdownProvince extends DropdownMenuItem {
  final String province;
  const DropdownProvince({
    @required this.province,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownMenuItem(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            height: 40.0,
            width: 40.0,
            child: Image.asset(
              'assets/images/$province.jpg',
            ),
          ),
          Text(province),
        ],
      ),
      value: province,
    );
  }
}
