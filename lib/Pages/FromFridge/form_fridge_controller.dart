
import 'package:get/get.dart';

class FromFridgeController extends GetxController{

  List fridgeList=[].obs;
  List allFridgeProduct=[].obs;
  var fridgeId = 0.obs;

  List get getFridgeList=>fridgeList;
  List get getAllFridgeProduct=>allFridgeProduct;
   get getFridgeId=>fridgeId;

  set updateFridgeList(List val){
    fridgeList=val;
    update();
  }

  set updateAllFridgeProduct(List val){
    allFridgeProduct=val;
    update();
  }

  set updateFridgeId(int val){
    fridgeId= RxInt(val);
    update();
  }


}