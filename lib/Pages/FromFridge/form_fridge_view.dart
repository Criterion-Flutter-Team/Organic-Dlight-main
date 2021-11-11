import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/AppManager/widgets/MyCustomSD.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';
import 'package:organic_delight/Pages/CommonWidgets/ListPatten/GridList.dart';
import 'package:organic_delight/Pages/FromFridge/from_fridge_modal.dart';
import 'package:get/get.dart';

import 'FridgeCart/fridge_cart_modal.dart';
import 'form_fridge_controller.dart';

class FromFridgeView extends StatefulWidget {
  const FromFridgeView({Key? key}) : super(key: key);

  @override
  _FromFridgeViewState createState() => _FromFridgeViewState();
}

class _FromFridgeViewState extends State<FromFridgeView> {

  FromFridgeModal modal=FromFridgeModal();

  @override

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async{
  await  modal.getFridgeList(context);
  }

  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<FromFridgeController>(
              init: FromFridgeController(),
              builder: (_) {
                return Stack(
                  children: [
                    CustomScrollView(
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
                              action: [
                                CommonButtons().cartButton(context,
                                    pageName: 'fridgePage',
                                ),
                              ]
                          ),
                        ),
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.transparent,
                          pinned: true,
                          //  snap: true,
                          //  expandedHeight:  kToolbarHeight,
                          forceElevated: false,
                          floating: true,
                          elevation: 0,
                          flexibleSpace: Visibility(
                              visible: false,
                              child: LinearProgressIndicator(
                                valueColor:  AlwaysStoppedAnimation<Color>(AppColor.lightThemeColor),
                                backgroundColor: Colors.white,
                              )),
                          toolbarHeight:  4 ,
                        ),

                        SliverList(
                            delegate: SliverChildListDelegate([
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                  MyCustomSD(
                                    listToSearch: modal.controller.getFridgeList,
                                    hideSearch: true,
                                    valFrom: 'fridgeName',
                                    borderColor:AppColor.lightThemeColorShade4,
                                    height: 80,
                                    label: 'Select Fridge',
                                    onChanged: (val) async {
                                      if (val != null) {
                                       await modal.getAllProductFridge(context,fridgeId: val['id']);
                                      }
                                      // else{
                                      //   controller.updateLeaveTypeId=0;
                                      // }
                                    },),
                                  SizedBox(height: 10,),
                                  modal.controller.getAllFridgeProduct.isNotEmpty? productList():Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 100,),
                                      Text('Please Select Fridge',
                                        style:MyTextTheme().smallL
                                    )
                                  ],),
                                  ],
                                ),
                              ),
                            ])),
                      ],
                    ),
                  ],
                );
              }
          ),
        ),
      ),
    );

}

  productList( ){
    return   Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: modal.controller.getAllFridgeProduct.isEmpty? 1: modal.controller.getAllFridgeProduct.length,
            itemBuilder: (context,index){
              List productDetails= modal.controller.getAllFridgeProduct.isEmpty? []:jsonDecode(modal.controller.getAllFridgeProduct[index]['productDetails']);
              return Column(
              children: [
              Grid().pattern(context: context,listOfData: productDetails,dataCount: 4,pageName:'fridgePage',)
              ],
              );
            })
      ],
    );
  }


}
