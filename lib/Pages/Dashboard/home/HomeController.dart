

import 'package:get/get.dart';


class HomeController extends GetxController {

  List productList=[].obs;
  List todaysProductList=[].obs;

  List get getAllProductList=> productList;
  List get getTodaysDealList=> todaysProductList;


  set allProductList(List val){
    productList=val;
    update();
  }

  set allTodaysProductList(List val){
    todaysProductList=val;
    update();
  }

  removeProductList(){
    productList.clear();
    update();
  }

  removeTodaysProductList(){
    todaysProductList.clear();
    update();
  }




}