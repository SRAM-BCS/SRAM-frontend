import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomInfoTile2 extends StatelessWidget {
  final String title;
  final String content;
  const CustomInfoTile2({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontFamily: fontFamilySans,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          content,
          style: TextStyle(
              fontFamily: fontFamilySans,
              fontSize: 15,
              fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
