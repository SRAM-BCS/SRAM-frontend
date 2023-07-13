import 'package:flutter/material.dart';

import '../../constants/constants.dart';

Text headerText({required String title}) {
  return Text(
    title,
    style: TextStyle(
        fontSize: 14, fontFamily: fontFamilySans, fontWeight: FontWeight.bold),
  );
}
