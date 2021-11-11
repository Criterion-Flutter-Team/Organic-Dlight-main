import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/Pages/Common.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';



class First {
  MyTextTheme textStyleTheme=MyTextTheme();
  Common commonShimmer=Common();

  List todayList=[
    {
      'title': 'chocolate cake',
      'imges':'https://i1.fnp.com/images/pr/l/v20210207000630/beauty-in-pink-chocolate-cake-2-kg_1.jpg',
      'amount': '0.46 (gm)',
      'val': '40.9%',
    },
    {
      'title': 'Dark cake',
      'imges':'https://imgcdn.floweraura.com/styles/main_product_image/public/Cake009248-A.jpg',
      'amount': '0.29 (gm)',
      'val': '0.56%',
    },
    {
      'title': 'chocolate ice-cream',
      'imges':'https://joyfoodsunshine.com/wp-content/uploads/2020/06/homemade-chocolate-ice-cream-recipe-7.jpg',
      'amount': '0.23 (gm)',
      'val': '0.36%',
    },
    {
      'title': 'Cone ice-cream',
      'imges':'https://media.istockphoto.com/photos/front-view-of-real-edible-ice-cream-cone-with-3-different-scoops-of-picture-id1148364081',
      'amount': '0.57 (gm)',
      'val': '0.07%',
    },
    {
      'title': 'White Coffee',
      'imges':'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/flat-white-3402c4f.jpg?quality=90&resize=960,872',
      'amount': '0.88 (gm)',
      'val': '0.0%',
    },
    {
      'title': 'Cold Coffee',
      'imges':'https://static.toiimg.com/thumb/53859488.cms?width=800&height=800&imgsize=150956',
      'amount': '1.46 (gm)',
      'val': '0.0%',
    },
    {
      'title': 'Cappuccino Coffee',
      'imges':'https://5.imimg.com/data5/XA/OV/MY-43883512/iced-cappuccino-cold-coffee-500x500.png',
      'amount': '3.46 (gm)',
      'val': '0.0%',
    },
  ];

  pattern({listOfData}){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,15,0,15),
      child: SizedBox(
        height: 180,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: todayList.isEmpty? 4:todayList.length,
            itemBuilder: (BuildContext context, int index) {
              var heroT= 'firstPattern'+index.toString();
              return  GestureDetector(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (_) {
                  //   return ProductScreen(
                  //     heroTag: heroT,
                  //   );
                  // }));
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8,8,8,8),
                          child: Container(
                              width: 160,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(color: Colors.grey.shade200,
                                      width: 2)
                              ),
                              child: Common().shimmerEffect(

                                shimmer: todayList.isEmpty,

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(4,4,4,6),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(todayList[index]['title'],
                                                    style:textStyleTheme.smallC12B
                                                ),
                                              ),
                                              Text('\u20B9 350 ',
                                                  style: textStyleTheme.smallC12B
                                              ),
                                              Text('900',
                                                  style: textStyleTheme.smallC12BLineThrough
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text('(1Kg)',
                                                  style:textStyleTheme.smallC10B
                                                  ,),
                                              ),
                                              Text('10%off',
                                                  style: textStyleTheme.smallG12
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                              child:
                              CachedNetworkImage(
                                placeholder: (context, url) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                                imageUrl: todayList[index]['imges'],
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
                              )
                            // Container(
                            //   decoration: BoxDecoration(
                            //       color: AppColor.white,
                            //       borderRadius: BorderRadius.all(Radius.circular(15)),
                            //       border: Border.all(color: Colors.grey.shade200,
                            //           width: 2),
                            //       image: todayList.isEmpty? null:DecorationImage(
                            //          image: NetworkImage(todayList[index]['imges']),
                            //       fit: BoxFit.cover
                            //       )
                            //   ),
                            // ),
                          ),
                        ),
                      ),

                    ),
                    Positioned(
                        top: 5,
                        right: 25,
                        child: CommonButtons().likeButton(
                            context,
                            isLiked: false
                        )
                    ),
                  ],
                ),

              );

            }),
      ),
    );
  }

}

