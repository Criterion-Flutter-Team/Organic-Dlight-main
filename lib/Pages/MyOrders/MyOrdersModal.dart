

import 'dart:convert';

import 'package:get/get.dart';
import 'package:organic_delight/AppManager/ProgressDialogue.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/Pages/MyOrders/MyOrdersController.dart';

class  MyOrdersModal{

  App app= App();
  MyOrderController myOrdersC= Get.put(MyOrderController());

  myOrders(context) async{
    print('orders');
    var body={
      'loginUserId':UserData().getUserId,
    };
    var data = await app.api('MyOrders',body,context,token:true);
    print(data);
    if(data['responseCode'] == 1){

      myOrdersC.updateMyOrderList=jsonDecode(data['responseValue'])['MyOrderList'];
    }
    return data;
  }

  viewOrderDetails(context,{orderDetailsMainId}) async{
    print('Detrsailsssssssssss');

    ProgressDialogue().show(context,
        loadingText: 'Loading ...!!');
    var body={
      'loginUserId':UserData().getUserId.toString(),
      'orderDetailsMainId':orderDetailsMainId.toString(),
    };

    var data =await app.api('ViewOrderDetails', body, context,token: true);
    ProgressDialogue().hide(context);
    if(data['responseCode'] == 1){
      print('dhfkhdkfhkdhfkhdk'+jsonDecode(data['responseValue'])['OrderDetails'].toString());
      myOrdersC.updateOrderDetailsList=jsonDecode(data['responseValue'])['OrderDetails'] ;
    }
  }
}