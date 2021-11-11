//
// import 'package:data_connection_checker/data_connection_checker.dart';
// import 'package:flutter/material.dart';
// import 'package:progress_indicators/progress_indicators.dart';
//
// bool hasConnection=false;
// bool dropped=false;
//
// class DataConnection{
//   connect(_context){
//     DataConnectionChecker().onStatusChange.listen((status) {
//         switch(status){
//           case DataConnectionStatus.connected:
//             hasConnection = true;
//             break;
//           case DataConnectionStatus.disconnected:
//             hasConnection = false;
//             break;
//         }
//       print('qwertyqwerty'+hasConnection.toString());
//         if(!hasConnection)
//         {
//           dropped=true;
//           screen(_context);
//         }
//         else{
//           print(dropped);
//           if(dropped)
//           {
//             dropped=false;
//             Navigator.pop(_context);
//           }
//         }
//     });
//   }
// }
//
//
// screen(context)
// {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return WillPopScope(
//          onWillPop: (){
//            return Future.value(false);
//          },
//         child: Scaffold(
//           backgroundColor: Colors.black54,
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CollectionSlideTransition(
//                     children: <Widget>[
//                       Icon(Icons.apps,
//                       color: Colors.transparent,),
//                       Icon(Icons.wifi_off,
//                       color: Colors.white,
//                       size: 120,),
//                       Icon(Icons.announcement,
//                       color: Colors.transparent,),
//                     ],
//                   ),
//                   Wrap(
//                     children: [
//                       // pageForConnection=='CallScreen'?  JumpingText('Reconnecting...',
//                       //   style: TextStyle(
//                       //     color: Colors.white,
//                       //   ),):
//                       Text('No Internet Connection',
//                         style: TextStyle(
//                           fontSize: 17,
//                           color: Colors.white,
//                         ),),
//                     ],
//                   ),
//                   // FlatButton(
//                   //   shape: RoundedRectangleBorder(side: BorderSide(
//                   //       color: Colors.white,
//                   //       width: 1,
//                   //       style: BorderStyle.solid
//                   //   ), borderRadius: BorderRadius.circular(5)),
//                   //   child: Text('Ok',
//                   //   style: TextStyle(
//                   //     color: Colors.white
//                   //   ),),
//                   //   onPressed: (){
//                   //     dropped=false;
//                   //     Navigator.pop(context);
//                   //   },
//                   // )
//                 ],
//               ),
//             )
//         ),
//       );
//     },
//   );
// }