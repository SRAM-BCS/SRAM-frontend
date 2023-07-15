import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:summer_project/faculty_screens/screens/attendance/screens/faculty_batch_list_screen.dart';
import 'package:summer_project/faculty_screens/screens/faculty_profile_screen.dart';
import 'package:summer_project/student_screens/screens/attendance/screens/course_list.dart';
import 'package:summer_project/student_screens/screens/home_screen.dart';

class FNavBarScreen extends StatefulWidget {
  const FNavBarScreen({super.key});

  @override
  State<FNavBarScreen> createState() => _FNavBarScreenState();
}

class _FNavBarScreenState extends State<FNavBarScreen> {
  int _selectedItemPosition = 0;
  List<Widget> _buildScreens() {
    return [const FacultyProfileScreen(), const FacultyBatchListScreen()];
  }

  List<BottomNavigationBarItem> navBarItems() {
    return [
      const BottomNavigationBarItem(
          icon: Icon(Icons.person_2), label: 'profile'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_rounded), label: 'attendance'),
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
