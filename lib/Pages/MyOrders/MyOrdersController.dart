import 'package:get/get.dart';

class MyOrderController extends GetxController {


  List orderList=[].obs;
  List orderDetailsList=[].obs;

  List get getMyOrdersList=> orderList;
  List get getOrderDetailsList=> orderDetailsList;


  set updateMyOrderList(List val){
    orderList=val;
    update();
  }
  set updateOrderDetailsList(List val){
    orderDetailsList=val;
    update();
  }


  removeProductList(){
    orderList.clear();
  }

  removeProductDetailList(){
    orderDetailsList.clear();
  }





}