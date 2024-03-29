import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:summer_project/student_screens/screens/attendance/screens/course_list.dart';
import 'package:summer_project/student_screens/screens/home_screen.dart';

import 'mark_attendance/screens/mark_attendanace_screen.dart';

class SBottomNavBar extends StatefulWidget {
  const SBottomNavBar({super.key});

  @override
  State<SBottomNavBar> createState() => _SBottomNavBarState();
}

class _SBottomNavBarState extends State<SBottomNavBar> {
  int _selectedItemPosition = 0;
  List<Widget> _buildScreens() {
    return [
      const StudentHomeScreen(),
      const CourseList(),
      const MarkAttendanceScreen(),
    ];
  }

  List<BottomNavigationBarItem> navBarItems() {
    return [
      const BottomNavigationBarItem(
          icon: Icon(Icons.person_2), label: 'Profile'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_rounded), label: 'Attendance'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.qr_code), label: 'Mark Attendance'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.rectangle,

        padding: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,

        ///configuration for SnakeNavigationBar.gradient
        //snakeViewGradient: selectedGradient,
        //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        //unselectedItemGradient: unselectedGradient,

        showSelectedLabels: true,

        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: navBarItems(),
      ),
      body: _buildScreens()[_selectedItemPosition],
    );
  }
}
