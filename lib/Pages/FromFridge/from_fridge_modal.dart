

import 'dart:convert';

import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/Pages/FromFridge/form_fridge_controller.dart';
import 'package:get/get.dart';

import 'FridgeCart/fridge_cart_local_storage.dart';

class FromFridgeModal{

  UserData user=UserData();
  App app=App();
  FromFridgeController controller=Get.put(FromFridgeController());
  FridgeCartLocalStorage fridgeLocalData=Get.put(FridgeCartLocalStorage());


  getFridgeList(context) async {
    var body={
      // 'loginUserId': user.getUserId.toString()
    };
    var data= await app.api('GetFridgeList', body, context,token: true);
    if(data['responseCode']==1){
      controller.updateFridgeList=jsonDecode(data['responseValue'])['FridgeList'];
    }
  }


  getAllProductFridge(context,{fridgeId}) async {
    var body={
      'fridgeId':fridgeId.toString(),
      'loginUserId':user.getUserId.toString(),
    };
    var data=await app.api('GetAllProductFridge', body, context,token: true);
    if(data['responseCode']==1){
      controller.updateAllFridgeProduct=jsonDecode(data['responseValue'])['AllFridgeProductList'];
      controller.updateFridgeId=fridgeId;
    }
  }



}