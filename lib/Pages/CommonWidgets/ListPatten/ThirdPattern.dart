import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';


class Third {
  List populerList=[
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

  pattern({context,listOfData}){
    return  Padding(
      padding: const EdgeInsets.fromLTRB(0,15,0,15),
      child: Column(
          children: List.generate(populerList.length, (index) {
            var heroT= 'secondPattern'+index.toString();
            return   GestureDetector(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (_) {
                //   return ProductScreen(
                //     heroTag: heroT,
                //   );
                // }));
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,4,0,4),
                    child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: Colors.grey.shade200,
                                width: 2)
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: AspectRatio(
                                aspectRatio: 16/12,
                                child: Hero(
                                  tag: heroT,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        border: Border.all(color: Colors.grey.shade200,
                                            width: 2),
                                        image: DecorationImage(
                                            image: NetworkImage(populerList[index]['imges']),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
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
                                      Text('ICE CREAME',
                                        style: TextStyle(
                                            color: AppColor.customBlack,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      Expanded(
                                        child: Wrap(
                                          children: [
                                            Text("The world's tallest ice cream "
                                                "cone was over 9 feet tall. It"
                                                " was scooped in Italy. Most of"
                                                " the vanilla used to make ice c"
                                                "ream comes from Madagascar & In"
                                                "donesia. Chocolate syrup is the"
                                                " world's most popular ice crea"
                                                "m topping.",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: AppColor.customBlack,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                          ],
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Text('\u20B9 350 ',
                                            style: TextStyle(
                                              color: AppColor.customBlack,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),),
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
                        )
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: CommonButtons().likeButton(
                      context
                    ),
                  ),
                ],
              ),
            );
          }


          )
      ),
    );
  }
}