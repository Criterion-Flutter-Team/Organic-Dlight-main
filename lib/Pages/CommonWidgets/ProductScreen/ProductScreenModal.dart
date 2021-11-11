import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreenController.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

import 'ProductScreen.dart';


class ProductScreenModal {

  App app=App();
  List getRatingList=[];

  ProductScreenController controller=Get.put(ProductScreenController());

  getProductDetails(context,{
    productCode,varient,page
  }) async {
    var body = page=='todaysDeal'?{
      'productCode': productCode.toString(),
      'productVarientId': varient.toString(),
    }:varient==null? {
      'productCode': productCode.toString(),
      'loginUserId': UserData().getUserId,
    }: UserData().getUserId==''? {
      'productCode': productCode.toString(),
      'varientId': varient.toString(),
    }:{
      'productCode': productCode.toString(),
      'varientId': varient.toString(),
      'loginUserId': UserData().getUserId,
    };
    var data = await app.api(page=='todaysDeal'? 'TodaysDealSingleProductDetail':
    page=='fridgePage'? 'GetSingleProductDetailFridge':'GetSingleProductDetail', body, context,token: true);
    log('++++++++++++++++++++'+data.toString());
    if (data['responseCode'] == 1) {
      controller.updateSelectedVariant=int.parse((varient).toString());
      controller.updateVariantData = jsonDecode(data['responseValue'])[page=='todaysDeal'? 'AvailableVarients':
      page=='fridgePage'? 'ProductVarientListFridge':'ProductVarientList'];
      controller.updateProductData= jsonDecode(data['responseValue'])[page=='todaysDeal'? 'SingleProductDetailTodaysDeal':
      page=='fridgePage'? 'SingleProductListFridge':'SingleProductList'][0];
    }
    else {
    }
    return data;
  }


  getAllReviewAndRating(context,{
    productId,
    productCode,
    review,
    rating,
    title,
    loginUserId
  }) async {
    var body= {
     'productId':productId.toString(),
      'productCode':productCode.toString(),
      'review':review.toString(),
      'rating':rating.toString(),
      'title':title.toString(),
      'loginUserId':loginUserId.toString()
    };
    print('body');
    print(body);
    var data = await app.api('ReviewAndRating', body, context,token: true);
     print(data);
    if (data['responseCode'] == 1) {
    }
    else {
    }
    return data;
  }


  getLikeReview(context,{
    reviewId,
    isLike,
    loginUserId,

  }) async {
    var body= {

      'reviewId':reviewId.toString(),
      'isLike':isLike,
      'loginUserId':loginUserId.toString()

    };
    var data = await app.api('LikeReview', body, context,token: true);
    print(data);
    if (data['responseCode'] == 1) {
    }
    else {

    }

    return data;
  }

  getRatingAndReviewList(context,{
    productId
  }) async {
    var body= {

    'productId':productId.toString()

    };
    var data = await app.api('ReviewAndRatingList', body, context,token: true);
    //
    if (data['responseCode'] == 1) {
      getRatingList=jsonDecode(data['responseValue'])['ProductReviewAndRatingList'];
    }
    else {
    }

    return data;
  }


  Future<void> initUniLinks(context) async {
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
          );

        }));
      }


      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }


}