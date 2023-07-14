import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summer_project/auth/preferences/common_preferences.dart';
import 'package:summer_project/constants/routing_constants.dart';
import 'package:summer_project/models/student_user_model.dart';
import 'package:summer_project/student_screens/provider/student_user_provider.dart';
import 'package:summer_project/student_screens/services/student_services.dart';
import 'package:summer_project/student_screens/widgets/custom_info_tile_2.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../widgets/custom_info_tile.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  final _commonPreference = CommonPreferences();
  final _studentServices = StudentServices();

  @override
  void initState() {
    getStudent();
    super.initState();
  }

  void getStudent() {
    _studentServices.getStudent(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentUserProvider>(context, listen: true).user;
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(studentProvider.profileImage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                studentProvider.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: fontFamilySans,
                  fontSize: 28,
                ),
              ),
            ),
            Text(
              'Computer Science Student (4th Sem)',
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
                          title: 'Roll No.', content: studentProvider.roll),
                      CustomInfoTile(
                          title: 'Email Address',
                          content: studentProvider.email),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.credit_card_rounded),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Student Id Card',
                            style: TextStyle(
                                fontFamily: fontFamilySans, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.credit_card_rounded),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Student Id Card',
                            style: TextStyle(
                                fontFamily: fontFamilySans, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInfoTile2(
                    title: 'Institute',
                    content:
                        'Atal Bihari Vajpayee Indian Institute of Inforamation Technology & Management',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomInfoTile2(
                      title: 'Study Programme',
                      content: 'Computer Science Engineering')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
