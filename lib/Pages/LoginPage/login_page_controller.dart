import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginPageController extends GetxController{




  RxBool isReadTerms=false.obs;
  bool get getIsReadTerms=>isReadTerms.value;
  set updateIsReadTerms(bool val){
    isReadTerms.value=val;
    update();
  }


  RxBool checkBoxValue=false.obs;
  bool get getCheckBoxValue=>checkBoxValue.value;
  set updateCheckBoxValue(bool val){
    checkBoxValue.value=!val;
    update();
  }


}