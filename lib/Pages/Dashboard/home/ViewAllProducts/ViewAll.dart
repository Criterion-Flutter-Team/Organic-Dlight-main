import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';
import 'package:organic_delight/Pages/CommonWidgets/ListPatten/ViewAllPattern.dart';
import 'package:get/get.dart';
import '../HomeController.dart';


class ViewAll extends StatefulWidget {
  final String categoryName;
  // final List dataList;

  const ViewAll({Key? key, required this.categoryName, }) : super(key: key);

  @override
  _ViewAllState createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {

  HomeController controller= Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    title: widget.categoryName,
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
                            itemCount: controller.getAllProductList.isEmpty? 1: controller.getAllProductList.length,
                            itemBuilder: (context,index){
                              List productDetails= controller.getAllProductList.isEmpty? []:jsonDecode(controller.getAllProductList[index]['productDetails']);
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(15,0,15,0),
                            child:  ViewAllPattern().pattern(context: context,listOfData:productDetails),
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
