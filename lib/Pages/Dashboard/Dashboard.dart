import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/Pages/CommonWidgets/Drawer/Drawer.dart';
import 'package:organic_delight/Pages/Dashboard/DashboardModal.dart';
import 'package:organic_delight/Pages/Dashboard/DashboardTabBarContrller.dart';
import 'package:organic_delight/Pages/Dashboard/Profile/Profile.dart';
import 'package:organic_delight/Pages/Dashboard/WhishList/WishListPage.dart';
import 'package:organic_delight/Pages/Dashboard/home/Home.dart';
import 'package:get/get.dart';
import 'package:organic_delight/Pages/Dashboard/home/HomeModal.dart';




class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DashboardModal modal=DashboardModal();

  UserData user=UserData();

  final DashboardTabBarController tabCont=Get.put(DashboardTabBarController());







  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    get();

  }






  get() async{
    await getGuestId();
    alertToast(context, 'Welcome '+ user.getName);
    HomeModal().initUniLinks(context);

  }
  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  getGuestId() async{
   await modal.generateGuestId(context);
    print(user.getGuestId);
  }


  onPressDrawer(){
    _scaffoldKey.currentState!.openDrawer();
  }


backToHomeTab()async{

    tabCont.updateCurrentTab(0);
}

exitApp(){
  onPressedConfirm() async {

    Navigator.pop(context);
    exit(0);
  }
  AlertDialogue().show(context, 'Are you sure you want to exit?',
      firstButtonName: 'Exit',
      firstButtonPressEvent: onPressedConfirm,
      showOkButton: false,
      showCancelButton: true);
  setState(() {

  });
}

  @override
  Widget build(BuildContext context) {
    final _tab=[
      Home(),
     // Search(),
      WishListPage(),
      Profile(),
    ];
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
             return tabCont.getCurrentTab==0? exitApp():backToHomeTab();
             // exit(0);
          },
          child: GetBuilder<DashboardTabBarController>(
            init: DashboardTabBarController(),
            builder: (value) =>   Scaffold(
              key: _scaffoldKey,
              drawer: MyDrawer(),
              body: _tab[tabCont.getCurrentTab],
              bottomNavigationBar: SnakeNavigationBar.color(
                height: 50,
                behaviour: snakeBarStyle,
                snakeShape: snakeShape,
                shape: bottomBarShape,
                padding: padding,

                ///configuration for SnakeNavigationBar.color
                snakeViewColor: selectedColor,
                selectedItemColor:
                snakeShape == SnakeShape.indicator ? selectedColor : null,
                unselectedItemColor: Colors.blueGrey,

                ///configuration for SnakeNavigationBar.gradient
                // snakeViewGradient: selectedGradient,
                // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
                // unselectedItemGradient: unselectedGradient,

                showUnselectedLabels: showUnselectedLabels,
                showSelectedLabels: true,

                currentIndex: tabCont.getCurrentTab,
                onTap: (index){
                  tabCont.updateCurrentTab(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: SizedBox(
                          height: 20,
                          child: Image(image:  tabCont.getCurrentTab==0?
                          AssetImage('assets/homeW.png'):AssetImage('assets/home.png'),)), label: 'home'),
                  // BottomNavigationBarItem(
                  //     icon: SizedBox(
                  //         height: 20,
                  //         child: Image(image:  tabCont.getCurrentTab==1? AssetImage('assets/searchIconW.png'):AssetImage('assets/searchIcon.png'),)), label: 'search'),
                  BottomNavigationBarItem(
                      icon: SizedBox(
                          height: 20,
                          child: Image(image:  tabCont.getCurrentTab==1? AssetImage('assets/heartW.png'):AssetImage('assets/heart.png'),)), label: 'like'),
                  BottomNavigationBarItem(
                      icon: SizedBox(
                          height: 20,
                          child: Image(image:  tabCont.getCurrentTab==2? AssetImage('assets/userIconW.png'):AssetImage('assets/userIcon.png'),)), label: 'location'),
                ],
                selectedLabelStyle: const TextStyle(fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontSize: 10),
              ),
            ),
          )

         
        ),
      ),
    );
  }



  final BorderRadius borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(0),
    topRight: Radius.circular(0),
  );

  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(0)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(0);

  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = true;
  bool showUnselectedLabels = false;

  Color selectedColor = AppColor.lightThemeColor;
  Gradient selectedGradient =
  const LinearGradient(colors: [Colors.pink, Colors.pink]);

  Color unselectedColor = AppColor.customBlack;
  Gradient unselectedGradient =
  const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  late Color containerColor;

}










