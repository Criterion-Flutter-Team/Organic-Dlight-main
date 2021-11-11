
import 'package:get/get.dart';


class SearchController extends GetxController{

  List searchDataList= [].obs;

  set updateSearchList(List val){
    searchDataList=val;
    update();
  }




  List get getSearchList=> searchDataList;

  removeSearchList(){
    searchDataList.clear();
    update();
  }

}