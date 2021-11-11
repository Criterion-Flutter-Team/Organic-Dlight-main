import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class AddressBookController extends GetxController {

  final addressBookStorage = GetStorage();

  int get getSelectedAddressId => (addressBookStorage.read('deliveryId') ?? 0);

  set updateDeliveryId(int val){
    addressBookStorage.write('deliveryId', val);
  }




  List addressList=[].obs;
  List paymentMethods=[].obs;



  List get getAddressList=> addressList;
  List get getPaymentMethods=> paymentMethods;



  set updateAddressList(List val){

    addressList=val;
    update();
  }


  set updatePaymentMethods(List val){

    paymentMethods=val;
    update();
  }
}