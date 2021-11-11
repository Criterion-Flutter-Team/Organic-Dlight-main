

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/localStorage.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/AppManager/widgets/textFeild.dart';
import 'package:organic_delight/Pages/Address/AddAddress/AddAddressModal.dart';
import 'package:organic_delight/Pages/Address/AddressBook/AddressBook.dart';
import 'package:organic_delight/Pages/Cart/CartModal.dart';
import 'package:organic_delight/Pages/Cart/Coupons/AddCouponModal.dart';
import 'package:organic_delight/Pages/Cart/Coupons/AddCoupons.dart';
import 'package:get/get.dart';
import 'package:organic_delight/Pages/CommonWidgets/ProductScreen/ProductScreenController.dart';
import 'package:organic_delight/Pages/Dashboard/WhishList/WhishListModal.dart';
import 'package:organic_delight/Pages/LoginPage/LoginPage.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  UserData user = UserData();

  MyTextTheme textStyleTheme=MyTextTheme();
  LocalStorage storedData = Get.put(LocalStorage());
  final userWishlist = WishListModal();
  AlertDialogue alert = AlertDialogue();

  ProductScreenController controller=Get.put(ProductScreenController());

  App app = App();
  var deliveryFee = 0.0;
  CartModal modal = CartModal();
  WishListModal wishModal = WishListModal();
  late String couponId;
  CouponModal couponModal = CouponModal();

  AddAddressModal addressModal = AddAddressModal();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    get();
  }


  get() async {
    await getCartDetails();
    setState(() {

    });
  }

  getCartDetails() async {
    await modal.getCartDetails(context);
    setState(() {

    });
  }


  updateQuantity(index, addIt) async {

    if (  ( addIt ? (storedData.getCartProducts[index]['quantity'] > 0)
        : storedData.getCartProducts[index]['quantity'] > 1) )
    {

     await modal.updateQuantity(context,
          id: storedData.getCartProducts[index]['cartTableId'].toString(),
          quantity: (
              addIt?
              (storedData.getCartProducts[index]['quantity']+1):
              (storedData.getCartProducts[index]['quantity']-1)
          ).toString());


      setState(() {});
    }
  }


  onRemoveProduct(index) async {
    onPressedConfirm() async {
      Navigator.pop(context);
      var data = await modal.removeCart(context,
          cartId: storedData.getCartProducts[index]['cartTableId'].toString());

      if (data['responseCode'] == 1) {
        alertToast(context, 'Product Removed Successfully.');
        // productList.removeAt(index);
        getCartDetails();
        setState(() {});
      }
    }

    AlertDialogue().show(context, 'Are you sure you want to remove this product?',
        firstButtonName: 'Confirm',
        showOkButton: false,
        firstButtonPressEvent: (){onPressedConfirm() ; },
        showCancelButton: true);

  }
  onMoveProduct(index) async {

    onPressedConfirm() async {
      await wishModal.addProductToWishList(context,
          // productId: storedData.getCartProducts[index]['productId'].toString(),
          productId:
          storedData.getCartProducts[index]
          ['productVarientId'].toString(),
          productCode: storedData.getCartProducts[index]['productCode'].toString(),
          status: 1,
      );
      Navigator.pop(context);
      var data = await modal.removeCart(context,
          cartId: storedData.getCartProducts[index]['cartTableId'].toString());

      if (data['responseCode'] == 1) {

        alertToast(context, 'Product Moved Successfully.');
        getCartDetails();
        setState(() {});
      }
    }

    AlertDialogue().show(context, 'Are you sure you want to move this product?',
        firstButtonName: 'Confirm',
        showOkButton: false,
        firstButtonPressEvent: (){ onPressedConfirm();},
        showCancelButton: true);

  }



  /*onPressedAddCoupon(index) async{
    //App().navigate(context, AddCoupons());
    onPressedConfirm() async {
      Navigator.pop(context);
      var data = await modal.applyCoupon(context);
      if(data['responseCode']==1){
        couponAppliedId:couponId;
        calculateAllData();
        setState(() {

        });
      }
    }
    AlertDialogue().show(context, 'Do you want to apply this coupon?',
        firstButtonName: 'Confirm',
        firstButtonPressEvent: onPressedConfirm,
        showCancelButton: true
    );
  }
*/


  List result = [];

  onPressedAddCoupon() async{
    await App().navigate(context, AddCoupons(
      totalAmount: storedData.getTotalMrp,
    ));
    await modal.getCartDetails(context);
    setState(() {
    });
  }




  onPressProceedToPay(){
    if(user.getUserId.isEmpty){
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    else{
      var showAddress=true;
      App().navigate(context, AddressBook(showAddress: showAddress,
      ));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(setState: setState,
            context: context,
            title: "Your Cart",
          ),
          body: storedData.getCartProducts.isEmpty?
          Center(
            child:      Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 150,
                    child: Lottie.asset('assets/emptyCart.json')),
                Text('Empty Cart',
                style: textStyleTheme.smallL)
              ],
            ),
          )
          :Stack(
            children: [
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        productListWidget(),
                        Divider(),
                        addInstructions(),
                        SizedBox(
                          height: 10,
                        ),

                        user.getUserId.isNotEmpty?  TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.grey,
                            backgroundColor: AppColor.lightThemeColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: AppColor.lightThemeColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child:Row(
                            children: [
                              Text(
                                '\u20B9',
                                style: textStyleTheme.largeW20
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: Text(
                                    'Apply Coupon',
                                    style: textStyleTheme.mediumW
                                  )),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: AppColor.white,
                                size: 15,
                              ),
                            ],
                          ),
                          onPressed: () {
                            onPressedAddCoupon();
                          },
                        ):SizedBox(),
                        Divider(),
                        billDetailsWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        // addressField(),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  proceedToPay(),
                ],
              )
            ],
          ),

          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton:  ,
        ),
      ),
    );
  }



  billDetailsWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bill Details',
          style: textStyleTheme.smallC14B
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Item Total',
                style: textStyleTheme.smallC12B
              ),
            ),
            Text(
              '\u20B9' + storedData.getTotalPrice,
              textAlign: TextAlign.end,
              style: textStyleTheme.smallC12
            ),
          ],
        ),
        Divider(),
        Row(
          children: [
            Expanded(
              child: Text(
                'Total Discount',
                style: textStyleTheme.smallC12B
              ),
            ),
            Text(
              '- \u20B9' + storedData.getCartTotalDiscount,
              textAlign: TextAlign.end,
              style: textStyleTheme.smallC12
            ),
          ],
        ),
        Divider(),
        Row(
          children: [
            Expanded(
              child: Text(
                'Delivery Fee',
                style: textStyleTheme.smallL12B
              ),
            ),
            Text(
              deliveryFee == 0.0
                  ? 'Free'
                  : ('\u20B9' +
                  deliveryFee.toStringAsFixed(2)),
              textAlign: TextAlign.end,
              style:textStyleTheme.smallL12
            ),
          ],
        ),
        Divider(),
        couponField(),
        Divider(),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'To Pay',
                style: textStyleTheme.smallC14B
              ),
            ),
            Text(
              '\u20B9' + storedData.getTotalMrp.toString(),
              textAlign: TextAlign.end,
              style: textStyleTheme.smallC14B
            ),
          ],
        ),


        SizedBox(
          height: 10,
        ),
        Visibility(
          visible: storedData.getDiscount!='',
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.lightThemeColorShade4,
                border: Border.all(color: AppColor.grey1)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'You have saved \u20B9' +
                          storedData.getDiscount +
                          ' on the bill',
                      textAlign: TextAlign.start,
                      style: textStyleTheme.smallL12B
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }



  couponField() {
    return Visibility(
      visible: storedData.getDiscount!='',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Applied Coupons',
            style:textStyleTheme.smallC14B
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(storedData.getCouponCode.toString(),
                style: textStyleTheme.smallL12B),
              Text('- \u20B9'+storedData.getDiscount.toString(),
                textAlign: TextAlign.end,
                style: textStyleTheme.smallL12
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  addInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Instructions',
          style: textStyleTheme.smallCB
        ),
        SizedBox(height: 5,),
        TextFieldClass(
          maxLine: 5,
          hintText: 'Add Instructions for staff',
        ),
      ],
    );
  }

  /*addressField(){
    return   SimpleBuilder(
      builder: (_) =>      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: addressModal.getAddressList.isEmpty?   Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(8),
                minWidth: 0,
                height: 0,
                child: Text('Add Address',
                  style: TextStyle(
                      color: AppColor.orangeColor,
                      fontWeight: FontWeight.bold
                  ),),
                onPressed: (){
                  onPressedAddAddress();
                },
              ),
            ],
          ):Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Delivery To '+addressModal.primaryAddressC.getPrimaryAddress['type'].toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(8),
                    minWidth: 0,
                    height: 0,
                    child: Text('Add Address',
                      style: TextStyle(
                          color: AppColor.orangeColor,
                          fontWeight: FontWeight.bold
                      ),),
                    onPressed: (){
                      onPressedAddAddress();
                    },
                  ),
                ],
              ),
              Text(primaryAddressC.getPrimaryAddress['completeAddress'].toString(),
                style: TextStyle(
                    color: AppColor.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                ),),
              SizedBox(height: 5,),
              Text('32 MINS',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                ),),
            ],
          ),
        ),
      ));


  }*/

  productListWidget() {
    return SimpleBuilder(builder: (_) {
      return Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: storedData.getCartProducts.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child:CachedNetworkImage(
                                placeholder: (context, url) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                                imageUrl: imageUrl+storedData.getCartProducts[index]['mainImage'].toString(),
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
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(15)),
                              //       border: Border.all(
                              //           color: Colors.grey.shade200, width: 2),
                              //       image: DecorationImage(
                              //           image: NetworkImage(
                              //               imageUrl+storedData.getCartProducts[index]['mainImage']),
                              //           fit: BoxFit.cover)),
                              // ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                0,
                                8,
                                8,
                                8,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      storedData.getCartProducts[index]
                                          ['productName'],
                                      style:textStyleTheme.smallC12B
                                    ),
                                    Text(storedData.getCartProducts[index]
                                    ['unitValue'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyleTheme.smallC10B
                                    ),
                                Text(storedData.getCartProducts[index]
                                ['colorName'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyleTheme.smallC10B
                                        ),
                                    // Expanded(
                                    //   child: Wrap(
                                    //     children: [
                                    //       Text(
                                    //         "The world's tallest ice cream cone was over 9 feet tall. It was scooped in Italy. Most of the vanilla used to make ice cream comes from Madagascar & Indonesia. Chocolate syrup is the world's most popular ice cream topping.",
                                    //         maxLines: 3,
                                    //         overflow: TextOverflow.ellipsis,
                                    //         style: TextStyle(
                                    //             color: AppColor.customBlack,
                                    //             fontSize: 10,
                                    //             fontWeight: FontWeight.bold),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),

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
                    Row(
                      children: [
                        Expanded(
                          flex: 14,
                          child: Wrap(
                            children: [
                              Text(
                                ' \u20B9 ' +
                                    storedData.getCartProducts[index]
                                            ['productSellingPrice']
                                        .toStringAsFixed(2) +
                                    ' ',
                                style: textStyleTheme.smallC12B
                              ),
                              Text(
                                storedData.getCartProducts[index]['productMRP']
                                    .toString(),
                                style: textStyleTheme.smallC12BLineThrough
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                storedData.getCartProducts[index]
                                        ['discountInPercentage']
                                    .toString()+'%',
                                style:textStyleTheme.smallG12
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.grey)),
                            child: Row(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.all(4),
                                    minimumSize: Size(0, 0 ),
                                    primary: Colors.grey
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: AppColor.lightThemeColor,
                                    size: 15,
                                  ),
                                  onPressed: () {
                                    updateQuantity(index, false);
                                  },
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Text(
                                      storedData.getCartProducts[index]
                                              ['quantity']
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: textStyleTheme.smallG12
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.grey,
                                    tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.all(4),
                                   minimumSize: Size(0, 0)
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColor.lightThemeColor,
                                    size: 15,
                                  ),
                                  onPressed: () {
                                    updateQuantity(index, true);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              '\u20B9' + storedData.getCartProducts[index]['prTotal'].toString(),
                              textAlign: TextAlign.end,
                              style:textStyleTheme.smallC12
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,

                    ),
                    addToWishListButton(index),
                    Divider(),
                  ],
                );
              })
        ],
      );
    });
  }

  proceedToPay() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\u20B9' + storedData.getTotalMrp.toString(),
                style: textStyleTheme.smallCB
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(

              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: AppColor.lightThemeColor,
              ),
              child: Text(
                'Proceed To Pay',
                style: textStyleTheme.mediumW
              ),
              onPressed: () {
                onPressProceedToPay();


              },
            ),
          ),
        ],
      ),
    );
  }

  addToWishListButton(index) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.white, border: Border.all(color: AppColor.grey)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(8),
                primary: Colors.grey,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
               minimumSize: Size(0, 0)
              ),
              child: Text(
                'MOVE TO WISHLIST',
                style:  textStyleTheme.smallC12
              ),

              onPressed: () async {
                if(user.getUserId.isEmpty){
                  App().navigate(context, LoginPage());
                }
                else{

                  onMoveProduct(index);
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(8),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size(0, 0),
                primary: Colors.grey,
                backgroundColor: AppColor.orangeColor,
              ),
              child: Text(
                'REMOVE',
                style:  textStyleTheme.smallW12
              ),
              onPressed: () {
                onRemoveProduct(index);
              },
            ),
          ),
        ],
      ),
    );
  }}
