

import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/appColors.dart';


class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

//   List associateList=[
//   {
//     'name': 'Amir',
//     'age': '22',
//     'gender': 'male',
//   },
//     {
//       'name': 'Amir',
//       'age': '22',
//       'gender': 'male',
//     },
//     {
//       'name': 'Amir',
//       'age': '22',
//       'gender': 'male',
//     },
//     {
//       'name': 'Amir',
//       'age': '22',
//       'gender': 'male',
//     },
//     {
//       'name': 'Amir',
//       'age': '22',
//       'gender': 'male',
//     },
//   ];
//
//
//   getCsv() async {
//
//     //create an element rows of type list of list. All the above data set are stored in associate list
// //Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.
//
//
//     List<List<dynamic>> rows = List<List<dynamic>>();
//     for (int i = 0; i <associateList.length;i++) {
//
// //row refer to each column of a row in csv file and rows refer to each row in a file
//       List<dynamic> row = List();
//       row.add(associateList[i]['name']);
//       row.add(associateList[i]['gender']);
//       row.add(associateList[i]['age']);
//       rows.add(row);
//     }
//
//     await SimplePermissions.requestPermission(Permission. WriteExternalStorage);
//     bool checkPermission=await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
//     if(checkPermission) {
//
// //store file in documents folder
//
//       String dir = (await getExternalStorageDirectory()).absolute.path + "/documents";
//       var file = "$dir";
//       print(" FILE " + file);
//       File f = new File(file+"filename.csv");
//
// // convert rows to String and write as csv file
//
//       String csv = const ListToCsvConverter().convert(rows);
//       f.writeAsString(csv);
//     }
//
//
//   }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          body: TextButton(
            // style: TextButton.styleFrom(
            //   backgroundColor: !isLogin? AppColor.buttonColor:Colors.white,
            //   shape: AppWidgets.buttonShape,
            //   padding: EdgeInsets.all(0),
            //   // padding: EdgeInsets.symmetric(horizontal: 22,)
            // ),
            onPressed: () {
            },
            child:Text('Location'),
          ),
          // FlatButton(child:
          //
          // Text('Location'),
          //   onPressed: (){
          //   },
          //
          // ),
        ),
      ),
    );
  }
}
