import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ButtonWidget1 extends StatelessWidget {
  bool isLoading;
  final String title;
  final VoidCallback onTap;
  ButtonWidget1({
    Key? key,
    this.isLoading = false,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(5),
        minimumSize: MaterialStateProperty.all(
            Size(MediaQuery.of(context).size.width * 0.8, 50)),
      ),
      onPressed: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 500,
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: fontFamilySans,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
