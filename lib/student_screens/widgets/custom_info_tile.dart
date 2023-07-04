import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomInfoTile extends StatelessWidget {
  final String title;
  final String content;
  const CustomInfoTile({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: fontFamilySans,
                fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            content,
            style: TextStyle(
              fontFamily: fontFamilySans,
            ),
          ),
        ],
      ),
    );
  }
}
