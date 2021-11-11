


import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/ProgressDialogue.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/Pages/Cart/CartModal.dart';
import 'package:get/get.dart';
import 'package:organic_delight/Pages/Cart/CheckOut/ReceiptAlertDiologue.dart';
import 'package:organic_delight/Pages/Dashboard/DashboardTabBarContrller.dart';

class CheckOutModal {
  CartModal modal = CartModal();
  CartModal _cartModal = CartModal();
  UserData user = UserData();
  App app = App();

  DashboardTabBarController tabCont=Get.put(DashboardTabBarController());

  placeOrder(context, {addressId, paymentMethod, ordId}) async {
    // ProgressDialogue().show(context,
    //     loadingText: 'Order placed');

    var body = {
      'loginUserId': user.getUserId.toString(),
      'addressId': addressId.toString(),
      'paymentMethod': paymentMethod.toString(),
      'orderId': ordId.toString(),
    };
    var data = await app.api('PlaceOrder', body, context, token: true);
    if (data['responseCode'] == 1) {

    }
    else{
      alertToast(context, data['responseMessage']);
    }
    return data;
  }


  getUpdateCartOnOrder(context) async {

    var body = {
      'loginUserId': user.getUserId.toString(),
    };
    var data = await app.api('UpdateCartOnOrder', body, context, token: true);
    if (data['responseCode'] == 1) {
    }
    return data;
  }

  getUpdateTransactionDetails(context,
      {transactionId, payableAmount, statusMessage}) async{
    var gId = await getGuestId(context);
    var body = {
      'transactionId': transactionId.toString(),
      'payableAmount': payableAmount.toString(),
      'status_message': statusMessage.toString(),
      'orderId': gId.toString(),
      'loginUserId': user.getUserId.toString(),
    };
    var data = await app.api(
        'UpdateTransactionDetails', body, context, token: true);
    if (data['responseCode'] == 1) {
    }
    return data;
  }

  getGuestId(context) async {
    ProgressDialogue().show(context,
        loadingText: 'Generating order ID');

    var body = {};
    var data = await app.api('GenerateGuestId', body, context, token: true);
    ProgressDialogue().hide(context);
    if (data['responseCode'] == 1) {

    }
    else {
      alertToast(context, data['responseMessage']);
    }

    return data;
  }


  cashOnDelivery(context, {totalAmount, addressId, cashPaymentMethod}) async {
    var transactionData = await getGuestId(context);
    if (transactionData['responseCode'] == 1) {
      var placeOrderData = await placeOrder(context,
          addressId: addressId.toString(),
          paymentMethod: cashPaymentMethod.toString(),
          ordId: transactionData['responseValue']);

      if (placeOrderData['responseCode'] == 1) {
        var updatedCart = await getUpdateCartOnOrder(context);

        if (updatedCart['responseCode'] == 1) {
          var cartData = await _cartModal.getCartDetails(context);

          if (cartData['responseCode'] == 1) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            tabCont.updateCurrentTab(0);

             ReceiptAlert().show(context,
                transactionId: ''.toString(),
                orderId: transactionData['responseValue'].toString(),
                totalAmount: totalAmount.toString(),
                orderDate: jsonDecode(
                    placeOrderData['responseValue'])['OrderDetails'][0]['entryDate']
                    .toString());
          }
          else{
            alertToast(context, cartData['responseMessage']);
          }
        }
      }
    }
  }


  onPressedRazorPay(context,{addressId,paymentMethod}) async{
    var transactionData = await getGuestId(context);
    if (transactionData['responseCode'] == 1) {
      var placeOrderData = await placeOrder(context,
          addressId: addressId.toString(),
          paymentMethod: paymentMethod.toString(),
          ordId: transactionData['responseValue']);

      if (placeOrderData['responseCode'] == 1) {
      }
      return placeOrderData;
  }
  }

  razorPay(context,
      {addressId, paymentMethod, transactionId, payableAmount, totalAmount}) async {
    var transactionData = await getGuestId(context);
    if (transactionData['responseCode'] == 1) {
      var placeOrderData = await placeOrder(context,
          addressId: addressId.toString(),
          paymentMethod: paymentMethod.toString(),
          ordId: transactionData['responseValue']);

      if (placeOrderData['responseCode'] == 1) {

        var updateTransactionDetails = await getUpdateTransactionDetails(
            context,
            transactionId: transactionId.toString(),
            payableAmount: payableAmount.toString(),
            statusMessage: 'Success');
        if (updateTransactionDetails['responseCode'] == 1) {
          var updatedCart = await getUpdateCartOnOrder(context);

          if (updatedCart['responseCode'] == 1) {
            var cartData = await _cartModal.getCartDetails(context);

            if (cartData['responseCode'] == 1) {

              // tabCont.updateCurrentTab(0);
              //  app.navigate(context, Dashboard());

              Navigator.pop(context,);
              Navigator.pop(context);
              Navigator.pop(context);
              tabCont.updateCurrentTab(0);

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
