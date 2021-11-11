
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/widgets/flatBurtton.dart';


class AlertDialogue {
  final MyAlertDialogueController pressController = Get.put(MyAlertDialogueController ());



  show(context,msg,
      {
        String? firstButtonName,
        Function? firstButtonPressEvent,
        String?  secondButtonName,
        Function? secondButtonPressEvent,
        bool? showCancelButton,
        bool? showOkButton,
        bool? disableDuration,
        bool? checkIcon
      }
      ){
    var canPressOk=true;
    return WidgetsBinding.instance!.addPostFrameCallback((_){

      showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            return StatefulBuilder(
                builder: (context,setState)
                {
                  final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                  return Transform(
                    transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                    child: Opacity(
                      opacity: a1.value,
                      child: WillPopScope(
                        onWillPop: (){
                          Navigator.pop(context);
                          return Future.value(false);
                        },
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Container(
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.bottomCenter,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)
                                        )
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Container(
                                        //     decoration: BoxDecoration(
                                        //         color: AppColor.lightThemeColorDark,
                                        //         borderRadius: BorderRadius.only(
                                        //           topLeft: Radius.circular(10),
                                        //           topRight: Radius.circular(10),
                                        //         )
                                        //     ),
                                        //     child: Padding(
                                        //       padding: const EdgeInsets.all(8.0),
                                        //       child: Row(
                                        //         children: [
                                        //           Icon(
                                        //             checkIcon?? false? Icons.check:Icons.info_outline,
                                        //             color: Colors.white,
                                        //           ),
                                        //           SizedBox(width: 5,),
                                        //           Expanded(
                                        //             child: Text(alert.toString(),
                                        //               style: MyTextTheme().mediumWCB),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     )),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.fromLTRB(20,20,20,20),
                                                  child: Text(msg.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: MyTextTheme().mediumPCB.copyWith(
                                                        color: Colors.grey
                                                      ))
                                              ),
                                              Visibility(
                                                visible: showCancelButton?? false,
                                                child:   Padding(
                                                  padding: const EdgeInsets.fromLTRB(20,8,20,8),
                                                  child: FlatBtn(
                                                    color:     Colors.grey.shade300,
                                                    title: 'Cancel',
                                                    onPress: (){
                                                      if(canPressOk)
                                                      {
                                                        canPressOk=false;
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: showOkButton?? false,
                                                child:   Padding(
                                                  padding: const EdgeInsets.fromLTRB(20,8,20,8),
                                                  child: FlatBtn(
                                                    color: AppColor.lightThemeColor,
                                                    title: 'Ok',
                                                    onPress: (){
                                                      if(canPressOk)
                                                      {
                                                        canPressOk=false;
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),

                                              Visibility(
                                                visible: firstButtonName!=null,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(20,8,20,8),
                                                  child: FlatBtn(
                                                    color: AppColor.lightThemeColor,
                                                    title: firstButtonName.toString(),
                                                    onPress: (){
                                                      if(canPressOk)
                                                      {
                                                        canPressOk=false;
                                                        firstButtonPressEvent!();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: secondButtonName!=null,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(20,8,20,8),
                                                  child: FlatBtn(
                                                    color: AppColor.lightThemeColor,
                                                    title: secondButtonName.toString(),
                                                    onPress: (){
                                                      if(canPressOk)
                                                      {
                                                        canPressOk=false;
                                                        secondButtonPressEvent!();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 8,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {
            return Container();
          }).then((val){
        canPressOk=false;
      });

    });


  }



}

alertToast(context,message){
  FocusScope.of(context).unfocus();
  Fluttertoast.showToast(
    msg: message,
  );
}



class MyAlertDialogueController extends GetxController {
  var canShowNewDialogue = true .obs;

  readValue(){
    return canShowNewDialogue;
  }

  changeValue(val){
    canShowNewDialogue=RxBool(val);
    //  print(canShowNewDialogue);
    // update();
  }


}



