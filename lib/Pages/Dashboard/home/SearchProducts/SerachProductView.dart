import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreen.dart';
import 'package:organic_delight/Pages/Dashboard/home/SearchProducts/SearchProductModal.dart';
import 'package:get/get.dart';

import 'SearchController.dart';


class SearchProductView extends StatefulWidget {

  final String heroTag;

  const SearchProductView({Key? key, required this.heroTag}) : super(key: key);
  @override
  _SearchProductViewState createState() => _SearchProductViewState();
}

class _SearchProductViewState extends State<SearchProductView> {


  // List autoCompleteSearch=[];

  MyTextTheme textStyleTheme=MyTextTheme();
  TextEditingController _searchC=new TextEditingController();

  SearchController searchController=Get.put(SearchController());
  bool showNoData=false;

  SearchProductModal modal=SearchProductModal();

  getSearchedData(text) async{
   await modal.getSearchedData(context, text);
    // if(data['responseCode']==1){
      showNoData=true;
      // autoCompleteSearch=jsonDecode(data['responseValue'])['SearchProductList'];
      setState(() {
      });

  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SearchController>();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
          child: Scaffold(
            appBar: MyWidget().myAppBar(setState: setState,
              context: context,
              title: "Search",
            ),
              body: Column(
                children: [
                  searchProducts(),
                  _searchC.text.isNotEmpty? Expanded(child:searchController.getSearchList.isNotEmpty? searchProductCategory():
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,120,0,0),
                    child: Column(
                      children: [
                        Text('Product Not found',style: textStyleTheme.smallL14,),
                      ],
                    ),
                  )): Padding(
                    padding:  EdgeInsets.fromLTRB(0,120,0,0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Search for Product',style: textStyleTheme.smallL14,),
                      ],
                    ),
                  )
                ],
              )
          )
      ),

    );
  }


  searchProductCategory(){

    return ListView.builder(
        shrinkWrap: true,


        itemCount: searchController.getSearchList.length,

        itemBuilder: (BuildContext context,int index){
          return Card(
            color: Colors.grey[200],
            child: Column(
              children: [
                Card(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(searchController.getSearchList[index]['categoryName'],
                          textAlign: TextAlign.start,
                          style:textStyleTheme.smallGrey5B
                      ),
                    )
                  ),
                ),

                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: jsonDecode(searchController.getSearchList[index]['productDetails']).length,
                    itemBuilder: (BuildContext context,int index2){
                      List productList= jsonDecode(searchController.getSearchList[index]['productDetails']);
                      var heroT= 'SearchProduct'+index.toString();
                      return  GestureDetector(
                        onTap: (){
                          App().navigate(context, ProductScreen(
                            heroTag: heroT,
                            productCode: productList[index2]['productCode'].toString(),
                            productVarient: productList[index2]['prId'].toString(),
                            productId: productList[index]['productId'].toString(),
                            // productId: productList[index]['prId'].toString(),
                          ) );
                        },
                        child: Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  child:CachedNetworkImage(
                                    placeholder: (context, url) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                                    imageUrl:imageUrl+productList[index2]['mainImage'].toString(),
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

                                SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(productList[index2]['productName'].toString().toUpperCase(),
                                        style:textStyleTheme.smallC12B
                                      ),
                                      Row(
                                        children: [
                                          Text('\u20B9 '+productList[index2]['productSellingPrice'].toString()+' ',
                                            style:textStyleTheme.smallC12B
                                          ),
                                          Text(productList[index2]['productMRP'].toString(),
                                            style:textStyleTheme.smallC12BLineThrough
                                          ),
                                          SizedBox(width: 5,),
                                          Text(productList[index2]['discountInPercentage'].toString()+'%',
                                            style:textStyleTheme.smallG12
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
                      );
                    })

              ],
            ),
          );

        }
    );
  }







  searchProducts(){
    return Container(
      width: MediaQuery.of(context).size.width,
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
        child: TextField(

          controller: _searchC,
          onChanged: (val){
            if(val.length>0 ){
              getSearchedData(val);
              setState(() {

              });
            }
            else{
              searchController.removeSearchList();
              showNoData=false;
              setState(() {

              });
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search,
              color: AppColor.grey,),
            contentPadding: EdgeInsets.all(0),
            hintText: 'Search for products',
            focusedBorder: new OutlineInputBorder(
              borderSide:  BorderSide(
                  color: Colors.transparent,
                  width: 2
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(
                  color: Colors.transparent,
                  width: 2
              ),
            ),
          ),
        ),
      ),
    );
  }


}
