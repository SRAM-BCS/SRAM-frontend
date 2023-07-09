import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

class AttendanceCountDisplayWidget extends StatelessWidget {
  final String title;
  int count;
  AttendanceCountDisplayWidget({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontFamily: fontFamilySans,
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 5,
        ),
        Material(
          color: Colors.grey.shade200,
          elevation: 10,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: fontFamilySans,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
