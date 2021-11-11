import 'package:blinking_text/blinking_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/Pages/Common.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreen.dart';
import 'package:slide_countdown/slide_countdown.dart';



class TodayDealPattern {

  MyTextTheme textStyleTheme=MyTextTheme();
  Common commonShimmer=Common();


  pattern( context , {listOfData}){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,15,0,15),
      child: SizedBox(
        height: 180,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:  listOfData.length,
            itemBuilder: (BuildContext context, int index) {

              print('ssssssssssssssssssssss'+listOfData.toString());
              var heroT= 'firstPattern'+index.toString();
              return  GestureDetector(
                onTap: () async {

                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ProductScreen(
                      heroTag: heroT,
                      productVarient: listOfData[index]['prId'].toString(),
                      productId: listOfData[index]['productId'].toString(),
                      productCode:listOfData[index]['productCode'].toString(),
                      pageName: 'todaysDeal',
                    );
                  }));
                },
                child: Common().shimmerEffect(

                  shimmer: listOfData.isEmpty,

                  child: Card(
                    child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            // aspectRatio: 2,
                            height: 180,
                            width: MediaQuery.of(context).size.width-40,
                            child: Hero(
                                tag: heroT,
                                child:CachedNetworkImage(
                                  placeholder: (context, url) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                                  imageUrl: imageUrl+listOfData[index]['mainImage'].toString(),
                                  errorWidget: (context, url, error) =>  Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade200,
                                          width: 2),
                                      image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                    ),
                                  ),
                                )
                            ),
                          ),

                          Positioned(
                            left: 0,
                            bottom: 2,
                              right: 0,
                              child: Container(
                                height: 100,
                            width: MediaQuery.of(context).size.width-32,
                            decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.grey.shade300.withOpacity(0.1),
                                    Colors.black.withOpacity(0.9),
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  tileMode: TileMode.repeated
                              ),
                            ),
                          )),

                          // Positioned(
                          //     top: 16,
                          //     right: 12,
                          //     child: CommonButtons().likeButton(
                          //       context,
                          //       isLiked: listOfData.isEmpty? false:
                          //       (listOfData[index]['isWishList']==1),
                          //         productCode: listOfData.isEmpty? '':listOfData[index]['productCode'],
                          //         productId: listOfData.isEmpty? '':listOfData[index]['prId'],
                          //         pageName: 'Home'
                          //     )
                          // ),

                          Positioned(
                            left: 25,
                              bottom: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(listOfData[index]['productName'].toString(),style: TextStyle(fontSize: 13,
                                    color: Colors.white,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(listOfData[index]['productSellingPrice'].toString(),style: TextStyle(fontSize: 13,
                                        color: Colors.white,fontWeight: FontWeight.bold),) ,

                                      SizedBox(width: 5,),
                                      Text(listOfData[index]['productMRP'].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,
                                        color: Colors.white,decoration: TextDecoration.lineThrough,
                                        decorationThickness:1.8
                                      ),),
                                      SizedBox(width: 5,),
                                      Text(listOfData[index]['discountInPercentage'].toString()+'%',style: TextStyle(fontSize: 13,
                                        color: AppColor.lightThemeColor,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ],
                              )),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children:[
                                SizedBox(width: 5,),
                                BlinkText(
                                    'Deal Ends In:',
                                    style: textStyleTheme.smallBCB,
                                    beginColor: Colors.grey[400],
                                    endColor: Colors.black,
                                    times:10000,
                                    duration: Duration(seconds: 1)
                                ),
                                SlideCountdown(
                                  duration:  Duration(days: 1,),
                                  fade: false,
                                  decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  textStyle: textStyleTheme.smallBCB.copyWith(
                                    color: Colors.grey[600]
                                  )
                                ),
                              ],
                            ),
                          )

                        ],
                      ),
                  ),
                ),

              );

            }),
      ),
    );
  }

}

