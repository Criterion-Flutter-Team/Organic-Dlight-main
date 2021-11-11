

import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/Pages/Dashboard/WhishList/WhishListModal.dart';

class MyWidget {
  MyTextTheme textStyleTheme=MyTextTheme();
  WishListModal wishListMod = WishListModal();

  myAppBar({
    setState,
    context,
    leadingIcon,
    title,
    List<Widget>? action,
}){
    return AppBar(
      leading: leadingIcon?? IconButton(
        icon: Icon(Icons.arrow_back,
        color: AppColor.customBlack,),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      title:  title==null? Container(
        child: SizedBox(
            height: 15,
            child: Image(image: AssetImage('assets/logo.png'),)),
      ):


      Text(title,
      style:textStyleTheme.mediumC15
      ),
      centerTitle: title==null? true:false,
      backgroundColor: Colors.white,
      actions: action,

    );
  }
}