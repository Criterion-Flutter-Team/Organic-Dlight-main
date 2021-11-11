



import 'package:blinking_text/blinking_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreen.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../Common.dart';

class ViewAllBestDealPattern{
  MyTextTheme textStyleTheme=MyTextTheme();
  Common commonShimmer=Common();


  pattern( context,{listOfData}){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,15,0,15),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listOfData.length,
          itemBuilder: (BuildContext context, int index) {
            var heroT= 'allBestDealsPattern'+index.toString();
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
              child: Padding(
                padding:  EdgeInsets.fromLTRB(0,2,0,2),
                child: Card(
                  child:  Common().shimmerEffect(
                    shimmer: false,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding:  EdgeInsets.fromLTRB(0,5,0,5),
                          child: Container(
                              height:215,
                              width: MediaQuery.of(context).size.width,
                            ),
                        ),
                        Positioned(
                           left: 0,
                            right: 0,
                            child:
                            Container(
                              // aspectRatio: 2,
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: Hero(
                                  tag: heroT,
                                  child:
                                  CachedNetworkImage(
                                    placeholder: (context, url) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                                    imageUrl: imageUrl+listOfData[index]['mainImage'].toString(),
                                    errorWidget: (context, url, error) =>  Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        // borderRadius: BorderRadius.all(Radius.circular(15)),
                                        border: Border.all(color: Colors.grey.shade200,
                                            width: 2),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                          // colorFilter:
                                          // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),),


                        Positioned(
                          left: 0,
                            bottom: 52,
                            right: 0,
                            child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width-20,
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
                        //     bottom: 65,
                        //     right: 8,
                        //     child: CommonButtons().likeButton(
                        //         context,
                        //         isLiked: listOfData.isEmpty? false:
                        //           (listOfData[index]['isWishList']==1),
                        //         productCode: listOfData.isEmpty? '':listOfData[index]['productCode'],
                        //         productId: listOfData.isEmpty? '':listOfData[index]['prId'],
                        //         pageName: 'Home'
                        //     )
                        // ),

                        Positioned(
                          left: 10,
                            bottom: 65,

                            child: Text('* 4.5 (200+)',style: textStyleTheme.smallW12B,)),

                        Positioned(
                            left: 10,
                            bottom: 12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(listOfData[index]['productName'].toString(),style:textStyleTheme.smallC12B),
                                // SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(listOfData[index]['productSellingPrice'].toString(),style: textStyleTheme.smallC12B,) ,

                                    SizedBox(width: 5,),
                                    Text(listOfData[index]['productMRP'].toString(),style: textStyleTheme.smallC12BLineThrough),
                                    SizedBox(width: 5,),
                                    Text(listOfData[index]['discountInPercentage'].toString()+'%',style: textStyleTheme.smallG12
                                    ),
                                  ],
                                ),
                              ],
                            )),

                        Positioned(
                          bottom: 22,
                          right: 6,
                          child:  Container(
                            decoration: BoxDecoration(
                                color: Colors.white10,
                            ),
                            child: Row(
                              children: [
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
                          ),)

                      ],
                    ),
                  ),
                ),
              ),

            );
          }),
    );
  }

}

