import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/appColors.dart';

import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';



class SearchList {

  pattern(context,{listOfData,index}){
    var heroT= 'searchListPattern'+index.toString();
    return  GestureDetector(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(builder: (_) {
        //   return ProductScreen(
        //     heroTag: heroT,
        //     // data: listOfData,
        //   );
        // }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                SizedBox(height: 40,),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: Colors.grey.shade200,
                              width: 2)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Hero(
                              tag: heroT,
                              child: Container(
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4,4,4,6),
                            child: Column(
                              children: [

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text('CHOCLATE CAKE',
                                        style: TextStyle(
                                            color: AppColor.customBlack,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ),
                                    SizedBox(width: 5,),
                                    Text('\u20B9 350 ',
                                      style: TextStyle(
                                        color: AppColor.customBlack,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('900',
                                      style: TextStyle(
                                        color: AppColor.customBlack,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 1.8,
                                      ),),
                                    SizedBox(width: 5,),
                                    Text('10%off',
                                      style: TextStyle(
                                        color: AppColor.customGreen,
                                        fontSize: 12,
                                      ),),

                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      )
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Padding(
                padding:  EdgeInsets.fromLTRB(25,0,25,0),
                child: AspectRatio(
                  aspectRatio: 16/15,
                  child: Hero(
                    tag: heroT,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: Colors.grey.shade200,
                              width: 2),
                          image: DecorationImage(
                              image: AssetImage('assets/exampleCake.png'),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0,
                right: 10,
                child: CommonButtons().likeButton(
                  context
                )
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child:  Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.darkGreen,
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4,2,4,2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('4.4',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10
                            ),),
                          SizedBox(width: 5,),
                          Icon(Icons.star,
                            color: Colors.white,
                            size: 10,),
                          SizedBox(width: 5,),
                          Text('(112 reviews)',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10
                            ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


