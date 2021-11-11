import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



class FridgeCartLocalStorage extends GetxController {
  final localStorage = GetStorage('fridgeBox');

  List get getCartProducts => localStorage.read('fridgeCartProduct') ?? [];
  List get getCartVarients => localStorage.read('fridgeCartVarients') ?? [];


  String get getCartTotal => getCartProducts.isEmpty? 'NIL':getCartProducts[0]['cartTotal'].toString();
  String get getTotalPrice => getCartProducts.isEmpty? 'NIL':getCartProducts[0]['totalMrp'].toString();
  String get getCartTotalDiscount => getCartProducts.isEmpty? 'NIL':getCartProducts[0]['totalDiscount'].toString();
  String get getTotalMrp => getCartProducts.isEmpty? 'NIL':(getCartProducts[0]['cartAfterDiscount']?? getCartTotal).toString();

  String get getCouponCode => getCartProducts.isEmpty? '':(getCartProducts[0]['couponCode']?? '').toString();
  String get getDiscount => getCartProducts.isEmpty? '':(getCartProducts[0]['maxDiscount']?? '').toString();


  updateFridgeCartProducts(List val) {
    localStorage.write('fridgeCartProduct', val);
    updateFridgeVarients(val);
    update();
  }

  updateFridgeVarients(List val) {
    List saveList=[];
    for(int i=0; i<val.length; i++){
      saveList.add(val[i]['productVarientId']);
    }
    localStorage.write('fridgeCartVarients', saveList);
    update();
  }

  removeFridgeProduct() async{
    print('remoooooooove');
    await localStorage.remove('fridgeCartProduct');
    await localStorage.remove('fridgeCartVarients');
    update();
  }


}