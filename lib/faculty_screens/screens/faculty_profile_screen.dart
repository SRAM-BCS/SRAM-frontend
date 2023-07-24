import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:summer_project/faculty_screens/provider/faculty_provider.dart';

import '../../auth/preferences/common_preferences.dart';
import '../../constants/constants.dart';
import '../../constants/routing_constants.dart';
import '../../student_screens/widgets/custom_info_tile.dart';
import '../../student_screens/widgets/custom_info_tile_2.dart';
import '../services/faculty_services.dart';

class FacultyProfileScreen extends StatefulWidget {
  const FacultyProfileScreen({super.key});

  @override
  State<FacultyProfileScreen> createState() => _FacultyProfileScreenState();
}

class _FacultyProfileScreenState extends State<FacultyProfileScreen> {
  final _commonPreference = CommonPreferences();
  final _facultyServices = FacultyServices();

  @override
  void initState() {
    getFaculty();
    super.initState();
  }

  void getFaculty() {
    _facultyServices.getFaculty(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final facultyProvider =
        Provider.of<FacultyProvider>(context, listen: true).user;
    return Scaffold(
      // backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                      height: 50,
                      width: 100,
                      image: AssetImage('assets/images/sram-logo.png')),
                  InkWell(
                    onTap: () {
                      _commonPreference.deleteJwt();
                      GoRouter.of(context).replaceNamed(
                          RoutingConstants.studentLoginScreenRouteName);
                    },
                    child: Material(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.logout_outlined,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Good Afternoon ',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: fontFamilySans,
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                facultyProvider.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: fontFamilySans,
                  fontSize: 28,
                ),
              ),
            ),
            Text(
              'Senior Course Faculty',
              style: TextStyle(
                  fontFamily: fontFamilySans,
                  fontSize: 15,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Material(
                elevation: 5,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 12, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomInfoTile(
                          title: 'Faculty Code', content: facultyProvider.code),
                      CustomInfoTile(
                          title: 'Email Address',
                          content: facultyProvider.email),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomInfoTile2(
                    title: 'Institute',
                    content:
                        'Atal Bihari Vajpayee Indian Institute of Inforamation Technology & Management',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInfoTile2(
                      title: 'Courses',
                      content: facultyProvider.courses
                          .map((e) => e.name)
                          .toList()
                          .join(', ')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
