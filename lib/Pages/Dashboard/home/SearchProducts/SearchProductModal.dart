


import 'dart:convert';

import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/Pages/Dashboard/home/SearchProducts/SearchController.dart';
import 'package:get/get.dart';

class SearchProductModal{

  App app=App();
  SearchController searchC=Get.put(SearchController());

  getSearchedData(context,text) async{

    List searchList=[];
    var body = {
      'productName':text.toString()
    };
    var data = await app.api('SearchProduct', body, context,token: true);

    if (data['responseCode'] == 1) {

      searchC.updateSearchList = jsonDecode(data['responseValue'])['SearchProductList'];
    }
    else {
    }
    return searchList;
  }



}