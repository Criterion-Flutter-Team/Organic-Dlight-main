  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';
import 'package:organic_delight/Pages/CommonWidgets/ListPatten/ViewAllBestDealPattern.dart';

import '../HomeController.dart';
import 'package:get/get.dart';


class TodayDealPage extends StatefulWidget {


  const TodayDealPage({Key? key, categoryName,  }) : super(key: key);

  @override
  _TodayDealPageState createState() => _TodayDealPageState();
}

class _TodayDealPageState extends State<TodayDealPage> {

  HomeController controller= Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                pinned: false,
                //  snap: true,
                //  expandedHeight:  kToolbarHeight,
                forceElevated: false,
                floating: true,
                flexibleSpace: MyWidget().myAppBar(
                    context: context,
                    title: "Today's Deal Page",
                    action: [
                      CommonButtons().cartButton(context),
                    ]
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                    GetBuilder<HomeController>(
                        init: HomeController(),
                        builder: (_) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.getTodaysDealList.isEmpty? 1: controller.getTodaysDealList.length,
                              itemBuilder: (context,index){
                                List productDetails= controller.getTodaysDealList.isEmpty? []:jsonDecode(controller.getTodaysDealList[index]['productDetailsTodaysDeal']);
                                return Padding(
                                padding: const EdgeInsets.fromLTRB(15,0,15,0),
                                child:  ViewAllBestDealPattern().pattern(context,listOfData:productDetails)
                                );
                              }
                          );
                        }
                    )
                  ])),
            ],
          ),
        ),
      ),
    );
  }

}
