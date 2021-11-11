
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/ProgressDialogue.dart';
import 'package:organic_delight/AppManager/appUtils.dart';

class CouponModal{

  List couponCodeList=[];

  App app=App();


  getCouponList(context) async {
    var body = {};
    print(body);
    var data = await app.api('GetCouponList', body, context,token: true);
    print(data);
    if (data['responseCode'] == 1) {
      couponCodeList=jsonDecode(data['responseValue'])['CouponList'];
      print(couponCodeList);
    }
    else {
    }

    return couponCodeList;
  }


  applyCoupon(context,{
    couponAppliedId,
    couponAppliedCode,
    couponValue
  }) async {

    ProgressDialogue().show(context,
        loadingText:'Coupon Applied');
    var body = {
      'couponAppliedId':couponAppliedId.toString(),
      'couponAppliedCode':couponAppliedCode,
      'guestId':user.getGuestId,
      'loginUserId':user.getUserId,
    };
    print(body);
    var data = await app.api('ApplyCoupon', body, context, token:true);
    print(data);
    ProgressDialogue().hide(context);
    if (data['responseCode'] == 1) {
      Navigator.pop(context,couponValue);
      // alertToast(context, data['responseMessage']);

    }

    else {
      alertToast(context, data['responseMessage']);
    }


    return data;
  }


}