import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';

class Faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {

  MyTextTheme textStyleTheme=MyTextTheme();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  onPressDrawer(){
    _scaffoldKey.currentState!.openDrawer();
  }



  List questionList=[
    'I want to'
  ];



  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          appBar:    MyWidget().myAppBar(
              context: context,
            title: 'FAQ'
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 150,
                        child: Lottie.asset('assets/faq.json')),


                  ],
                ),
                SizedBox(height: 100,),

                Text('Feature will be available soon',
                style: textStyleTheme.smallL
                )

              ],
            ),
          )
        ),
      ),
    );


  }
}
