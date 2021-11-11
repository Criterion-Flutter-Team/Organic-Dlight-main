

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/ProgressDialogue.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:get/get.dart';
import 'package:organic_delight/Pages/Cart/CheckOut/ReceiptAlertDiologue.dart';
import 'package:organic_delight/Pages/Cart/CheckOut/checkOutModal.dart';
import 'package:organic_delight/Pages/FromFridge/FridgeCart/fridge_cart_local_storage.dart';
import 'package:organic_delight/Pages/FromFridge/from_fridge_modal.dart';

class FridgeCartModal {
  App app = App();
  UserData user = UserData();
  FridgeCartLocalStorage localStorage = Get.put(FridgeCartLocalStorage());
  FromFridgeModal modal = FromFridgeModal();
  CheckOutModal checkOutModal = CheckOutModal();

  addToCartFridge(context, {
    productVarientId,
    productId,
    productCode,
    quantity,
    fridgeId
  }) async {
    ProgressDialogue().show(context,
        loadingText: 'Adding in cart...');
    var body = {
      'fridgeId': fridgeId.toString(),
      'varientId': productVarientId.toString(),
      'productId': productId.toString(),
      'productCode': productCode.toString(),
      'quantity': quantity.toString(),
      'guestId': user.getGuestId.toString(),
      'loginUserId': user.getUserId.toString(),
      'loginStatus': user.getGuestId == '' ? '1' : '0',
    };
    var data = await app.api('AddToCartFridge', body, context, token: true);
    ProgressDialogue().hide(context);
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&' + data.toString());
    if (data['responseCode'] == 1) {
      await getCartDetailsFridge(context);
      // await  modal.countCartFridge(context);

      alertToast(context, 'Successfully added in cart');
    }
    else {
      alertToast(context, data['responseMessage']);
    }
  }


  getCartDetailsFridge(context) async {
    var body = {
      'loginUserId': user.getUserId.toString(),
    };
    var data = await app.api('GetCartDetailsFridge', body, context, token: true);
    if (data['responseCode'] == 1) {
      localStorage.updateFridgeCartProducts(List.from(
          jsonDecode(data['responseValue'])['AddToCartDetailsFridge']
              .reversed));
    }
  }


  removeCart(context, {
    cartId,
  }) async {
    ProgressDialogue().show(context,
        loadingText: 'Removing Product...');
    var body = {
      'id': cartId.toString(),
      'guestId': user.getGuestId.toString(),
      'loginUserId': user.getUserId.toString(),
    };
    var data = await app.api(
        'DeleteCartDetailsFridge', body, context, token: true);
    ProgressDialogue().hide(context,);
    if (data['responseCode'] == 1) {
      await getCartDetailsFridge(context);
    }
    else {
      alertToast(context, data['responseMessage']);
    }
    return data;
  }


  updateCartQtyFridge(context, {id, quantity}) async {
    ProgressDialogue().show(context,
        loadingText: 'Updating...');
    var body = {
      'id': id.toString(),
      'quantity': quantity.toString(),
    };
    var data = await app.api('UpdateCartQtyFridge', body, context, token: true);
    ProgressDialogue().hide(context);
    if (data['responseCode'] == 1) {
      await getCartDetailsFridge(context);
    }
    else {
      alertToast(context, data['responseMessage']);
    }
  }

  onPressedRazorPay(context) async {
    var transactionData = await checkOutModal.getGuestId(context);
    if (transactionData['responseCode'] == 1) {
      var placeOrderData = await checkOutModal.placeOrder(context,
          addressId: '8'.toString(),
          paymentMethod: '2'.toString(),
          ordId: transactionData['responseValue']);
      if (placeOrderData['responseCode'] == 1) {
      }
      return placeOrderData;
    }
  }


  razorPay(context, {transactionId, payableAmount, totalAmount}) async {
    var transactionData = await checkOutModal.getGuestId(context);
    if (transactionData['responseCode'] == 1) {
      var placeOrderData = await checkOutModal.placeOrder(context,
          addressId: '8'.toString(),
          paymentMethod: '2'.toString(),
          ordId: transactionData['responseValue']);

      if (placeOrderData['responseCode'] == 1) {
        var updateTransactionDetails = await checkOutModal
            .getUpdateTransactionDetails(
            context,
            transactionId: transactionId.toString(),
            payableAmount: payableAmount.toString(),
            statusMessage: 'Success');
        if (updateTransactionDetails['responseCode'] == 1) {
          var updatedCart = await checkOutModal.getUpdateCartOnOrder(context);

          if (updatedCart['responseCode'] == 1) {
            var cartData = await getCartDetailsFridge(context);

            if (cartData['responseCode'] == 1) {
              // tabCont.updateCurrentTab(0);
              //  app.navigate(context, Dashboard());

              Navigator.pop(context,);
              Navigator.pop(context);
              Navigator.pop(context);
              // tabCont.updateCurrentTab(0);

              ReceiptAlert().show(context,
                  transactionId: transactionId.toString(),
                  orderId: transactionData['responseValue'].toString(),
                  totalAmount: totalAmount.toString(),
                  orderDate: jsonDecode(
                      placeOrderData['responseValue'])['OrderDetails'][0]['entryDate']
                      .toString());
            }
          }
        }
      }
    }
  }


}
