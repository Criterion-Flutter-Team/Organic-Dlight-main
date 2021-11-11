import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreenModal.dart';

class AllReviews extends StatefulWidget {
  // const AllReviews({Key? key}) : super(key: key);
  final String productId;

  const AllReviews({Key? key, required this.productId}) : super(key: key);
  @override
  _AllReviewsState createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {


  MyTextTheme textStyleTheme=MyTextTheme();

  void initState() {
    super.initState();
    get();
  }

  get() async{
    await getReviewAndRating();
  }

  ProductScreenModal modal=ProductScreenModal();

  getReviewAndRating()async{
    var data=await modal.getRatingAndReviewList(context,productId:widget.productId);
    if (data['responseCode'] == 1) {
      modal.getRatingList= jsonDecode(data['responseValue'])['ProductReviewAndRatingList'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
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
                    flexibleSpace: MyWidget().myAppBar(setState: setState,
                      context: context,
                      title: "All Reviews",
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
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.lightThemeColor),
                          backgroundColor: Colors.white,
                        ) ),
                    toolbarHeight: 4,
                  ),

                  SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child:  Column(
                            children: List.generate(modal.getRatingList.length, (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
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
                                            Text(modal.getRatingList[index]['rating'].toString(),
                                              style:textStyleTheme.smallW10
                                            ),
                                            SizedBox(width: 3,),
                                            Icon(Icons.star,
                                              color: Colors.white,
                                              size: 10,),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(modal.getRatingList[index]['title'].toString(),
                                      style:textStyleTheme.smallC14B
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Text(modal.getRatingList[index]['review'].toString(),
                                  style: textStyleTheme.smallC12,
                                ),
                                index==4? Container():SizedBox(height: 10,),
                              ],
                            ),),
                          ),
                        ),
                      ])),
                ],
              ),
            ],
          ),

          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton:  ,
        ),
      ),
    );
  }
}

