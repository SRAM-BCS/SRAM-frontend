import 'package:flutter/material.dart';

class AdminApprovalStatusScreen extends StatefulWidget {
  const AdminApprovalStatusScreen({super.key});

  @override
  State<AdminApprovalStatusScreen> createState() =>
      _AdminApprovalStatusScreenState();
}

class _AdminApprovalStatusScreenState extends State<AdminApprovalStatusScreen> {
  @override
  void initState() {
    super.initState();
    checkApprovalStatus();
  }

  void checkApprovalStatus() {}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text('Status: Under Review'),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
