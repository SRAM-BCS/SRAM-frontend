import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomInfoTile3 extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;
  const CustomInfoTile3({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, bottom: 16),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(
                width: 7,
              ),
              Text(
                title,
                style: TextStyle(fontFamily: fontFamilySans, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
