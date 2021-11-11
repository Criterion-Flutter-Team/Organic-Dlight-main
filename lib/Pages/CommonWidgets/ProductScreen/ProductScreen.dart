import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/Cart/CartModal.dart';
import 'package:organic_delight/Pages/Common.dart';
import 'package:organic_delight/Pages/CommonWidgets/ListPatten/FourthPattern.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/AllReviews.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/NutritionDetails.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreenController.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreenModal.dart';
import 'package:organic_delight/Pages/FromFridge/FridgeCart/fridge_cart_modal.dart';
import 'package:organic_delight/Pages/FromFridge/form_fridge_controller.dart';
import 'package:organic_delight/Pages/FromFridge/from_fridge_modal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import '../Buttons/CommonButtons.dart';
import 'package:organic_delight/AppManager/localStorage.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';






class ProductScreen extends StatefulWidget {

  final String heroTag;
  final String productCode;
  final String productId;
  final String productVarient;
  final String? pageName;
  final String? fridgeId;

  const ProductScreen({Key? key,
    required this.heroTag,
    required this.productCode,
    required this.productVarient,
  required this.productId,
    this.pageName,
    this.fridgeId,
  }) : super(key: key);




  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  MyTextTheme textStyleTheme=MyTextTheme();
  ProductScreenController controller=Get.put(ProductScreenController());
  FromFridgeController fridgeController=Get.put(FromFridgeController());

  ProductScreenModal modal=ProductScreenModal();
  FromFridgeModal fridgeModal=FromFridgeModal();
  App app = App();
  UserData user=UserData();
  CartModal cartModal=CartModal();

  LocalStorage storage=LocalStorage();

  Common commonShimmer=Common();
  FridgeCartModal fridgeCartModal=FridgeCartModal();


  LocalStorage storedData=Get.put(LocalStorage());
  var _current=0;

  var selectedQuantity=1;



  var ratings=[];
  // var Likes=[];


  @override
  void initState() {
    super.initState();
    get();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<ProductScreenController>();
  }

  get() async{
  //   storage.removeProduct();
    await getProductList(varient: widget.productVarient);
   // await getReviewAndRating();

   // await ReviewAndRatings();
  }

  getProductList({varient}) async{
    modal.getProductDetails(context,
    productCode: widget.productCode,
    varient: varient??widget.productVarient,
      page: widget.pageName
    );
    setState(() {});
  }


  newVarient(newVar) async{
    await getProductList(varient: newVar);
  }

  onPressCheckNutrition(){
    app.navigate(context, NutritionDetails(
      heroTag: 'nutritionTag',
    ));
  }

  onPressedAddToCart() async{
    var data= widget.pageName=='fridgePage'? await fridgeCartModal.addToCartFridge(context,
      fridgeId:widget.fridgeId?? widget.fridgeId.toString(),
      productCode:  widget.productCode.toString(),
      productId:widget.productId.toString(),
      productVarientId:controller.getSelectedVariant.toString(),
      quantity: selectedQuantity.toString(),):await cartModal.addToCart(context,
      productVarientId: controller.getSelectedVariant.toString(),
      productId: widget.productId.toString(),
      productCode: widget.productCode.toString(),
      quantity: selectedQuantity.toString(),
    );
  }

  onPressedRemove() async{
    if(selectedQuantity>1){
      selectedQuantity=selectedQuantity-1;
    }
     // cartModal.updateQuantity( context,
    //   id: widget.productId.toString(),
    //   quantity: selectedQuantity=selectedQuantity
    // );


    /*if(selectedQuantity>1){
      selectedQuantity=selectedQuantity-1;
    }
    else{


    }*/
    setState(() {

    });
  }







  onPressedAdd() async{
   // var data= await cartModal.updateQuantity(context,
   //    id:widget.productId.toString(),
   //    quantity: selectedQuantity+1
   //  );
   // if(data['responseCode']==1){
   // }

   selectedQuantity=selectedQuantity+1;
    setState(() {
    });
  }


  createFolder() async{
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
      return tempPath;
  }


