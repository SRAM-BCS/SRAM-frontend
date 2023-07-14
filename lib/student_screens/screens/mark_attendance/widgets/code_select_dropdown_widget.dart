import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../constants.dart';

class CodeSelectDropdownWidget extends StatefulWidget {
  final String title;
  final bool isCourseCode;
  final bool isTeacherCode;
  const CodeSelectDropdownWidget(
      {super.key,
      required this.title,
      this.isCourseCode = false,
      this.isTeacherCode = false});

  @override
  State<CodeSelectDropdownWidget> createState() =>
      _CodeSelectDropdownWidgetState();
}

class _CodeSelectDropdownWidgetState extends State<CodeSelectDropdownWidget> {
  String courseCode = 'IRE';
  String teacherCode = 'JD';

  DropdownButton<String> codeDropDown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    List<String> itemList = [];
    if (widget.isCourseCode) {
      itemList = courseCodeList;
    } else if (widget.isTeacherCode) {
      itemList = teacherCodeList;
    }
    for (String item in itemList) {
      var newItem = DropdownMenuItem(
        value: item,
        child: Text(item, style: TextStyle(fontFamily: fontFamilySans)),
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: widget.isCourseCode
          ? courseCode
          : widget.isTeacherCode
              ? teacherCode
              : 'ERROR',
      items: dropdownItems,
      onChanged: (value) {
        if (widget.isCourseCode) {
          setState(() {
            courseCode = value!;
          });
        } else if (widget.isTeacherCode) {
          setState(() {
            teacherCode = value!;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${widget.title}: ',
          style: TextStyle(
            fontFamily: fontFamilySans,
            fontSize: 15,
          ),
        ),
        codeDropDown()
      ],
    );
  }
}
