
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreen.dart';
import '../../Common.dart';

class ViewAllPattern {
  MyTextTheme textStyleTheme=MyTextTheme();
  Common commonShimmer=Common();

  pattern({context,
    required List listOfData}){
    return  Padding(
      padding: const EdgeInsets.fromLTRB(0,15,0,15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 5/6,
        ),
        itemCount:listOfData.length,

        itemBuilder: (BuildContext context, int index) {

          String heroT= listOfData.isEmpty? 'UniqueGrid'+index.toString():listOfData[index]['productCode'].toString()+index.toString();
          String code= listOfData.isEmpty? '':listOfData[index]['productCode'].toString();
          String productId= listOfData.isEmpty? '':listOfData[index]['productId'].toString();
          String varient= listOfData.isEmpty? '':listOfData[index]['prId'].toString();

          String productName= listOfData.isEmpty? 'Loading Product':listOfData[index]['productName'].toString();
          String sellingPrice= listOfData.isEmpty? '':listOfData[index]['productSellingPrice'].toString();
          String mrp= listOfData.isEmpty? '0.00':listOfData[index]['productMRP'].toString();
          String discount= listOfData.isEmpty? '0.00':listOfData[index]['discountInPercentage'].toString();


          // print(listOfData[index]['isWishList'].toString()+' '+index.toString()+'yjiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');


          return   GestureDetector(
            onTap: (){
              if(listOfData.isNotEmpty){
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return ProductScreen(
                    heroTag: heroT,
                    productCode: code,
                    productId: productId,
                    productVarient: varient,
                  );
                }));
              }
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,4,0,4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.grey.shade200,
                            width: 2)
                    ),
                    child: Common().shimmerEffect(

                      shimmer: listOfData.isEmpty,

                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Hero(
                                tag: heroT.toString(),
                                child: listOfData.isEmpty?  Container(decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(color: Colors.grey.shade200,
                                      width: 2),
                                ),):
                                CachedNetworkImage(
                                  placeholder: (context, url) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                                  imageUrl:imageUrl+listOfData[index]['mainImage'].toString(),
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
                          ),



                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,0,8,8,),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4,4,4,4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(productName.toString().toUpperCase(),
                                    style:textStyleTheme.smallC12B
                                  ),
                                  // Expanded(
                                  //   child: Wrap(
                                  //     children: [
                                  //       Text("The world's tallest ice cream cone was over 9 feet tall. It was scooped in Italy. Most of the vanilla used to make ice cream comes from Madagascar & Indonesia. Chocolate syrup is the world's most popular ice cream topping.",
                                  //         maxLines: 2,
                                  //         overflow: TextOverflow.ellipsis,
                                  //         style: TextStyle(
                                  //             color: AppColor.customBlack,
                                  //             fontSize: 10,
                                  //             fontWeight: FontWeight.bold
                                  //         ),),
                                  //     ],
                                  //   ),
                                  // ),

                                  Row(
                                    children: [
                                      Text('\u20B9 '+sellingPrice.toString()+' ',
                                        style: textStyleTheme.smallC12B
                                      ),
                                      Text(mrp.toString(),
                                        style:textStyleTheme.smallC12BLineThrough
                                      ),
                                      SizedBox(width: 5,),
                                      Text(discount.toString()+'%',
                                        style: textStyleTheme.smallG12
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
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 10,
                  child: CommonButtons().likeButton(
                      context,
                      isLiked: listOfData.isEmpty? false:
                      (listOfData[index]['isWishList']==1),
                      productCode: listOfData.isEmpty? '':listOfData[index]['productCode'],
                      productId: listOfData.isEmpty? '':listOfData[index]['prId'],
                      pageName: 'ViewAll'
                  ),
                ),
                // Positioned(
                //   top: 140,
                //   right: 10,
                //   child:  SlideCountdown(
                //     duration: const Duration(days: 11),
                //     fade: true,
                //     decoration: BoxDecoration(
                //       // color: Colors.white,
                //     ),
                //     textStyle: const TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}