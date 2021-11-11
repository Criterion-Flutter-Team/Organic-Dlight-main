import 'dart:convert';
import 'dart:developer';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/Pages/Cart/CartModal.dart';
import 'package:organic_delight/Pages/Dashboard/WhishList/WishListController.dart';
import 'package:get/get.dart';

class WishListModal {

 App app= App();
 UserData user=UserData();
 CartModal cartModal=CartModal();

 WishListController controller=Get.put(WishListController());

  addProductToWishList(context,{
    productId,
    productCode,
    int? status
 })   async {
    var body =  {
      'productId':productId.toString(),
      'loginUserId': user.getUserId.toString(),
      'productCode':productCode.toString(),
      'status': status.toString(),
    };
    print('wwwwwwwwwwwwwwwww');
    print(body);
    var data = await app.api('AddWishListProduct', body, context,token: true);
    print("wiiiiiiiiwiiiiiiiiiiiiii");
    print("wiiiiiiiiwiiiiiiiiiiiiii");
    print(data.toString());
    if (data['responseCode'] == 1) {

      print("wiiiiiiiiwifsfsiiiiiiiiiiiii");
      print(data['responseValue'].toString());
      await getWishLists(context);
    }
    else {
    }
    return data;
  }

  getWishLists(context) async {
   var loginUserId= user.getUserId;
   var body = {
     'loginUserId':loginUserId,
   };
   print(body);
   var data = await app.api('UserWishList', body, context,token: true);
   if (data['responseCode'] == 1) {
     // var reversedList = new
     print("fdfdxfdgdg");
     log('fdfdfdgdg'+jsonDecode(data['responseValue'])['UserWishList'].toString());
     controller.updateWishList=List.from(jsonDecode(data['responseValue'])['UserWishList'].reversed);
   }
   else {    }
   return data;
 }


 removeWishList(context,{
   productId,
   productCode,
 }) async {
   var loginUserId= user.getUserId;
   var body = {
     'productId':productId.toString(),
     'loginUserId':loginUserId,
     'productCode':productCode.toString(),
     'status':'0',
   };
   print(body);
   var data = await app.api('AddWishListProduct', body, context,token: true);
   if (data['responseCode'] == 1) {
     await getWishLists(context);
   }
   else {
   }
   return data;
 }
}