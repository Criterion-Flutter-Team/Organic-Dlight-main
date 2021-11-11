
import 'package:get/get.dart';

class ProductScreenController extends GetxController {


  Map productData={}.obs;
  List variantData=[].obs;
  RxInt selectedVariant=0.obs;


  Map get getProductData=> productData;
  List get getVariantData=> variantData;
  int get getSelectedVariant=> selectedVariant.value;

  set updateProductData(Map val){
    productData=val;
    update();
  }
  
  set updateVariantData(List val){
    variantData=val;
    update();
  }
  set updateSelectedVariant(int val){
    selectedVariant=RxInt(val);
    update();
  }



  removeProductData(){
    productData.clear();
  }


  removeVariantData(){
    variantData.clear();
  }


}