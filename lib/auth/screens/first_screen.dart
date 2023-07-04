import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

enum ValidationStatus { accepted, pending, denied }

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return Row(
                  children: [],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
