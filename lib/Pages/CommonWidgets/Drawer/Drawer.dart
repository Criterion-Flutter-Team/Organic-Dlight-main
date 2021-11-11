import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/Pages/About/AboutUs.dart';
import 'package:organic_delight/Pages/Address/AddressBook/AddressBook.dart';
import 'package:organic_delight/Pages/Cart/Cart.dart';
import 'package:organic_delight/Pages/Dashboard/DashboardTabBarContrller.dart';
import 'package:get/get.dart';
import 'package:organic_delight/Pages/Dashboard/WhishList/WhishListModal.dart';
import 'package:organic_delight/Pages/Faq/Faq.dart';
import 'package:organic_delight/Pages/FromFridge/form_fridge_view.dart';
import 'package:organic_delight/Pages/LoginPage/LoginPage.dart';
import 'package:organic_delight/Pages/MyOrders/MyOrders.dart';
import 'package:organic_delight/Pages/MyOrders/MyOrdersModal.dart';



class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {


  UserData user=UserData();
  DashboardTabBarController tabCont=Get.put(DashboardTabBarController());
  MyTextTheme textStyleTheme=MyTextTheme();

  var name='';
  var contact='';
  App app=App();
  WishListModal wishmodal=WishListModal();

  MyOrdersModal modal=MyOrdersModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }


  get() async{
    name= user.getName;
    contact= user.getUserContact;


    setState(() {

    });
  }



  onPressedManageAddress() async{
    Navigator.pop(context);
    if(user.getGuestId.isEmpty){
      await app.navigate(context, AddressBook(showAddress: false));
   tabCont.updateCurrentTab(0);
  }
    else{
      await app.navigate(context, LoginPage());
      tabCont.updateCurrentTab(0);
    }}

  onPressedWishLists() async{
    Navigator.pop(context);
    if(user.getGuestId.isEmpty){
      tabCont.updateCurrentTab(1);
    }
    else{
      await app.navigate(context, LoginPage());
      tabCont.updateCurrentTab(0);
    }
    //wishmodal.getWishLists(context);
  }

  onPressedMyOrders() async{
    Navigator.pop(context);
    if(user.getGuestId.isEmpty){
      await  app.navigate(context, MyOrders());
      tabCont.updateCurrentTab(0);
    }
    else{
      await app.navigate(context, LoginPage());
      tabCont.updateCurrentTab(0);
    }

  }

  // onPressedMyOffers() async{
  //   Navigator.pop(context);
  //   app.navigate(context, MyOffer());
  // }
  onPressedMyCart() async{
    Navigator.pop(context);
   await app.navigate(context, Cart());
    tabCont.updateCurrentTab(0);
  }

  onPressedAboutUs() async {
    Navigator.pop(context);
    await app.navigate(context, AboutUs());
    tabCont.updateCurrentTab(0);
  }

  onPressedFridge() async {
    Navigator.pop(context);
    if(user.getGuestId.isEmpty){
      await app.navigate(context, FromFridgeView());
      tabCont.updateCurrentTab(0);
    }
    else{
      await app.navigate(context, LoginPage());
      tabCont.updateCurrentTab(0);
    }

  }

  onPressedFAQ() async{
    Navigator.pop(context);
    await app.navigate(context, Faq());
    tabCont.updateCurrentTab(0);
  }


 /* onPressedLogin()async{
    Navigator.pop(context);
    app.navigate(context, Dashboard());
  }*/
  // onPressedLogin()async{
  //   Navigator.pop(context);
  //   app.navigate(context, Home());
  // }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          myProfile(),
          Expanded(
            child: ListView(
              children: [
                drawerButtons(
                    icon: Icons.home,
                    title: 'Manage Your Address',
                  onPressed: onPressedManageAddress
                ),
                drawerButtons(
                    icon: Icons.favorite,
                    title: 'Wish List',
                  onPressed: onPressedWishLists
                ),
                Divider(
                  color: AppColor.customBlack,
                ),
                drawerButtons(
                    icon: Icons.reorder,
                    title: 'My Orders',
                    onPressed: onPressedMyOrders
                ),
                // drawerButtons(
                //     icon: Icons.local_offer,
                //     title: 'My Offers',
                //     onPressed: onPressedMyOffers
                // ),
                drawerButtons(
                    icon: Icons.shopping_cart,
                    title: 'My Cart',
                    onPressed: onPressedMyCart
                ),
                Divider(
                  color:AppColor.customBlack,
                ),
                drawerButtons(
                    icon: Icons.meeting_room,
                    title: 'Order From Fridge',
                    onPressed: onPressedFridge
                ),
                drawerButtons(
                    icon: Icons.info,
                    title: 'About Us',
                    onPressed: onPressedAboutUs
                ),
                // drawerButtons(
                //     icon: Icons.chat,
                //     title: 'FAQ',
                //     onPressed: onPressedFAQ
                // ),
                Divider(
                  color: AppColor.customBlack,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  drawerButtons({onPressed,String? title, icon}){
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.grey,
        padding: EdgeInsets.all(15),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
       minimumSize: Size(0, 0)
      ),
        onPressed:(){
        onPressed();
        },
        child: Row(
          children: [
            Icon(icon,
            color: AppColor.customBlack,
            size: 22,),
            SizedBox(width: 5,),
            Text(title.toString(),style:
            textStyleTheme.smallC14
            // TextStyle(color: AppColor.customBlack),
            ),
          ],
        )

    );
  }


  myProfile(){
    return  GestureDetector(
      onTap: (){
        Navigator.pop(context);
        tabCont.updateCurrentTab(2);
      },
      child: Container(
        color: AppColor.lightThemeColor,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: [
              profileImageWidget(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name.toString(),
                      style:textStyleTheme.smallW14B),
                    SizedBox(height: 5,),
                    Text(contact.toString(),
                      style:textStyleTheme.smallW14B),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  profileImageWidget(){
    return  AvatarGlow(
      glowColor: AppColor.white,
      endRadius: 60.0,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 100),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 40.0,
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          backgroundImage: AssetImage('assets/user.jpg'),
          radius: 38.0,
        ),
      ),
    );
  }

}






