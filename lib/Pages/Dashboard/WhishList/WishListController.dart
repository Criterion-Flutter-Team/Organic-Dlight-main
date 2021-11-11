import 'package:get/get.dart';


class WishListController extends GetxController {


  List wishList=[].obs;

  List get getWishList=> wishList;


  set updateWishList(List val){
    wishList=val;
    update();
  }


  removeProductList(){
    wishList.clear();
    update();
  }
}