

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreen.dart';
import 'package:organic_delight/Pages/Dashboard/WhishList/WhishListModal.dart';

// App app=App();

class WishList {

  MyTextTheme textStyleTheme=MyTextTheme();
  final localStorage = GetStorage();
  WishListModal wishModal = WishListModal();

  pattern(setState,{context, required List listOfData,}){
    return  Column(
        children: List.generate(listOfData.length, (index) {
          var heroT= 'userWishList'+index.toString();
          return   GestureDetector(
            onTap: () async{
              await App().navigate(context, ProductScreen(
                heroTag: heroT,
                productCode: listOfData[index]['productCode'].toString(),
                productVarient: listOfData[index]['productVarientId'].toString(),
                productId: listOfData[index]['productId'].toString(),
              ) );
              wishModal.getWishLists(context);

            },

            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,4,0,4),
                  child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: AppColor.white,

                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)
                          ),
                          border: Border.all(color: Colors.grey.shade200,
                              width: 2)
                      ),

                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  padding: const EdgeInsets.all(8.0),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Hero(
                                      tag: heroT,
                                      child: CachedNetworkImage(
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

                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //       color: AppColor.white,
                                      //       borderRadius: BorderRadius.all(Radius.circular(15)),
                                      //       border: Border.all(color: Colors.grey.shade200,
                                      //           width: 2),
                                      //       image: DecorationImage(
                                      //           image: NetworkImage(imageUrl+listOfData[index]['mainImage'].toString()),
                                      //           fit: BoxFit.cover
                                      //       )
                                      //   ),
                                      // ),

                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0,8,8,8,),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(4,4,4,4),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(listOfData[index]['productName'].toString(),
                                            style: textStyleTheme.smallC12B
                                          ),
                                          Text(listOfData[index]
                                          ['unitValue'].toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style:textStyleTheme.smallC10B
                                               ),
                                          Text(listOfData[index]
                                          ['colorName'].toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style:textStyleTheme.smallC10B
                                          ),
                                          Expanded(child: SizedBox()),
                                          Row(
                                            children: [

                                              Text(listOfData[index]['productSellingPrice'].toString(),
                                                style:textStyleTheme.smallC12B
                                              ),
                                              Text(listOfData[index]['productMRP'].toString(),
                                                style: textStyleTheme.smallC12BLineThrough
                                              ),
                                              SizedBox(width: 5,),
                                              Text(listOfData[index]['discountInPercentage'].toString()+'%OFF',
                                                style:textStyleTheme.smallG12),
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
                                ),
                              ],
                            ),
                          ),
                          CommonButtons().wishListCartButton(setState,context,dataMap: listOfData[index]),
                        ],
                      )
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: CommonButtons().likeButton(
                      context,
                      enable: false,
                      isLiked: true),
                ),
              ],
            ),
          );
        }


        )
    );
  }


}


