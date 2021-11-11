


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreen.dart';
import 'package:organic_delight/Pages/Dashboard/home/HomeController.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

class HomeModal{

  App app=App();
  HomeController controller=Get.put(HomeController());



  getAllProduct(context) async {
    var body = UserData().getUserId==''? {} : {
      'loginUserId': UserData().getUserId.toString()
    };
    print(body);
    var data = await app.api('GetAllProduct', body, context,token: true);

    if (data['responseCode'] == 1) {

      var catWithProduct=jsonDecode(data['responseValue'])['AllProductList'];
      controller.allProductList=catWithProduct;
    }
    else {

    }

    return data;
  }


   initUniLinks(context) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      if(initialLink!=null){
        List spitPatterns=initialLink.toString().split('/')[3].split('-');

        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ProductScreen(
            heroTag: spitPatterns[0].toString(),
            productCode:  spitPatterns[1].toString(),
            productId:  spitPatterns[2].toString(),
            productVarient:  spitPatterns[3].toString(),
            pageName:  spitPatterns[4].toString(),
          );
        } ));
      }

      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
    }
    on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }



  getTodaysDealProduct(context) async {
    var body = {
    };
    var data = await app.api('GetAllTodaysDealProduct', body, context,token: true);
    print('dkbhfkjdhfkjh'+data.toString());
    if (data['responseCode'] == 1) {

      controller.allTodaysProductList=jsonDecode(data['responseValue']) ;
      print('tttttttttttttttoday'+controller.getTodaysDealList.toString());

    }
  }

}