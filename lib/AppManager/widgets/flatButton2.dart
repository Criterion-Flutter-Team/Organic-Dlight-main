//
// import 'package:flutter/material.dart';
// import 'package:organic_delight/AppManager/appColors.dart';
//
//
//
// class FlatButton2 extends StatefulWidget {
//
//   final String title;
//   final double? height;
//   final double? width;
//   final Function onPress;
//
//   const FlatButton2({Key? key, required this.title, required this.onPress,
//     this.height,
//     this.width}) : super(key: key);
//
//
//   @override
//   _FlatButton2State createState() => _FlatButton2State();
// }
//
// class _FlatButton2State extends State<FlatButton2> {
//
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widget.width?? null,
//       child: FlatButton(
//           height: widget.height??50,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(0),
//           ),
//           color: AppColor.lightThemeColor,
//           onPressed: (){
//             widget.onPress();
//           },
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(widget.title,
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),),
//               ),
//               SizedBox(width: 5,),
//               Icon(Icons.arrow_forward,
//                 color: Colors.white,),
//             ],
//           )
//       ),
//     );
//   }
// }
//
//
