import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/ProgressDialogue.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:get/get.dart';
import 'package:organic_delight/Pages/Dashboard/DashboardTabBarContrller.dart';


class LoginPageModal {

  UserData user = UserData();
  App app = App();
  DashboardTabBarController tabCont=Get.put(DashboardTabBarController());



  login(context, mail, pass) async {

    ProgressDialogue().show(context,
        loadingText: 'Securely Logging In...');

    var body = {
      'userName': mail.toString(),
      'password': pass.toString(),
    };
    var data = await app.api('authenticate', body, context);
    ProgressDialogue().hide(context);
    if (data['responseCode'] == 1) {
      var guest= user.getGuestId;
      await user.addUserData(jsonDecode(data['responseValue'])['test1'][0]);
      await user.addToken(data['token']);
      await getGuestIdDataToLoginID(context,guest);
      tabCont.updateCurrentTab(0);
      print(tabCont.getCurrentTab);
      Navigator.pop(context);
    }

    else {
      alertToast(context, data['responseMessage']);
    }

    ProgressDialogue().hide(context);
    return data;
  }

  getGuestIdDataToLoginID(context,guest) async{
    print(user.getUserId);
    var body = {
      'loginUserId': user.getUserId,
      'guestId': guest.toString(),
    };
    var data = await app.api('UpdateGuestIdDataToLoginID', body, context);
    if (data['responseCode'] == 1) {
      print('abc');

    }
  }


  signUp(context,isSignUp ,{
    name,
    contact,
    email,
    password,

  }) async {
    ProgressDialogue().show(context,
        loadingText: isSignUp? ('Sending OTP to '+contact.toString()):
        ('Resending OTP to '+ contact.toString()));
    var body = {
      'name': name.toString(),
      'mobileNo': contact.toString(),
      'email': email.toString(),
      'password': password.toString(),
    };
    print(body);
    var data = await app.api('UserRegistration', body, context);
    print(data);
    ProgressDialogue().hide(context);
    if (data['responseCode'] == 1) {
      alertToast(context, 'OTP sent on '+contact.toString());
    }
    else {
      alertToast(context, data['responseMessage']);
    }
    return data;
  }


  verifyOtp(context, contact, otp, isLogin) async {
    ProgressDialogue().show(context,
        loadingText: 'Verifying OTP');
    var body = {
      'mobileNo': contact.toString(),
      'otp': otp.toString(),
    };
    print(body);
    var data = await app.api(isLogin? 'VerifyLoginOtp':'VerifyOtp', body, context);
    print(data);
    ProgressDialogue().hide(context);
    if (data['responseCode'] == 1) {
      if(isLogin){
        var guest= user.getGuestId;
        await user.addUserData(jsonDecode(data['responseValue'])['test1'][0]);
        await user.addToken(data['token']);
        await getGuestIdDataToLoginID(context,guest);
        tabCont.updateCurrentTab(0);
        print(tabCont.getCurrentTab);
        Navigator.pop(context);
      }

      else{
        tabCont.updateCurrentTab(0);
        alertToast(context, data['responseMessage']);
      }
    }
    else {
      alertToast(context, data['responseMessage']);
    }
    return data;
  }

  userLoginWithOTP(context, contact) async {
    ProgressDialogue().show(context,
        loadingText: 'Sending OTP on '+contact.toString());

    var body = {
      'mobileNo': contact.toString(),
    };

    var data = await app.api('UserLoginViaOtp', body, context);
    ProgressDialogue().hide(context);

    if (data['responseCode'] == 1) {
      alertToast(context, 'OTP sent on '+contact.toString());
    }
    else {
      alertToast(context, data['responseMessage']);
    }
    return data;
  }
}