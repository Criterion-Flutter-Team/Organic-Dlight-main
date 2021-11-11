
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/CheckForUpdate.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/Common.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';
import 'package:organic_delight/Pages/CommonWidgets/Drawer/Drawer.dart';
import 'package:organic_delight/Pages/CommonWidgets/ListPatten/TodayDealPattern.dart';
import 'package:organic_delight/Pages/CommonWidgets/ListPatten/GridList.dart';
import 'package:organic_delight/Pages/Dashboard/home/HomeModal.dart';
import 'package:organic_delight/Pages/Dashboard/home/SearchProducts/SerachProductView.dart';
import 'package:organic_delight/Pages/Dashboard/home/ViewAllProducts/ViewAll.dart';
import 'HomeController.dart';
import 'package:get/get.dart';

import 'TodayDeal/TodaysDealPage.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin{

  MyTextTheme textStyleTheme=MyTextTheme();
  Common commonShimmer=Common();
  var _current=0;
  double paddingOfWholeScreen=15.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  App app=App();

  bool isLoading=false;
  HomeController controller= Get.put(HomeController());
  HomeModal modal=HomeModal();

 final List images = [
    'https://assets.blog.foodnetwork.ca/imageserve/wp-content/uploads/sites/6/2015/04/Strawberries-and-Cream-Sponge-Cake/x.jpg',
    'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/birthday-cakes-1562745419.jpg?crop=1.00xw:0.752xh;0,0.156xh&resize=1200:*',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQsosC8KRMqs2dGPaO8AyD_qxKCBcbGhyqoA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkkGbtJiJu1dH4hNkzZeqcBTSl1eivepOjAw&usqp=CAU',
    'https://i.ytimg.com/vi/dfUmp8pmodU/maxresdefault.jpg',
  ];


  List homeCategoryData=[
    {
      'category': "Today's Best Deals",
      'pattern': 1,
      'data': []
    },
    // {
    //   'category': "Discover By Categories",
    //   'pattern': 2,
    //   'data': []
    // },
    // {
    //   'category': "Populer Items",
    //   'pattern': 3,
    //   'data': []
    // },

  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }



  get() async{
    await Updater().checkVersion(context);
    await getAllProduct();
    await todaysBestProduct();

   // await modal.initUniLinks(context);

  }



  getAllProduct() async{
    controller.removeProductList();

    await modal.getAllProduct(context);
  }
  onPressedViewAll(categoryName,dataList){
    app.navigate(context, ViewAll(
      categoryName: categoryName,
      // dataList: dataList,

    ));
  }

  onPressedTodaysDealViewAll(dataList){
    app.navigate(context, TodayDealPage(

      // dataList: dataList,

    ));
  }



  onPressDrawer() async{
     _scaffoldKey.currentState!.openDrawer();
      // var data=await  DashboardModal().getAllProduct(context);
      // print(data);
  }
  List bestDeal=[];

  todaysBestProduct() async{

   await modal.getTodaysDealProduct(context);
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async{
          await getAllProduct();
        },
        child: CustomScrollView(
        slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          pinned: false,
          //  snap: true,
          //  expandedHeight:  kToolbarHeight,
          forceElevated: false,
          floating: true,
          flexibleSpace: Column(
          children: [
            MyWidget().myAppBar(
                context: context,
                leadingIcon: CommonButtons().drawerButton(onPressDrawer),
                action: [
                  CommonButtons().cartButton(context,),
                ]
            ),
           Expanded(
            child:  searchProducts(),
           )
          ],
          ),

          expandedHeight: 100,
        ),

        SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding:  EdgeInsets.all(paddingOfWholeScreen),
                child: GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        upperPromotionalImages(),
                        Updater().updateContainer(),
                        // bestDeal(),
                        todaysDeal(),
                        // Column(
                        //   children: List.generate(homeCategoryData.length, (index) =>
                        //       Column(
                        //         children: [
                        //           // TodayDealPattern().pattern(),
                        //           homeCategoryFields(
                        //               title: "Today's Best Deals",
                        //               pressAll: (){
                        //                 app.navigate(context,TodayDealPage(
                        //
                        //                 ));
                        //                  }
                        //           ),
                        //           TodayDealPattern().pattern(context,  )
                        //           // homeCategoryData[index]['pattern']==1?
                        //
                        //         //
                        //         //   :homeCategoryData[index]['pattern']==2?
                        //         //   Second().pattern():
                        //         //
                        //         //   homeCategoryData[index]['pattern']==3?
                        //         //   Third().pattern(context: context)
                        //         //
                        //         //       : SizedBox(height: 150,),
                        //         ],
                        //       )
                        //   ),
                        // ),

                        productCatDesign(controller.getAllProductList),

                      ],
                    );
                  }
                ),
              )
            ])),
        ],
    ),
      ),
    );
  }



  upperPromotionalImages(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,15),
      child:  Stack(
          children: [
             images.isEmpty? commonShimmer.shimmerEffect(
               shimmer: images.isEmpty,
               child: Container(height: 180,width: 400,
                 decoration: BoxDecoration(
                   color: AppColor.grey,
                   borderRadius: BorderRadius.all(Radius.circular(15)),
                 ),)
             ) :CarouselSlider(
                  options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                      viewportFraction: 1,
                      height: 180.0,
                      autoPlay: true),
                  items:images.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CachedNetworkImage(
                            placeholder: (context, url) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                            imageUrl: '$item',
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
                        );
                      },
                    );
                  }).toList(),
            ),




            Positioned(
              bottom: 4,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.map((url){
                  int index = images.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? AppColor.customBlack
                          : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }
                ).toList(),
              ),
            ),
          ],
        ),
    );
  }



  homeCategoryFields({title,pressAll}){
    return Row(
      children: [
        Expanded(
          child: Text(title,
          style: TextStyle(
            color: AppColor.customBlack,
            fontWeight: FontWeight.bold,
            fontSize: 14
          ),),
        ),
        TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.fromLTRB(8,4,8,4,),
            minimumSize: Size(60, 20),
            backgroundColor: AppColor.buttonColor,
            shape: AppWidgets.buttonShape,
          ),
            child: Text('View All',
            style: textStyleTheme.mediumW),
          onPressed: (){
            pressAll();
          },
        ),
      ],
    );
  }



  productCatDesign(List productsCatList){
    return   Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: productsCatList.isEmpty? 1: productsCatList.length,
            itemBuilder: (context,index){
              List productDetails= productsCatList.isEmpty? []:jsonDecode(productsCatList[index]['productDetails']);
              return Column(
                children: [
                  homeCategoryFields(
                      title: productsCatList.isEmpty? '':productsCatList[index]['categoryName'],
                      pressAll: (){
                        if(productsCatList.isNotEmpty)
                        onPressedViewAll(productsCatList[index]['categoryName'], productDetails);
                      }
                  ),
                  Grid().pattern(context: context,listOfData: productDetails,dataCount: 4,)
                ],
              );
        })
      ],
    );
  }

  todaysDeal(){
    return   Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.getTodaysDealList.length,
            itemBuilder: (context,index){
            print('jhdgjfdjgfjgdj'+controller.getTodaysDealList.toString());
             List  todaysDealList= controller.getTodaysDealList.isEmpty? []:jsonDecode(controller.getTodaysDealList[index]['productDetailsTodaysDeal']);
              print('dfffffffffffffffffffff'+ todaysDealList.toString());

              return Column(
                children: [
                  homeCategoryFields(
              title: todaysDealList.isEmpty? '':"Today's Best Deals",
              pressAll: (){ onPressedTodaysDealViewAll(todaysDealList);

              }
              ),
              TodayDealPattern().pattern(context, listOfData:todaysDealList )
                ],
              );
        })
      ],
    );
  }


  searchProducts(){
    return InkWell(
      onTap: (){
        app.navigate(context, SearchProductView(heroTag: 'tes',));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            //left: BorderSide( color: Colors.transparent),
            top: BorderSide( width: 2,color: AppColor.lightThemeColor),
            // right: BorderSide( color: Colors.lightBlue.shade900),
            bottom: BorderSide(width: 2,color: AppColor.lightThemeColor),
          ),
        ),
        child: SizedBox(
          height: 40,
          child: Padding(
            padding:  EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Icon(Icons.search,
                  color:AppColor.grey,),
                SizedBox(width: 12,),
                Text('Search for products',
                  style:textStyleTheme.smallGrey716
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
