import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/ProgressDialogue.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/Pages/Address/AddressBook/AddressBookModal.dart';

class AddAddressModal{

  AddressBookModal addressModal=AddressBookModal();
  List country=[];
  List stateList=[];
  List cityList=[];
  App app= App();



   addAddress({
    context,
    latitude,
    name,
    addressLineOne,
    addressLineTwo,
    landmark,
    pincode,
    cityId,
    latitudes,
    longitude,
    stateId,
    countryId,
    contact,
    addressType,
    email,
    primaryStatus,
    loginUserId
  }) async {
     ProgressDialogue().show(context,
         loadingText: 'Adding Address...!!');
    // name,addressLineOne,addressLineTwo,landmark,pincode,cityId,stateId,countryId,contact,email,primaryStatus,loginUserId
    /* List list = await getAddressList;*/
    var loginUserId =  user.getUserId;
    var body = {
      'name': name.toString(),
      'addressLineOne': addressLineOne.toString(),
      'addressLineTwo': addressLineTwo.toString(),
      'landmark': landmark.toString(),
      'pincode': pincode.toString(),
      // 'cityId': cityId.toString(),
      'latitude':latitudes.toString(),
      'longitude':longitude.toString(),
      // 'stateId': stateId.toString(),
      // 'countryId': countryId.toString(),
      'contact': contact.toString(),
      'addressType':addressType.toString(),
      'email': email.toString(),
      'primaryStatus':primaryStatus==''? '1':'0',
      'loginUserId': loginUserId.toString()
    };
    print('bodyy');
    print(body);
    var data = await app.api('SaveUserAddress', body, context,token: true);
   ProgressDialogue().hide(context);
    print("sssssss");
    print(data);
    // primaryAddressC.updateAddressList(context);
    if (data['responseCode'] == 1) {

      Navigator.pop(context);
      alertToast(context, 'Address added Successfully.');

    }

    else {
       alertToast(context, data['responseMessage']);
    }

    return data;
  }
  void updateAddress(
      context,
      {
        name,
        addressLineOne,
        addressLineTwo,
        landmark,
        pincode,
        cityId,
        latitudes,
        longitude,
        stateId,
        countryId,
        contact,
        addressType,
        email,
        primaryStatus,
        id
      }) async {
    ProgressDialogue().show(context,
        loadingText: 'Updating Address...!!');
    var body = {
      'name': name.toString(),
      'addressLineOne': addressLineOne.toString(),
      'addressLineTwo': addressLineTwo.toString(),
      'landmark': landmark.toString(),
      'pincode': pincode.toString(),
      // 'cityId': cityId.toString(),
      'latitude':latitudes.toString(),
      'longitude':longitude.toString(),
      // 'stateId': stateId.toString(),
      // 'countryId': countryId.toString(),
      'contact': contact.toString(),
      'addressType':addressType.toString(),
      'email': email.toString(),
      'primaryStatus': '0',
      'id': id.toString()
    };
    var data = await app.api('UpdateUserAddress', body, context,token: true);
    ProgressDialogue().hide(context);
    if (data['responseCode'] == 1) {
      addressModal.getAddress(context);

      Navigator.pop(context);
      alertToast(context, 'Address Updated successfully.');
    }
    else {
      alertToast(context, data['responseMessage']);
    }

    return data;
  }





  editAddressAt(context,{id})
  async {
    // ProgressDialogue().show(context,
    //     loadingText: 'editing Address...');
    var body = {
      'id': id.toString(),
    };
    print(body);

    var data = await app.api('EditUserAddress',body, context,token: true);
    ProgressDialogue().hide(context,);
    print(data);

    if (data['responseCode'] == 1) {


      alertToast(context, data['responseMessage']);

    }

    else {
      alertToast(context, data['responseMessage']);
    }

    return data;
  }

  getAllCountry(context,setState) async {

    var body = {};
    var data = await app.api('GetAllCountry', body, context,token: true);

    if (data['responseCode'] == 1) {
      country=jsonDecode(data['responseValue'])['CountryList'];
      setState(() {
      });
      // print(primaryAddressC.getAddressList);
    }
    else {
    }

    return country;
  }

  getAllState(context,setState,{countryID}) async{
      var body= {
      'countryId': countryID.toString(),
  };
      var data= await app.api('GetAllState', body,context,token: true);
      print('stateeeeeees');
      print(data);
      if(data['responseCode'] == 1){
        stateList=jsonDecode(data['responseValue'])['StateList'];
        print('apiworking');
        setState(() {
        });
      }else{

      }
      return stateList;
  }

  getAllCity(context,setState,{stateId}) async{
    var body={
      'stateId': stateId.toString(),
    };
    var data=await app.api('GetAllCity', body, context,token: true);
    print(data);
    if(data['responseCode']==1){
      cityList=jsonDecode(data['responseValue'])['CityList'];
      setState(() {
      });
    }else{

    }
    return cityList;
  }

}