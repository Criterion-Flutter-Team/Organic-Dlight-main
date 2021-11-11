
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/ProgressDialogue.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/localStorage.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/AppManager/widgets/flatBurtton.dart';
import 'package:organic_delight/Pages/Cart/Cart.dart';
import 'package:get/get.dart';
import 'package:organic_delight/Pages/Cart/CartModal.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreenController.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreenModal.dart';
import 'package:organic_delight/Pages/Dashboard/WhishList/WhishListModal.dart';

import 'package:organic_delight/Pages/Dashboard/home/HomeModal.dart';
import 'package:organic_delight/Pages/FromFridge/FridgeCart/fridge_cart_local_storage.dart';
import 'package:organic_delight/Pages/FromFridge/FridgeCart/fridge_cart_view.dart';



class CommonButtons {


  MyTextTheme textStyleTheme=MyTextTheme();
  WishListModal wishListMod=WishListModal();
  CartModal cartMod=CartModal();
  LocalStorage storedData=Get.put(LocalStorage());
  FridgeCartLocalStorage fridgeStoredData=Get.put(FridgeCartLocalStorage());


  ProductScreenController controller=Get.put(ProductScreenController());
  HomeModal homeModal=HomeModal();
  ProductScreenModal proModal=ProductScreenModal();

  cartButton(context,{pageName}){
    return  Padding(
      padding: const EdgeInsets.fromLTRB(4,0,4,0),
      child: SimpleBuilder(
        builder: (_) {
          return TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black
            ),
            onPressed: (){
              pageName=='fridgePage'? App().navigate(context, FridgeCartView()):
              App().navigate(context, Cart());
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.shopping_cart,
                  color: AppColor.customBlack,),

                Positioned(
                  right: -15,
                  top: -10,
                  child: Visibility(
                   visible: (pageName=='fridgePage'?
                   fridgeStoredData.getCartProducts.isNotEmpty
                   :storedData.getCartProducts.isNotEmpty
                   ),
                    child: Badge(
                      badgeContent: Text( pageName!='fridgePage'?  storedData.getCartProducts.length.toString():
                    fridgeStoredData.getCartProducts.length.toString(),
                      style: textStyleTheme.smallWB
                     ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  profileButton(){
    return IconButton(
        icon: SizedBox(
            height: 20,
            child: Image(image: AssetImage('assets/userIcon.png'),)),
      onPressed: (){},
    );
  }


  drawerButton(onPressed){
    return IconButton(
        icon: Icon(Icons.list_sharp,
          color: AppColor.customBlack,),
      onPressed: (){
        onPressed();
      },
    );
  }





  likeButton(
      context,
      {
    isLiked,
    productId,
    productCode,
        variantId,
        String? pageName,
        bool? enable
})
  {
    return Material(
      color: Colors.transparent,
      child: SimpleBuilder(
          builder: (_) {
          return Visibility(
            visible: UserData().getUserId!='',
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,0,5,0),
               child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: IconButton(
                  onPressed: () async{
                    ProgressDialogue().show(context,loadingText: (!isLiked?'Liking ':'DisLiking ')+ 'Product');
                    if(enable?? true)
                          {
                            if(productCode!='' &&productId!=''){
                              await wishListMod.addProductToWishList(context,
                                  productId: productId,
                                  productCode: productCode,
                                  status: isLiked? 0:1
                              );
                              if(pageName=='ProductScreen'){
                                await proModal.getProductDetails(context,
                                    productCode: productCode,
                                    varient: variantId,
                                  page: pageName

                                );
                                await homeModal.getAllProduct(context);

                              }
                              else if(pageName=='todaysDeal'){
                                await proModal.getProductDetails(context,
                                    productCode: productCode,
                                    varient: variantId,
                                    page: pageName

                                );
                                await homeModal.getAllProduct(context);
                                await homeModal.getTodaysDealProduct(context);
                              }
                              else if(pageName=='Home'){
                                await homeModal.getAllProduct(context);
                                await homeModal.getTodaysDealProduct(context);

                              }
                              else if(pageName=='ViewAll'){
                                await homeModal.getAllProduct(context);
                              }
                            }
                          }

                    ProgressDialogue().hide(context);

                  },
                  icon: Icon(
                      Icons.favorite,
                      color: isLiked ? Colors.red : Colors.grey.shade200,
                      size: 15,
                    ),
                ),
              ),
            ));
        }
      ),
    );
  }

      //
      // LikeButton(
      //   isLiked: isLiked??false,
      //   onTap: (val) async{
      //     if(enable?? true)
      //       {
      //         if(productCode!='' &&productId!=''){
      //           print(val);
      //           await wishListMod.addProductToWishList(context,
      //               productId: productId,
      //               productCode: productCode,
      //               status: val? 0:1
      //           );
      //           if(pageName=='ProductScreen'){
      //             await proModal.getProductDetails(context,
      //                 productCode: productCode,
      //                 varient: variantId);
      //             await homeModal.getAllProduct(context);
      //           }
      //           else if(pageName=='Home'){
      //             await homeModal.getAllProduct(context);
      //           }         }            }
      //     return (enable?? true)? !val:val;
      //   },
      //   // circleColor:
      //   // CircleColor(start: AppColor.lightThemeColor, end: AppColor.lightThemeColor),
      //   // bubblesColor: BubblesColor(
      //   //   dotPrimaryColor: AppColor.lightThemeColor,
      //   //   dotSecondaryColor: AppColor.lightThemeColor,
      //   // ),
      //   likeBuilder: (bool isLiked) {
      //     return Icon(
      //       Icons.favorite,
      //       color: isLiked ? Colors.red : Colors.grey.shade200,
      //       size: 15,
      //     );
      //   },
      // ),
  //   );
  // }

  addToCartButton(context,{selectedVarient,onPressedCart,stocks,fridgeId}){
    return SimpleBuilder(
      builder: (_) {
        return Container(
          color: Colors.white,
          child:stocks==null ? SizedBox(height: 0,):( stocks<1? Container(
            color: AppColor.orangeColor,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0,10,0,10),
                    child: Text("Out of Stock.",textAlign: TextAlign.center,
                      style:textStyleTheme.mediumW,),
                  ),
                ),
              ],
            ),
          ):
          Row(
            children: [
               Expanded(
                flex: 1,
                child:  InkWell(

                  child: Container(
                    color: AppColor.lightThemeColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text((storedData.getCartVarients.contains(selectedVarient) ||
                          fridgeStoredData.getCartVarients.contains(selectedVarient))?
                      'GO TO CART':'ADD TO CART',
                        textAlign: TextAlign.center,
                        style:textStyleTheme.mediumWCB
                      ),
                    ),
                  ),
                  onTap: (){
                    if(storedData.getCartVarients.contains(selectedVarient) ||
                        fridgeStoredData.getCartVarients.contains(selectedVarient)){
                      fridgeId==null? App().navigate(context, Cart()):App().navigate(context, FridgeCartView());
                    }
                    // else if(){
                    //   App().navigate(context, FridgeCartView());
                    // }
                    else{
                      onPressedCart();
                    }
                  },
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: TextButton(
              // style: TextButton.styleFrom(
              //   primary: Colors.grey,
              //   padding: EdgeInsets.all(0),
              //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //   backgroundColor: AppColor.orangeColor,
              // ),
              //     child: Text('BUY NOW',
              //       style: textStyleTheme.mediumW
              //     ),
              //     onPressed: (){
              //       onPressedBuyNow(context);
              //
              //     },
              //   ),
              // ),
            ],
          ))
        );
      }
    );
  }

  wishListCartButton(setState,context,{dataMap}){
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0),
                primary: Colors.grey,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete,
                    color: AppColor.customBlack,
                    size: 15,) ,
                  Text('REMOVE',
                    style: textStyleTheme.smallC
                  ),
                ],
              ),
              onPressed: (){
                // onRemoveWishList();
                onRemoveWishList(setState,context, dataMap);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0),
                primary: Colors.grey,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: AppColor.orangeColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 /* Icon(Icons.shopping_cart,
                    color: AppColor.white,
                    size: 15,) ,*/
                  Text('MOVE TO CART',
                    style: textStyleTheme.mediumW
                  ),
                ],
              ),
              onPressed: (){
                onPressedConfirm() async {
                  Navigator.pop(context);
                  onMoveWishList(setState, context, dataMap);
                }
                  AlertDialogue().show(context, 'Are you sure you want to move this product?',
                      firstButtonName: 'Confirm',
                      showOkButton: false,
                      firstButtonPressEvent: onPressedConfirm,
                      showCancelButton: true ) ;

              },
            ),
          ),
        ],
      ),
    );
  }


  onRemoveWishList(setState,context,dataMap) async {
    onPressedConfirm() async {
      Navigator.pop(context);
      var data=await wishListMod.removeWishList(context, productId: dataMap['productVarientId'], productCode:dataMap['productCode']);

      if (data['responseCode'] == 1) {
        await wishListMod.getWishLists(context);
        setState((){

        });
        alertToast(context, 'Product Removed Successfully.');
      }
      else{
        alertToast(context, data['responseMessage']);
      }
    }
    AlertDialogue().show(context, 'Are you sure you want to remove this product?',
        firstButtonName: 'Confirm',
        firstButtonPressEvent: onPressedConfirm,
        showOkButton: false,
        showCancelButton: true);
  }


  removeProduct(setState,context,dataMap) async {
    var data=await wishListMod.removeWishList(context, productId: dataMap['productVarientId'], productCode:dataMap['productCode']);
    if (data['responseCode'] == 1) {
      await wishListMod.getWishLists(context);
      setState((){

      });

    }
  }


  onMoveWishList(setState,context,dataMap) async {
      var data=await cartMod.addToCart( context,
        productVarientId: dataMap['productVarientId'].toString(),
        productId:dataMap['productId'].toString(),
        productCode:dataMap['productCode'].toString(),
        quantity:'1',
      );
      if (data['responseCode'] == 1) {
        await removeProduct(setState,context,dataMap);
      }
      else{

        alertToast(context, data['responseMessage']);
      }
}
}

onPressedBuyNow(context){
  alertToast(context, 'Feature will be available soon.');
}