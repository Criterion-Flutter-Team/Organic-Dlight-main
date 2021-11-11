
import 'package:get/get.dart';


class DashboardTabBarController extends GetxController  {
  var currentTab = 0 .obs;

  int get getCurrentTab => currentTab.value;

  void updateCurrentTab(int val) async{
     currentTab = RxInt(val);
    update();
  }
}
