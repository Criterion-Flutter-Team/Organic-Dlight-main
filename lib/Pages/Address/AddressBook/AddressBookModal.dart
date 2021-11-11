


import 'dart:convert';

import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/ProgressDialogue.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/Pages/Address/AddressBook/AddressBookController.dart';
import 'package:get/get.dart';

class AddressBookModal{


  AddressBookController controller=Get.put(AddressBookController());
  App app=App();

  getAddress(context) async {
    Map body = {
      'loginUserId':user.getUserId.toString()
    };
    var data = await app.api('GetUserAddress', body, context,token: true);

    if (data['responseCode'] == 1) {
      controller.updateAddressList=List.from(jsonDecode(data['responseValue'])['userAddressList'].reversed);
      controller.updatePaymentMethods=jsonDecode(data['responseValue'])['AllPaymentMethodList'];
    }
    else {
    }

    return data;
  }



  deleteAddressAt(id,context)
  async {
    ProgressDialogue().show(context,
        loadingText: 'Removing Address...');
    var body = {
      'id': id.toString(),
    };

    var data = await app.api('DeleteUserAddress',body, context,token: true);
    ProgressDialogue().hide(context,);

    if (data['responseCode'] == 1) {

      alertToast(context, data['responseMessage']);

    }

    else {
      alertToast(context, data['responseMessage']);
    }

    return data;
  }






}