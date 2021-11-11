


import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_version/new_version.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/widgets/flatBurtton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';
Version latestVersion=Version(0, 0, 0);
Version currentVersion=Version(0, 0, 0);

class Updater{
  static const APP_STORE_URL =
      'https://apps.apple.com/us/app/medsense-pis/id1566837222';
  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.criteriontech.organic_delight';




   checkVersion(context) async{
    final newVersion = NewVersion(
    );
    final status = await newVersion.getVersionStatus();
      currentVersion = Version.parse(status!.localVersion.toString());
   // Version currentVersion = Version.parse('1.0.2');
    latestVersion = Version.parse(status.storeVersion.toString());

    print(currentVersion.toString()+' '+latestVersion.toString()+' uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu');

    print(currentVersion.toString()+'\n'+latestVersion.toString());

  }


  showUpdateDialogue(lat,context){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: (){
            return Future.value(false);
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 150,
                            child: Lottie.asset('assets/update.json'),),
                      ),
                      Text('New version available',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold
                        ),),
                      Text('('+lat.toString()+')',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold
                        ),),
                      SizedBox(height: 2,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Looks like you have an older version of the app.\n'
                            'Please update to get latest features and better experience.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            ),
                            child: Text('Update',
                              style: MyTextTheme().mediumPCB),
                            onPressed: () {
                              if (Platform.isAndroid) {
                                _launchURL(PLAY_STORE_URL);
                              } else if (Platform.isIOS) {
                                _launchURL(APP_STORE_URL);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  updateContainer(){
    return Visibility(
      visible: latestVersion > currentVersion,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,20,),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.grey.shade300,
            width: 2)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text('version '+latestVersion.toString()+' is available',
                        style: MyTextTheme().mediumBCN,),
                    ),
                    SizedBox(width: 15,),
                    FlatBtn(
                        width: 100,
                        title: 'Update',
                      onPress: (){
                        if (Platform.isAndroid) {
                          _launchURL(PLAY_STORE_URL);
                        } else if (Platform.isIOS) {
                          _launchURL(APP_STORE_URL);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}


_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}