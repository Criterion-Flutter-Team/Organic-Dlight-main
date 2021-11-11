import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/ProgressDialogue.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/AppManager/widgets/textFeild.dart';


var startValidation=false;
final _formKey = GlobalKey<FormState>();
TextEditingController newPasswordC=TextEditingController();
TextEditingController confirmPasswordC=TextEditingController();

class ProfileModal {




  showChangePasswordDialogue(context){
    startValidation=false;
    newPasswordC.clear();
    confirmPasswordC.clear();

    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return StatefulBuilder(
              builder: (context,setState)
              {
                return Transform.scale(
                  scale: a1.value,
                  child: Opacity(
                    opacity: a1.value,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40,0,40,0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: AppColor.lightThemeColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            )
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text('Change Password',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),),
                                              ),
                                              IconButton(
                                                  splashRadius: 5,
                                                  icon: Icon(Icons.clear,
                                                    color: Colors.white,
                                                    size: 20,),
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          ),
                                        )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: _formKey,
                                     autovalidateMode: AutovalidateMode.always,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 15,),
                                          Text('New Password *',
                                            style: TextStyle(
                                              color: AppColor.customBlack,
                                            ),),
                                          SizedBox(height: 5,),
                                          TextFieldClass(
                                            controller: newPasswordC,
                                            validator: (value){
                                              if(value!.length==0)
                                              {
                                                return startValidation? 'Password must not be empty.': null;
                                              }
                                              else{
                                                return null;
                                              }
                                            },
                                            hintText: 'Enter New Password',
                                            isPasswordField: true,
                                          ),
                                          SizedBox(height: 15,),
                                          Text('Confirm Password *',
                                            style: TextStyle(
                                              color: AppColor.customBlack,
                                            ),),
                                          SizedBox(height: 5,),
                                          TextFieldClass(
                                            controller: confirmPasswordC,
                                            validator: (value){
                                              if(value!.length==0)
                                              {
                                                return startValidation? 'Confirm Password must not be empty.': null;
                                              }
                                              else if(value.toString()!=newPasswordC.text){
                                                return startValidation? 'Password does not match.': null;
                                              }
                                              else{
                                                return null;
                                              }
                                            },
                                            hintText: 'Confirm Password',
                                            isPasswordField: true,
                                          ),
                                          SizedBox(height: 15,),
                                          changePasswordButton(context,setState),
                                          SizedBox(height: 7,),
                                        ],
                                      ),
                                    ),
                                  )
                                  ],
                                ),
                              ),
                            ),
                          ],
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
        });
  }


}



changePasswordButton(context,setState){
  return   Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColor.buttonColor,
          shape: AppWidgets.buttonShape,
          padding: EdgeInsets.symmetric(horizontal: 16)
        ),
        onPressed: () {
          onPressedChangePassword(context,setState);
        },
        child: Text('Change Password',
          style: AppWidgets.buttonTextStyle,),
      ),
      // FlatButton(
      //   color: AppColor.buttonColor,
      //   shape: AppWidgets.buttonShape,
      //   child: Text('Change Password',
      //     style: AppWidgets.buttonTextStyle,),
      //   onPressed: (){
      //     onPressedChangePassword(context,setState);
      //   },
      // ),
    ],
  );
}


onPressedChangePassword(context,setState){
  FocusScope.of(context).unfocus();
  setState((){
    startValidation=true;
  });

  if(_formKey.currentState!.validate())
    {
      onPressedConfirm(){
        Navigator.pop(context);
        changePassApi(context);
      }

      AlertDialogue().show(context, 'Do you want to Change Password?',
          showCancelButton: true,
          firstButtonName: 'Confirm',
          showOkButton: false,
          firstButtonPressEvent: onPressedConfirm
      );
    }



}



changePassApi(context,) async {
  ProgressDialogue().show(context,
      loadingText: 'Changing Password');
  App app=App();
  UserData user=UserData();
  var userId=  user.getUserId;

  var body = {
    'id': userId.toString(),
    'password': newPasswordC.text.toString(),
  };
  print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'+body.toString());
  var data = await app.api('ChangePassword', body, context,token: true);
  print(data);
  ProgressDialogue().hide(context);
  if (data['responseCode'] == 1) {
    await user.removeUserData();
     Navigator.pop(context);
    alertToast(context, data['responseMessage']);
  }
  else {
    alertToast(context, data['responseMessage']);
  }

  return data;
}