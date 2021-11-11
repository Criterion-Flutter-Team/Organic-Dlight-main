import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/appColors.dart';


class Second {

  pattern(){
    return SizedBox(
      height: 80,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return AvatarGlow(
              glowColor: AppColor.lightThemeColor,
              endRadius: 40.0,
              duration: Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              child: Material(     // Replace this child with your own
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child:  CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SizedBox(
                          height: 22,
                          child: Image(image: AssetImage('assets/examplePie.png'),)))
              ),
            );
          }),
    );
  }

}