  downloadFile(context, { required String fileUrl}) async{
    // var result = await Permission.storage.request();
    // var permission= await Permission.storage.status.isGranted;
    // print(permission);
    // if (permission) {
    try {
      var response = await Dio().get(
          fileUrl,
          // onReceiveProgress: showDownloadProgress,
          //Received data with List<int>
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }),
      );
      print('bbbbbbbbbbbbbbbbbbbbbbbb'+response.toString());
      print(response.headers);
      print('aaaaaaaaaaaaaaaaaaaaaaaaaa'+response.data.toString());
      var newPath=await createFolder();
      print('ccccccccccccccc'+newPath.toString());
      var fileNameC=fileUrl.substring(fileUrl.lastIndexOf("/") + 1);
      // DateFormat dateFormat = DateFormat("dd/MM/yyyy_h:mma");
      // String currentTime = dateFormat.format(DateTime.now());
      var customFileName=newPath.toString()+'HizPatient_'+fileNameC.toString();
      print(customFileName.toString());
      File file = File(customFileName);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      // AlertDialogue().show(context, 'Success', 'Your file is save here:\n'+customFileName,
      //     showOkButton: true);
     return file;
    } catch (e) {
      print(e);
    }
  }

  likeReview(var likes) async{
    var data=await modal.getLikeReview(context,reviewId:modal.getRatingList[0]['reviewId'],
        isLike:likes,loginUserId:user.getUserId
    );
    if (data['responseCode'] == 1) {
      // Likes= jsonDecode(data['responseValue']);
    }

  }



    @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<ProductScreenController>(
            init: ProductScreenController(),
            builder: (_) {
              return Stack(
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
                        flexibleSpace: MyWidget().myAppBar(
                            context: context,
                            action: [
                              CommonButtons().cartButton(context,
                                  pageName: widget.pageName.toString(),
                              ),
                            ]
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
                              valueColor:  AlwaysStoppedAnimation<Color>(AppColor.lightThemeColor),
                              backgroundColor: Colors.white,
                            )),
                        toolbarHeight:  4 ,
                      ),

                      SliverList(
                          delegate: SliverChildListDelegate([
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15,15,15,45),
                                  child:
                                  controller.getProductData.isEmpty? commonShimmer.shimmerEffect(
                                    // baseColor: Colors.grey.shade200,
                                    // highlightColor: Colors.white,
                                    // enabled: true,
                                    child:    mainProductPage(
                                      productName: 'PRODUCT NAME',
                                      sellingPrice: '00.00',
                                      mrp: '00.00',
                                      discount: '0',
                                    ),
                                    shimmer: controller.getProductData.isEmpty,
                                  ) :mainProductPage(
                                    productName:   controller.getProductData.isEmpty? '':  controller.getProductData['productName'].toString(),
                                    mrp:   controller.getProductData.isEmpty? '':  controller.getProductData['productMRP'].toString(),
                                    sellingPrice:   controller.getProductData.isEmpty? '':  controller.getProductData['productSellingPrice'].toString(),
                                    discount:   controller.getProductData.isEmpty? '':  controller.getProductData['discountInPercentage'].toString(),
                                  ),
                                ),
                              ],
                            ),
                          ])),
                    ],
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    addToCartButtons()
                  ],
                )
                ],
              );
            }
          ),
        ),
      ),
    );
  }


  addToCartButtons() {
    return  Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.customBlack)
      ),
      child:  CommonButtons().addToCartButton(
        //onPressedAddToCart,
        context,
        selectedVarient:   controller.getSelectedVariant,
        onPressedCart: onPressedAddToCart,
        fridgeId:widget.fridgeId,
        stocks:controller.getProductData['currentStock'],
      ),
    );
  }


  mainProductPage({
    productName,
    mrp,
    sellingPrice,
    discount
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: widget.heroTag,
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    viewportFraction: 1,
                    height: 180.0,
                    autoPlay: true),
                items: List.generate( controller.getProductData.isEmpty?
                  0: jsonDecode(  controller.getProductData['imageList']).length, (index) {
                  List newList=  controller.getProductData.isEmpty?
                  0: jsonDecode(  controller.getProductData['imageList']);

                  return
                    CachedNetworkImage(
                      placeholder: (context, url) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                      imageUrl:widget.pageName=='fridgePage'?
                             fridgeImageUrl+ newList[index]['mainImage'].toString():
                             imageUrl+newList[index]['mainImage'].toString(),
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

                  //   Container(
                  //   decoration: BoxDecoration(
                  //       color: AppColor.white,
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //       border: Border.all(color: Colors.grey.shade200,
                  //           width: 2),
                  //       image: DecorationImage(
                  //           image: NetworkImage(imageUrl+newList[index]['mainImage'].toString()),
                  //           fit: BoxFit.cover
                  //       )
                  //   ),
                  // );
                }),
              ),
              widget.pageName=='fridgePage'? SizedBox():Positioned(
                  top: 8,
                  right: 5,
                  child: Visibility(
                    visible: widget.pageName!='todaysDeal',
                    child: CommonButtons().likeButton(
                        context,
                        isLiked:controller.getProductData.isEmpty? false:
                        (controller.getProductData['isWishList']==1),
                        productCode:   controller.getProductData.isEmpty? '':  controller.getProductData['productCode'],
                        productId:   controller.getProductData.isEmpty? '':controller.getSelectedVariant,
                        variantId: controller.getSelectedVariant,
                      pageName: widget.pageName?? 'ProductScreen'

                    ),
                  )
              ),
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(controller.getProductData.isEmpty? 5:jsonDecode(controller.getProductData['imageList']).length, (index){
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

          })
        ),

        Text(productName.toString().toUpperCase(),
          style:textStyleTheme.smallCB
        ),
        // SizedBox(height: 5,),
        // Row(
        //   children: [
        //     Container(
        //       decoration: BoxDecoration(
        //           color: AppColor.darkGreen,
        //           borderRadius: BorderRadius.all(Radius.circular(4))
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.fromLTRB(4,2,4,2),
        //         child: Row(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text('4.3',
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 12
        //               ),),
        //             SizedBox(width: 5,),
        //             Icon(Icons.star,
        //               color: Colors.white,
        //               size: 12,),
        //           ],
        //         ),
        //       ),
        //     ),
        //     SizedBox(width: 5,),
        //     Text('114 review',
        //       style: TextStyle(
        //         color: AppColor.purpleColor,
        //         fontSize: 12,
        //       ),),
        //   ],
        // ),
        SizedBox(height: 5,),
        Row(
          children: [
            Expanded(
              flex: 14,
              child:   Wrap(
                children: [
                  Text('\u20B9 '+sellingPrice.toString()+' ',
                    style:textStyleTheme.smallC12B
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
            ),
            SizedBox(width: 5,),
            Expanded(
              flex: 10,
              child: storedData.getCartVarients.contains( controller.getSelectedVariant)? Text('Already in Cart!',textAlign: TextAlign.end,style: MyTextTheme().smallO12B,): Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.grey)
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.grey,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.all(4),
                              minimumSize: Size(0, 0),
                          ),
                            child: Icon(Icons.remove,
                              color: AppColor.lightThemeColor,
                              size: 15,),
                            onPressed: (){
                              controller.getProductData['currentStock']==null? alertToast(context, 'Out of Stock.'):
                              controller.getProductData['currentStock']<1? alertToast(context, 'Out of Stock.'):onPressedRemove();
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,8,0),
                              child: Text(selectedQuantity.toString(),
                                textAlign: TextAlign.center,
                                style:textStyleTheme.smallL12
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.grey,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.all(4),
                              minimumSize: Size(0, 0)
                            ),

                            child: Icon(Icons.add,
                              color: AppColor.lightThemeColor,
                              size: 15,),
                            onPressed: (){

                              controller.getProductData['currentStock']==null? alertToast(context, 'Out of Stock.'):
                              controller.getProductData['currentStock']<1? alertToast(context, 'Out of Stock.'):onPressedAdd();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                      flex: 4,
                      child: Text('\u20B9'+(selectedQuantity * double.parse(sellingPrice)).toString(),
                        textAlign: TextAlign.end,
                        style:textStyleTheme.smallC12

                      )),
                ],
              ),
            ),

          ],
        ),
        SizedBox(height: 5,),
        Text('Select Varient',
          style:textStyleTheme.smallC12B
        ),
        SizedBox(height: 3,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: List.generate(  controller.getVariantData.length, (index) =>  Padding(
                padding: const EdgeInsets.fromLTRB(0,2,4,2),
                child: GestureDetector(
                  onTap: () { selectedQuantity=1;
                    setState(() {

                      controller.updateSelectedVariant=  controller.getVariantData[index]['id'];
                    });
                    newVarient(controller.getSelectedVariant.toString());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color:    controller.getSelectedVariant ==  controller.getVariantData[index]['id']? AppColor.lightThemeColor:Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4),),
                            border: Border.all(color: AppColor.lightThemeColor,
                                width: 2)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8,4,8,4),
                          child: Text(controller.getVariantData[index]['unitValue'].toString(),
                            style: TextStyle(
                                color:    controller.getSelectedVariant==  controller.getVariantData[index]['id']? Colors.white:AppColor.lightThemeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                            ),),
                        ),
                      ),
                      Text(  controller.getVariantData[index]['colorName'].toString(),
                      style:textStyleTheme.small12
                      )


                    ],
                  ),
                ),
              ),),
            ),

            TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize:MaterialTapTargetSize.shrinkWrap,
                    primary: Colors.grey
                    // backgroundColor: Colors.grey
                ),

                onPressed: () async{
                  var heroTag=widget.heroTag;
                  var productCode=widget.productCode;
                  var productId=widget.productId;
                  var productVarient=widget.productVarient;
                  var PageName=widget.pageName;
                  List productImg=jsonDecode(controller.getProductData['imageList']);
                  String uriString =widget.pageName=='fridgePage'? fridgeImageUrl+productImg[0]['mainImage']:imageUrl+productImg[0]['mainImage'];
                  File imgFile=await downloadFile(context, fileUrl: uriString);
                  Share.shareFiles([imgFile.path],
                      text:'http://theorganicdelight.com/$heroTag-$productCode-$productId-$productVarient-$PageName',
                  subject: 'The Organic Delight');
                },
                child: Icon(Icons.share,color: Colors.grey,))
          ],
        ),

        // Wrap(
        //   children: List.generate(listOfColor.length, (index) =>  Padding(
        //     padding: const EdgeInsets.fromLTRB(0,2,4,2),
        //     child: GestureDetector(
        //       onTap: (){
        //         setState(() {
        //           selectedColor=listOfColor[index];
        //         });
        //         newVarient();
        //       },
        //       child: Column(
        //         children: [
        //           Container(
        //             width: 60,
        //             decoration: BoxDecoration(
        //                 color: Colors.red,
        //                 borderRadius: BorderRadius.all(Radius.circular(4),),
        //                 border: Border.all(color: Colors.black12,
        //                     width: 2)
        //             ),
        //             child: Padding(
        //                 padding: const EdgeInsets.fromLTRB(8,4,8,4),
        //                 child: CircleAvatar(
        //                   radius: 8,
        //                   backgroundColor:  selectedColor==listOfColor[index]? AppColor.white:Colors.transparent,
        //                   child: Icon(Icons.check,
        //                     color:  selectedColor==listOfColor[index]? AppColor.lightThemeColor:Colors.transparent,
        //                     size: 15,),
        //                 )
        //             ),
        //           ),
        //           Text(listOfColor[index].toString(),style:
        //             TextStyle(
        //               fontSize: 12
        //             ),)
        //         ],
        //       ),
        //     ),
        //   ),),
        // ),
        SizedBox(height: 3,),
        Divider(),
        Text('Product Details',
          style:textStyleTheme.smallCB
        ),
        Visibility(
          visible:    (controller.getProductData.isNotEmpty &&  controller.getProductData['productShortDescription']!=null),
          child: Html(
            data:  controller.getProductData['productShortDescription']?? '',
          ),
        ),
        // Column(
        //   children: List.generate(5, (index) => Row(
        //     children: [
        //       Icon(Icons.circle,
        //         color: AppColor.customBlack,
        //         size: 6,),
        //       SizedBox(width: 5,),
        //       Expanded(child: Text('Cake Flavoured Red Velvet '+index.toString(),
        //         style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 12
        //         ),)),
        //     ],
        //   )),
        // ),
        Divider(),
        // reviewWidget(),

      ],
    );
  }



  reviewWidget(){
    // bool likes=false;
    return Column(
      children: [
        Hero(
          tag: 'nutritionTag',
          child: TextButton(
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.all(0),

            ),
            onPressed: (){
              onPressCheckNutrition();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: AppColor.lightThemeColor,
                      width: 2)
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8,4,8,4),
                child: Text('Check Nutrition Value',
                  style:textStyleTheme.smallC12B
                ),
              ),
            ),
          ),
        ),
        Divider(),
        Text('Rating & Reviews',
          style:textStyleTheme.smallCB
        ),
        SizedBox(height: 5,),

        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('4.5',
                            style: textStyleTheme.largeB18B
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.star),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text('152 ratings and 521 reviews ',
                        textAlign: TextAlign.center,)
                    ],
                  )),
              VerticalDivider(
                thickness: 1,
              ),
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('5',
                            style:textStyleTheme.small12
                          ),
                          SizedBox(width: 2,),
                          Icon(Icons.star,
                            size: 14,),

                          Expanded(
                            child: LinearProgressIndicator(
                              valueColor:  AlwaysStoppedAnimation<Color>(AppColor.darkGreen),
                              backgroundColor: AppColor.grey,
                              value: 0.9,
                            ),
                          ),

                          SizedBox(width: 5,),
                          Text('89',
                            style:textStyleTheme.small12
                            ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('4',
                            style:textStyleTheme.small12
                          ),
                          SizedBox(width: 2,),
                          Icon(Icons.star,
                            size: 14,),
                          Expanded(
                            child: LinearProgressIndicator(
                              valueColor:  AlwaysStoppedAnimation<Color>(Colors.green),
                              backgroundColor: AppColor.grey,
                              value: 0.6,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text('55',
                            style:textStyleTheme.small12
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('3',
                            style:textStyleTheme.small12
                          ),
                          SizedBox(width: 2,),
                          Icon(Icons.star,
                            size: 14,),
                          Expanded(
                            child: LinearProgressIndicator(
                              valueColor:  AlwaysStoppedAnimation<Color>(AppColor.lightThemeColor),
                              backgroundColor: AppColor.grey,
                              value: 0.5,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text('12',
                            style:textStyleTheme.small12
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('2',
                            style:textStyleTheme.small12
                          ),
                          SizedBox(width: 2,),
                          Icon(Icons.star,
                            size: 14,),
                          Expanded(
                            child: LinearProgressIndicator(
                              valueColor:  AlwaysStoppedAnimation<Color>(Colors.orange),
                              backgroundColor: AppColor.grey,
                              value: 0.4,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text('45',
                            style:textStyleTheme.small12
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('1',
                            style: textStyleTheme.small12
                          ),
                          SizedBox(width: 2,),
                          Icon(Icons.star,
                            size: 14,),
                          Expanded(
                            child: LinearProgressIndicator(
                              valueColor:  AlwaysStoppedAnimation<Color>(Colors.red),
                              backgroundColor: AppColor.grey,
                              value: 0.1,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text('33',
                            style:textStyleTheme.small12
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
        Divider(),
        Column(
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
                style:textStyleTheme.smallC12
              ),
              // Container(
              //   height: 20,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       FlatButton(
              //
              //         onPressed: (){
              //
              //           likeReview(1);
              //         },
              //         color: Colors.transparent,
              //         child: Row(
              //           children: [
              //             Icon(Icons.thumb_up,color: Colors.grey.shade200,size: 18,),
              //             SizedBox(width: 4,),
              //             Text((modal.getRatingList.isNotEmpty? modal.getRatingList[index]["likeReview"].toString():''),
              //               style: TextStyle(color: Colors.grey.shade200),)
              //           ],
              //         ),
              //       ),
              //       FlatButton(onPressed: (){
              //
              //         likeReview(0);
              //       },
              //         child: Row(
              //           children: [
              //             Icon(Icons.thumb_down,color: Colors.grey.shade200,size: 18,),
              //             SizedBox(width: 4,),
              //             Text((modal.getRatingList.isNotEmpty? modal.getRatingList[index]["disLikeReview"].toString():'')
              //               ,style: TextStyle(color: Colors.grey.shade200),)
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),

              index==4? Container():SizedBox(height: 5,),
            ],
          ),),
        ),


        Divider(),
        InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>  AllReviews( productId: widget.productId))
            );
          },
          child: Row(
            children: [
              Expanded(child: Text('All Reviews',
                style:textStyleTheme.smallC12B
              )),
              Icon(Icons.arrow_forward_ios_sharp,
                color: AppColor.customBlack,
                size: 12,)

            ],
          ),
        ),

        Divider(),
        Text('Similar Items',
          style:textStyleTheme.smallCB
        ),
        SizedBox(height: 5,),
      ],
    );
  }


  productPageShimmer(){
    return  Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.white,
      enabled: true,
      child: Column(
        children: [
          Hero(
            tag: widget.heroTag,
            child: Container(
              height: 180.0,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: Colors.grey.shade200,
                      width: 2),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                height: 15,
                width: 60,
                color: AppColor.lightThemeColor,
              ),
              Expanded(child: SizedBox()),
              Container(
                height: 15,
                width: 50,
                color: AppColor.lightThemeColor,
              ),
            ],
          ),
          SizedBox(height: 10,),
          GridView.count(
              semanticChildCount: 2,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 5/6,
              primary: false,
              shrinkWrap: true,
              children: List.generate(4, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 15,
                      width: 60,
                      color: AppColor.lightThemeColor,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 15,
                      width: 50,
                      color: AppColor.lightThemeColor,
                    ),
                  ],
                ),
              ),)
          ),
        ],
      ),
    );
  }
}