// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

// class CustomNavBarWidget extends StatelessWidget {
//   final int? selectedIndex;
//   final List<PersistentBottomNavBarItem> items;
//   final ValueChanged<int>? onItemSelected;

//   const CustomNavBarWidget({
//     super.key,
//     this.selectedIndex,
//     required this.items,
//     this.onItemSelected,
//   });

//   Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
//     return Container(
//       alignment: Alignment.center,
//       height: 60.0,
//       child: Material(
//         color: isSelected ? Colors.blue.shade100 : Colors.transparent,
//         borderRadius: const BorderRadius.all(Radius.circular(20.0)),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Flexible(
//                 child: IconTheme(
//                   data: IconThemeData(
//                       size: 26.0,
//                       color: isSelected
//                           ? (item.activeColorSecondary ??
//                               item.activeColorPrimary)
//                           : item.inactiveColorPrimary ??
//                               item.activeColorPrimary),
//                   child: item.icon,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 5.0),
//                 child: Material(
//                   type: MaterialType.transparency,
//                   child: FittedBox(
//                     child: Text(
//                       item.title ?? "",
//                       style: TextStyle(
//                           color: isSelected
//                               ? (item.activeColorSecondary ??
//                                   item.activeColorPrimary)
//                               : item.inactiveColorPrimary,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 12.0),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       child: SizedBox(
//         width: double.infinity,
//         height: 60.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: items.map((item) {
//             int index = items.indexOf(item);
//             return Flexible(
//               child: GestureDetector(
//                 onTap: () {
//                   if (onItemSelected != null) {
//                     onItemSelected!(index);
//                   }
//                 },
//                 child: _buildItem(item, selectedIndex == index),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
