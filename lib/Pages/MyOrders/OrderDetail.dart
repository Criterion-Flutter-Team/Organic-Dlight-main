// Copyright 2020 J-P Nurmi <jpnurmi@gmail.com>
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/Pages/MyOrders/MyOrdersController.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'MyOrdersModal.dart';







class OrderDetail extends StatefulWidget {

  const OrderDetail({Key? key,  }) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {


  MyTextTheme textStyleTheme=MyTextTheme();

  MyOrderController myOrdersC= Get.put(MyOrderController());

  MyOrdersModal modal=MyOrdersModal();
  StepperType stepperType = StepperType.vertical;

  int _currentStatusIndex=0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    get();
  }


  get() async{
    for(var i=0;i<=orderList.length-1;i++){
        if(myOrdersC.getOrderDetailsList[0]['orderStatus']==orderList[i]['name']){
          _currentStatusIndex=i;
      }
    }
  }


  List orderList=[
    {
      'name':'Order Confirmed'
    },
    {
      'name':'Processing'
    },
    {
      'name':'Packed'
    },
    {
      'name':'Shipped'
    },
    {
      'name':'Delivered'
    }
  ];



  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                  color: AppColor.customBlack, //change your color here
                ),
                title: Text('Order Details',
                  style: textStyleTheme.largeC16
                ),
              ),
          body:  SingleChildScrollView(
            child: GetBuilder<MyOrderController>(
                init: MyOrderController(),
                builder: (_)  {
                return Container(
                  child: Column(
                    children: [
                          Column(
                            children: List.generate(myOrdersC.getOrderDetailsList.length, (index) {
                               return Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                                 child: Column(
                                   children: [
                                     Row(
                                     children: [
                            Container(
                              height: 60,
                            width: 60,
                            child:  CachedNetworkImage(
                              placeholder: (context, url) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                              imageUrl:imageUrl+myOrdersC.getOrderDetailsList[index]['mainImage'].toString(),
                              errorWidget: (context, url, error) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(color: Colors.grey.shade200,
                                      width: 2),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    // colorFilter:
                                    // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                  ),
                                ),
                              ),
                            ),
                    ),
                              SizedBox(width:10),
                              Expanded(
                              child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,8,8,8,),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text(myOrdersC.getOrderDetailsList[index]['productName'].toString(),
                              style: textStyleTheme.smallC12B
                              ),
                              SizedBox(height: 5,),
                              Wrap(
                              children: [
                              Text('Order Id:',
                                  style:textStyleTheme.smallC11B
                              ),
                              Text(myOrdersC.getOrderDetailsList[index]['orderId'].toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style:textStyleTheme.smallC10B
                              ),
                              ],
                              ),
                              Wrap(
                              children: [
                              Text('Payment Status:',
                                  style:textStyleTheme.smallC11B
                              ),
                              Text(myOrdersC.getOrderDetailsList[index]['paymentStatus'].toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style:textStyleTheme.smallC10B
                              ),
                              ],
                              ),
                              ],
                              ),
                              ),
                              ),
                              ],),
                                     SizedBox(height: 5,),
                                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                       Wrap(
                                         children: [
                                           Text('Paid Amount:',
                                               style:textStyleTheme.smallC11B
                                           ),
                                           Text('\u20B9'+myOrdersC.getOrderDetailsList[index]['paidAmount'].toString(),
                                             maxLines: 3,
                                             overflow: TextOverflow.ellipsis,
                                             style: textStyleTheme.smallL10B
                                           ),
                                         ],
                                       ),
                                       Wrap(
                                         children: [
                                           Text('Qty:',
                                               style:textStyleTheme.smallC11B
                                           ),
                                           Text(myOrdersC.getOrderDetailsList[index]['quantity'].toString(),
                                             maxLines: 3,
                                             overflow: TextOverflow.ellipsis,
                                             style: textStyleTheme.smallL10B
                                           ),
                                         ],
                                       ),
                                     ],),
                                     Divider(),
                                   ],
                                 )
                               );  }),
                          ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Wrap(
                              children: [
                                Text('Total Amount:',
                                    style: textStyleTheme.smallC11B
                                ),
                                Text('\u20B9'+myOrdersC.getOrderDetailsList[0]['payableAmount'].toString(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style:textStyleTheme.smallL10B
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                  ListView.builder(itemCount: orderList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                    return  TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.1,
                            indicatorStyle:  IndicatorStyle(
                            width:26,
                            color:  (index>_currentStatusIndex)? AppColor.grey:AppColor.lightThemeColor,
                            padding: const EdgeInsets.all(4),
                            iconStyle: IconStyle(
                            color: Colors.white,
                            iconData: Icons.check,
                            ),
                            ),
                                beforeLineStyle:  LineStyle(
                                  color:(index>_currentStatusIndex)? AppColor.grey: AppColor.lightThemeColor,
                                  thickness: 4,
                                ),
                          endChild: Container(
                          constraints: const BoxConstraints(
                          minHeight: 40,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(orderList[index]['name'],
                              style: textStyleTheme.small14
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          ),
                          );
                      }),
                      SizedBox(height: 35,)


                    ],
                  ),
                );
              }
            ),
          ),

        ),
      ),
    );
  }

}
