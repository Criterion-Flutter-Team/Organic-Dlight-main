import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/MyOrders/MyOrdersModal.dart';
import 'package:get/get.dart';
import 'package:organic_delight/Pages/MyOrders/OrderDetail.dart';
import 'MyOrdersController.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  MyTextTheme textStyleTheme=MyTextTheme();

  MyOrderController myOrdersC= Get.put(MyOrderController());
  App app = App();

  MyOrdersModal modal=MyOrdersModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    get();
  }


  get() async{
    modal.myOrders(context);
  }

  getOrderDetails(val) async {

  await modal.viewOrderDetails(context,orderDetailsMainId:val );
    setState(() {
    });
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<MyOrderController>(
              init: MyOrderController(),
              builder: (_)  {
              return CustomScrollView(
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
                        title: 'My Orders',
                    ),
                  ),
                  myOrdersC.getMyOrdersList.isNotEmpty?
                  SliverList(
                      delegate: SliverChildListDelegate([
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            productListWidget(),
                          ],
                        ),
                      ])):
                  SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 200.0, horizontal: 5.0),
                              child: Text('No Ordered Yet',
                                style: textStyleTheme.smallL
                              )),
                        ),
                      ])),
                ],
              );
            }
          ),
        ),
      ),
    );
  }







  productListWidget(){
    return     Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Column(
            children: List.generate(myOrdersC.getMyOrdersList.length, (index) {
              // var productPrice=(myOrdersC.getMyOrdersList[index]['totalMRP']).toStringAsFixed(2);
              var mainId=myOrdersC.getMyOrdersList[index]['orderDetailsMainId'].toString();

              return  InkWell(
                onTap: () async{
                await  getOrderDetails(mainId);
                await  app.navigate(context, OrderDetail(
                  ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                                imageUrl:imageUrl+myOrdersC.getMyOrdersList[index]['mainImage'].toString(),
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
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,8,8,8,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(myOrdersC.getMyOrdersList[index]['productName'].toString(),
                                    style:textStyleTheme.smallC12B
                                  ),
                                  SizedBox(height: 5,),
                                  Wrap(
                                    children: [
                                      Text('Order Id: ',
                                          style:textStyleTheme.smallC11B
                                      ),
                                      Text(myOrdersC.getMyOrdersList[index]['orderId'],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style:textStyleTheme.smallC10B
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text('Order Date: ',
                                          style:textStyleTheme.smallC11B
                                      ),
                                      Text(myOrdersC.getMyOrdersList[index]['entryDate'],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style:textStyleTheme.smallC10B
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text('Order Status:',
                                          style: textStyleTheme.smallC11B
                                      ),
                                      Text(' ' +myOrdersC.getMyOrdersList[index]['orderStatus'].toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyleTheme.smallL10B
                                      ),
                                    ],
                                  ),



                                  // Row(
                                  //   children: [
                                  //     Text('(1Kg)',
                                  //       style: TextStyle(
                                  //           color: AppColor.customBlack,
                                  //           fontSize: 10,
                                  //           fontWeight: FontWeight.bold
                                  //       ),),
                                  //     Text('10%off',
                                  //       style: TextStyle(
                                  //         color: AppColor.customGreen,
                                  //         fontSize: 12,
                                  //       ),),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              Text('Payable Amount:',
                                  style: textStyleTheme.smallC11B
                              ),
                              Text('\u20B9'+myOrdersC.getMyOrdersList[index]['payableAmount'].toString(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style:textStyleTheme.smallL10B
                              ),
                            ],
                          ),
                          // Container(
                          //   height: 30,
                          //   child: TextButton(
                          //     style: TextButton.styleFrom(
                          //       primary: Colors.grey,
                          //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          //     ),
                          //     onPressed: () {
                          //       alertToast(context, 'Feature will be available soon');
                          //     },
                          //     child: Text('Cancel Order',
                          //       style: textStyleTheme.smallO12B
                          //     ),
                          //   ),
                          // ),
                          // FlatButton(
                          //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          //   height: 0,
                          //   padding: const EdgeInsets.all(5),
                          //   minWidth: 0,
                          //   child: Text('Cancel Order',
                          //     style: TextStyle(
                          //       color: AppColor.orangeColor,
                          //       fontSize: 12,
                          //       fontWeight: FontWeight.bold,
                          //     ),),
                          //   onPressed: (){
                          //     AlertDialogue().show(context, "Alert", "Feature will be available soon");
                          //   },
                          // ),


                        ],
                      ),
                    ),

                   //  Row(
                   //    children: [
                   //      Expanded(
                   //        flex: 14,
                   //        child: Wrap(
                   //          children: [
                   //            // Text(' \u20B9 '+productList[index]['price'].toStringAsFixed(2)+' ',
                   //            //   style: TextStyle(
                   //            //     color: AppColor.customBlack,
                   //            //     fontSize: 12,
                   //            //     fontWeight: FontWeight.bold,
                   //            //   ),),
                   //            Text('900',
                   //              style: TextStyle(
                   //                color: AppColor.customBlack,
                   //                fontSize: 12,
                   //                fontWeight: FontWeight.bold,
                   //                decoration: TextDecoration.lineThrough,
                   //                decorationThickness: 1.8,
                   //              ),),
                   //            SizedBox(width: 5,),
                   //            Text('10%off',
                   //              style: TextStyle(
                   //                color: AppColor.customGreen,
                   //                fontSize: 12,
                   //              ),),
                   //          ],
                   //        ),
                   //      ),
                   //      SizedBox(width: 5,),
                   //      // Expanded(
                   //      //   flex: 6,
                   //      //   // child: Text('qty: '+productList[index]['quantity'].toString(),
                   //      //   //   textAlign: TextAlign.center,
                   //      //   //   style: TextStyle(
                   //      //   //       color: AppColor.lightThemeColor,
                   //      //   //       fontSize: 12
                   //      //   //   ),),
                   //      // ),
                   //      SizedBox(width: 5,),
                   //      Expanded(
                   //          flex: 4,
                   //          child: Text('\u20B9'+myOrdersC.getMyOrdersList[index]['payableAmount'].toString(),
                   //            textAlign: TextAlign.end,
                   //            style: TextStyle(
                   //                color: AppColor.customBlack,
                   //                fontSize: 12
                   //            ),
                   //          )),
                   //
                   //    ],
                   //  ),
                   //  SizedBox(height: 10,),
                   // Row(
                   //   children: [
                   //     Expanded(
                   //       child: Column(
                   //         crossAxisAlignment: CrossAxisAlignment.start,
                   //         children: [
                   //           Text('Delivered',
                   //             style: TextStyle(
                   //               color: AppColor.lightThemeColor,
                   //               fontSize: 12,
                   //               fontWeight: FontWeight.bold,
                   //             ),),
                   //           Text('12/0ct/2021 6:32 pm',
                   //             style: TextStyle(
                   //               color: AppColor.customBlack,
                   //               fontSize: 12,
                   //               fontWeight: FontWeight.bold,
                   //             ),),
                   //         ],
                   //       ),
                   //     ),
                   //     reOrderButton(),
                   //   ],
                   // ),
                    Divider(),
                  ],
                ),
              );
            }

            ),
          ),
        ],
      ),
    );
  }



  reOrderButton(){
    return

      TextButton(

        style: TextButton.styleFrom(

          padding: EdgeInsets.all(8),
          backgroundColor: AppColor.lightThemeColor,
          shape: AppWidgets.buttonShape,
        ),

        onPressed: () {
        },
        child: Text('Reorder',
          style:textStyleTheme.smallO12B
        ),
      );

    // FlatButton(
    //   padding: EdgeInsets.all(8),
    //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //   height: 0,
    //   minWidth: 0,
    //   child: Text('Reorder',
    //     style: TextStyle(
    //       color: AppColor.orangeColor,
    //       fontSize: 12,
    //       fontWeight: FontWeight.bold,
    //     ),),
    //   onPressed: (){
    //   },
    // );
  }










}
