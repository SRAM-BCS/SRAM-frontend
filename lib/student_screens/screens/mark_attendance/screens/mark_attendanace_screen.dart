import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_project/constants/constants.dart';

import '../../../provider/student_user_provider.dart';
import '../widgets/cicular_ripple_button.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentUserProvider>(context, listen: true).user;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/images/sram-logo.png',
                    ),
                    height: 50,
                    width: 100,
                  ),
                  Hero(
                    tag: 'profile_image',
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(studentProvider.profileImage),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),

            Text(
              DateTime.now().toString(),
              style: TextStyle(
                fontFamily: fontFamilySans,
                fontSize: 30,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Friday 30 June',
              style: TextStyle(
                fontFamily: fontFamilySans,
                fontSize: 30,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const CicularRippleButton(),
            const SizedBox(
              height: 50,
            ),
            // Row(
            //   children: [

            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
