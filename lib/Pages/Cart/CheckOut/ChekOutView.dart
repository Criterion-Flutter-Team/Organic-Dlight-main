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
import 'package:organic_delight/Pages/Address/AddressBook/AddressBookController.dart';
import 'package:organic_delight/Pages/Cart/CheckOut/checkOutModal.dart';


import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';



class CheckOutView extends StatefulWidget {

  final Map address;

  const CheckOutView({Key? key, required this.address}) : super(key: key);
  
  @override
  _CheckOutViewState createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  // static const platform = const MethodChannel("razorpay_flutter");
  MyTextTheme textStyleTheme=MyTextTheme();
  LocalStorage storedData = Get.put(LocalStorage());
  double deliveryFee=0.0;
  CheckOutModal modal=CheckOutModal();
  // CartModal _cartModal=CartModal();
  AddressBookController addressC=Get.put(AddressBookController());

  int selectedRadio=0;
  UserData user=UserData();

   late Razorpay _razorpay;


   onPressPay() async{

     if(selectedRadio==2){
       var data=await modal.onPressedRazorPay(context,
           addressId: widget.address['id'].toString(),
           paymentMethod:addressC.getPaymentMethods[1]['Id'].toString());
       if(data['responseCode']==1){
         openCheckout();
       }
     }
     else if(selectedRadio==1) {
      await modal.cashOnDelivery(context,
          totalAmount: storedData.getTotalMrp.toString(),
          addressId:widget.address['id'].toString(),cashPaymentMethod: addressC.getPaymentMethods[0]['Id'].toString());
     }
   }


  //
  // updateTransaction() async{
  //    await modal.getUpdateTransactionDetails(context,
  //        payableAmount,
  //        status_message,
  //        orderId,
  //    )
  // }







  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(setState: setState,
            context: context,
            title: "Check Out",
          ),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('CHECKOUT',
                                style:textStyleTheme.veryLargeL40
                            ),
                            ),
                            SizedBox(height: 50,),

                            productListWidget(),
                            addressDetails(),
                            billDetailsWidget(),
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: SizedBox(
                          height: 150,
                          child: Lottie.asset('assets/payHand.json')),
                    ),

                  ],
                ),
              ),
              payButton(),
            ],
          ),
        ),
      ),
    );
  }



  payButton() {
    return Visibility(
      visible: selectedRadio!=0,
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '\u20B9' + storedData.getTotalMrp.toString(),
                  style: textStyleTheme.smallCB,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  primary: Colors.grey,
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print(user.getUserData);
    print(addressC.getPaymentMethods.toString());
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
     int mrp=(double.parse(storedData.getTotalMrp)*100).toInt();
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
    await modal.razorPay(context,
        addressId:widget.address['id'].toString(),
        paymentMethod:addressC.getPaymentMethods[0]['Id'].toString(),
        transactionId:response.paymentId,
        payableAmount:storedData.getTotalMrp.toString(),
        totalAmount:storedData.getTotalMrp.toString(),);

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
  

  fieldWidget(title,val){
    return Padding(
      padding:  EdgeInsets.fromLTRB(0,0,0,3,),
      child: Wrap(
        children: [
          Text(title.toString()+' ',
            style:textStyleTheme.smallC12B
    ),
          Text(val,
            style:textStyleTheme.smallL12),
          SizedBox(height: 5,),
        ],
      ),
    );
  }

  
  addressDetails(){
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20),
       child: Column(
         children: [
           Divider(
             color: AppColor.grey,
           ),
           Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [

               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Column(
                       children: [
                         Text('Delivery Address',
                           style: textStyleTheme.smallC14B
                        ),
                         SizedBox(height: 10,),
                       ],
                     ),
                     fieldWidget(
                         'Name',
                         widget.address['name'].toString()
                     ),
                     fieldWidget(
                         'Complete Address',
                         (
                             widget.address['city'].toString()+' '+
                                 widget.address['state'].toString()+' '+
                                 widget.address['country'].toString()+' '+
                                 widget.address['pincode'].toString()
                         )
                     ),
                     fieldWidget(
                         'Address Line 1',
                         widget.address['addressLineOne'].toString()
                     ),
                     fieldWidget(
                         'Address Line 2',
                         widget.address['addressLineTwo'].toString()
                     ),
                     fieldWidget(
                         'Landmark',
                         widget.address['landmark'].toString()
                     ),


                   ],
                 ),
               ),
             ],
           )
         ],
       ),
     );
  }

  billDetailsWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(
            'Bill Details',
            style:textStyleTheme.smallC14B
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
                style:textStyleTheme.smallC12
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
                style: textStyleTheme.smallL12
              ),
            ],
          ),
          Divider(),
          couponField(),

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
                style:textStyleTheme.smallC14B
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
          SizedBox(height:10),
          Column(
            children: List.generate(addressC.getPaymentMethods.length, (index) =>  InkWell(
              onTap: (){
                setState(() {
                  selectedRadio=addressC.getPaymentMethods[index]['Id'] as int;
                });
              },
              child: Row(
                children: [
                  Radio(
                      value: addressC.getPaymentMethods[index]['Id'] as int,
                      groupValue: selectedRadio,
                      activeColor: AppColor.lightThemeColor,
                      onChanged: (_){
                        setState(() {
                          selectedRadio=addressC.getPaymentMethods[index]['Id'] as int;
                        });
                      }),
                  Text(addressC.getPaymentMethods[index]['paymentMethodName'],
                    style:textStyleTheme.smallC
                  ),
                ],
              ),
            )),
          )


        ],
      ),
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
            style: textStyleTheme.smallC14B
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(storedData.getCouponCode.toString(),
                style: textStyleTheme.smallL12B
            ),
              Text('- \u20B9'+storedData.getDiscount.toString(),
                textAlign: TextAlign.end,
                style:textStyleTheme.smallL12
              ),
            ],
          ),
          Divider(),

        ],
      ),
    );
  }

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
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                                imageUrl:  imageUrl+storedData.getCartProducts[index]['mainImage'].toString(),
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
                              //       BorderRadius.all(Radius.circular(15)),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          storedData.getCartProducts[index]
                                          ['productName'],
                                          style: textStyleTheme.smallC12B
                                        ),
                                        Row(
                                          children: [
                                            Text('Qty:',style:  textStyleTheme.smallC10B),
                                            Text(storedData.getCartProducts[index]
                                            ['quantity'].toString(),style: textStyleTheme.smallG12),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(storedData.getCartProducts[index]
                                    ['unitValue'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style:  textStyleTheme.smallC10B
                                    ),
                                    Text(storedData.getCartProducts[index]
                                    ['colorName'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style:  textStyleTheme.smallC10B
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
                                                style: textStyleTheme.smallG12
                                              ),
                                            ],
                                          ),
                                        ),

                                        // SizedBox(
                                        //   width: 5,
                                        // ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,

                    ),
                  ],
                );
              })
        ],
      );
    });
  }


}