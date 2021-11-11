

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/Address/AddressBook/AddressBook.dart';
import 'package:get/get.dart';
import 'package:organic_delight/Pages/LoginPage/LoginPage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'fridge_cart_local_storage.dart';
import 'fridge_cart_modal.dart';

class FridgeCartView extends StatefulWidget {
  @override
  _FridgeCartViewState createState() => _FridgeCartViewState();
}

class _FridgeCartViewState extends State<FridgeCartView> {

  MyTextTheme textStyleTheme=MyTextTheme();
  App app = App();
  FridgeCartModal modal = FridgeCartModal();

  late Razorpay _razorpay;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }


  get() async {
    await getCartDetails();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    setState(() {

    });
  }

  getCartDetails() async {
    await modal.getCartDetailsFridge(context);
    setState(() {

    });
  }
  updateQuantity(index, addIt) async {

    if (  ( addIt ? (modal.localStorage.getCartProducts[index]['quantity'] > 0)
        : modal.localStorage.getCartProducts[index]['quantity'] > 1) )
    {
      await modal.updateCartQtyFridge(context,
          id: modal.localStorage.getCartProducts[index]['cartTableId'].toString(),
          quantity: (
              addIt?
              (modal.localStorage.getCartProducts[index]['quantity']+1):
              (modal.localStorage.getCartProducts[index]['quantity']-1)
          ).toString());
      setState(() {});
    }
  }

  onRemoveProduct(index) async {
    onPressedConfirm() async {
      Navigator.pop(context);
      var data = await modal.removeCart(context,
          cartId: modal.localStorage.getCartProducts[index]['cartTableId'].toString());

      if (data['responseCode'] == 1) {
        alertToast(context, 'Product Removed Successfully.');
        setState(() {});
      }
    }

    AlertDialogue().show(context, 'Are you sure you want to remove this product?',
        firstButtonName: 'Confirm',
        showOkButton: false,
        firstButtonPressEvent: (){onPressedConfirm();},
        showCancelButton: true);

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
  //
  // @override
  // void initState() {
  //   super.initState();
  //   print(user.getUserData);
  //   _razorpay = Razorpay();
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  //
  // }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    int mrp=(double.parse(modal.localStorage.getTotalMrp)*100).toInt();
    var options = {
      'key': 'rzp_live_7SoWHwmMmk3z4i',
      'amount': mrp,
      'name': 'Organic Delight',
      'currency': 'INR',
      'theme.color': '#6a9b26',
      'description': 'Cakes And Pastries',
      'prefill': {'contact': user.getUserContact, 'email':  user.getUserEmail=='null'? '':user.getUserEmail},
      'external': {
        'wallets': ['paytm']
      },
    };

    try {
      _razorpay.open(options);
    }
    catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    print('paymentResponse');
    print(response.toString());
    // await modal.razorPay(context,
    //   addressId:widget.address['id'].toString(),
    //   paymentMethod:addressC.getPaymentMethods[0]['Id'].toString(),
    //   transactionId:response.paymentId,
    //   payableAmount:storedData.getTotalMrp.toString(),
    //   totalAmount:storedData.getTotalMrp.toString(),);

    // AlertDialogue().show(context, 'Success', response.paymentId);
  }


  void _handlePaymentError(PaymentFailureResponse response) {
    print('PaymentFailed');
    alertToast(context, 'Payment Failed');
    // AlertDialogue().show(context, (response.code.toString()+ " - " + response.message.toString()));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    alertToast(context, response.walletName);
  }

  onPressPay() async{
      var data=await modal.onPressedRazorPay(context,);
      if(data['responseCode']==1){
        openCheckout();
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
            title: "Your Fridge Cart",
          ),
          body: modal.localStorage.getCartProducts.isEmpty?
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
              :GetBuilder<FridgeCartLocalStorage>(
              init: FridgeCartLocalStorage(),
              builder: (_) {
                  return Stack(
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
                            // addInstructions(),
                            SizedBox(
                              height: 10,
                            ),

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
          );
                }
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
                '\u20B9' + modal.localStorage.getTotalPrice,
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
                '- \u20B9' + modal.localStorage.getCartTotalDiscount,
                textAlign: TextAlign.end,
                style: textStyleTheme.smallC12
            ),
          ],
        ),
        // Divider(),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Text(
        //           'Delivery Fee',
        //           style: textStyleTheme.smallL12B
        //       ),
        //     ),
        //     Text(
        //         deliveryFee == 0.0
        //             ? 'Free'
        //             : ('\u20B9' +
        //             deliveryFee.toStringAsFixed(2)),
        //         textAlign: TextAlign.end,
        //         style:textStyleTheme.smallL12
        //     ),
        //   ],
        // ),
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
                '\u20B9' + modal.localStorage.getTotalMrp.toString(),
                textAlign: TextAlign.end,
                style: textStyleTheme.smallC14B
            ),
          ],
        ),


        SizedBox(
          height: 10,
        ),
        Visibility(
          visible: modal.localStorage.getDiscount!='',
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
                            modal.localStorage.getDiscount +
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




  productListWidget() {
    return SimpleBuilder(builder: (_) {
      return Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: modal.localStorage.getCartProducts.length,
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
                                imageUrl: fridgeImageUrl+modal.localStorage.getCartProducts[index]['mainImage'].toString(),
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
                                        modal.localStorage.getCartProducts[index]
                                        ['productName'],
                                        style:textStyleTheme.smallC12B
                                    ),
                                    Text(modal.localStorage.getCartProducts[index]
                                    ['unitValue'].toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyleTheme.smallC10B
                                    ),
                                    Text(modal.localStorage.getCartProducts[index]
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
                                      modal.localStorage.getCartProducts[index]
                                      ['productSellingPrice']
                                          .toStringAsFixed(2) +
                                      ' ',
                                  style: textStyleTheme.smallC12B
                              ),
                              Text(
                                  modal.localStorage.getCartProducts[index]['productMRP']
                                      .toString(),
                                  style: textStyleTheme.smallC12BLineThrough
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  modal.localStorage.getCartProducts[index]
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
                                        modal.localStorage.getCartProducts[index]
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
                                '\u20B9' + modal.localStorage.getCartProducts[index]['prTotal'].toString(),
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
                  '\u20B9' + modal.localStorage.getTotalMrp.toString(),
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
                  'Pay',
                  style: textStyleTheme.mediumW
              ),
              onPressed: () {
                onPressPay();  
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
          // Expanded(
          //   flex: 1,
          //   child: TextButton(
          //     style: TextButton.styleFrom(
          //         padding: EdgeInsets.all(8),
          //         primary: Colors.grey,
          //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //         minimumSize: Size(0, 0)
          //     ),
          //     child: Text(
          //         'MOVE TO WISHLIST',
          //         style:  textStyleTheme.smallC12
          //     ),
          //
          //     onPressed: () async {
          //       if(user.getUserId.isEmpty){
          //         App().navigate(context, LoginPage());
          //       }
          //       else{
          //
          //         // onMoveProduct(index);
          //       }
          //     },
          //   ),
          // ),
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
                // onRemoveProduct(index);
              },
            ),
          ),
        ],
      ),
    );
  }}
