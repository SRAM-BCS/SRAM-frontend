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
      body: Center(
        child: Text('Approval Pending'),
      ),
    );
  }
}
