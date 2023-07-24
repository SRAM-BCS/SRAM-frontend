import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:summer_project/common/widgets/toast.dart';
import 'package:summer_project/faculty_screens/constants/constants.dart';
import 'package:summer_project/faculty_screens/provider/faculty_provider.dart';
import 'package:summer_project/faculty_screens/services/faculty_attendance_services.dart';

import '../../../../constants/constants.dart';

class FacultyStatusToggleButtonWidget extends StatefulWidget {
  const FacultyStatusToggleButtonWidget({
    super.key,
  });

  @override
  State<FacultyStatusToggleButtonWidget> createState() =>
      _FacultyStatusToggleButtonWidgetState();
}

class _FacultyStatusToggleButtonWidgetState
    extends State<FacultyStatusToggleButtonWidget> {
  final facultyAttendanceServices = FacultyAttendanceServices();
  bool codeStatus = false;
  String classRoomCode = 'SELECT';
  DropdownButton<String> classRoomCodeDropDown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    List<String> itemList = [];
    itemList = classRoomCodeList;
    for (String item in itemList) {
      var newItem = DropdownMenuItem(
        value: item,
        child: Text(item, style: TextStyle(fontFamily: fontFamilySans)),
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: classRoomCode,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          classRoomCode = value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              Text('Faculty Code Status',
                  style: TextStyle(fontFamily: fontFamilySans)),
              const SizedBox(
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                    color: codeStatus ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8.0, right: 50, left: 50),
                  child: Text(codeStatus ? "ON" : 'OFF',
                      style: TextStyle(
                          fontFamily: fontFamilySans,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
          ),
          classRoomCodeDropDown(),
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlutterSwitch(
                  activeText: 'On',
                  inactiveText: 'Off',
                  value: codeStatus,
                  onToggle: (value) {
                    if (classRoomCode == "SELECT") {
                      showToast(msg: 'Select Class Room Code');
                    } else {
                      facultyAttendanceServices
                          .toggleFacultyCode(
                              facultyCode: Provider.of<FacultyProvider>(context,
                                      listen: false)
                                  .user
                                  .code,
                              classRoom: classRoomCode)
                          .then((value) {
                        if (value == 200) {
                          setState(() {
                            codeStatus = !codeStatus;
                          });
                        } else {
                          showToast(msg: 'Something went wrong ');
                        }
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
