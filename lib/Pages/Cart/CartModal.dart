
import 'dart:convert';

import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/ProgressDialogue.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/localStorage.dart';
import 'package:organic_delight/AppManager/userData.dart';




class CartModal {
  UserData user = UserData();
  LocalStorage storedData=LocalStorage();
  App app = App();


  addToCart(context,{
    productVarientId,
    productId,
    productCode,
    quantity,
  }
  ) async {
    ProgressDialogue().show(context,
        loadingText: 'Adding in cart...');
    var guestId= user.getGuestId;
    var loginUserId= user.getUserId;
    var body = {
      'varientId': productVarientId.toString(),
      'productId': productId.toString(),
      'productCode': productCode.toString(),
      'quantity': quantity.toString(),
      'guestId': guestId,
      'loginUserId': loginUserId,
      // 'loginStatus': guestId==''? '1':'0',
    };
    var data = await app.api('AddToCart', body, context,token: true);
    ProgressDialogue().hide(context,);
    if (data['responseCode'] == 1) {
      await getCartDetails(context);

      alertToast(context, 'Successfully added in cart');
    }
    else {
      alertToast(context, data['responseMessage']);
    }
    return data;
  }




  removeCart(context,{
    cartId,
  })  async{
    ProgressDialogue().show(context,
    loadingText: 'Removing Product...');
    var body = {
      'id':cartId.toString(),
      'guestId': user.getGuestId.toString(),
      'loginUserId': user.getUserId.toString(),
    };

    print(body);

    var data = await app.api('DeleteCartDetails',body, context,token: true);
    ProgressDialogue().hide(context,);
    print(data);

    if (data['responseCode'] == 1) {
      await getCartDetails(context);
      // AlertDialogue().show(context, 'Product Deleted Successfully.');
    }

    else {
      alertToast(context, data['responseMessage']);
    }

    return data;
  }


  updateQuantity(context,{
    id,
    quantity,
  }) async {

    ProgressDialogue().show(context,
        loadingText: 'Updating...');
    var body = {
      'id': id.toString(),
      'quantity': quantity.toString(),
    };
    print(body);
    var data = await app.api('UpdateCartQty', body, context,token: true);
    ProgressDialogue().hide(context,);
    if (data['responseCode'] == 1) {
      await getCartDetails(context);
    }
    else {
      alertToast(context, data['responseMessage']);
    }

    return data;
  }

  getCartDetails(context) async {
    var body = {
      'guestId': user.getGuestId,
      'loginUserId':user.getUserId,
    };

    var data = await app.api('GetCartDetails', body, context, token: true);
    print('dddddddd');
    print(data.toString());

    if (data['responseCode'] == 1) {
       storedData.updateCartProducts(List.from(jsonDecode(data['responseValue'])['AddToCartDetails'].reversed));
    }
    else{
      alertToast(context, data['responseMessage']);
    }
    return data;
  }
}



