import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/Cart/CartModal.dart';
import 'package:organic_delight/Pages/Cart/Coupons/AddCouponModal.dart';


class AddCoupons extends StatefulWidget {


  final String totalAmount;

  const AddCoupons({Key? key,  required this.totalAmount}) : super(key: key);

  @override
  _AddCouponsState createState() => _AddCouponsState();
}

class _AddCouponsState extends State<AddCoupons> {
  TextEditingController couponC=TextEditingController();
  MyTextTheme textStyleTheme=MyTextTheme();
  CartModal modal=CartModal();
  CouponModal couponModal=CouponModal();

  var data;

  get()
  async{
     data=await couponModal.getCouponList(context);
     print(data);
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
    get();
  }

  var couponId;
  List couponValueList=[];





  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
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
                  title: 'Apply Coupons'
                ),
              ),
              SliverAppBar(
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
                    Padding(
                      padding:  EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.lightThemeColor,
                              width: 2)
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: couponC,
                                    enabled: false,
                                    textCapitalization: TextCapitalization.characters,
                                    decoration: InputDecoration(
                                      hintText: 'Select coupon code',
                                      contentPadding: EdgeInsets.all(5),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.grey
                                  ),
                                  child: Text('APPLY',
                                  style: TextStyle(
                                    color: couponId!=null? AppColor.lightThemeColor:
                                      AppColor.grey,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  onPressed: (){
                                    if(couponId!=null){
                                      couponModal.applyCoupon(context,
                                          couponAppliedCode: couponC.text,
                                          couponAppliedId: couponId,
                                          couponValue:couponValueList
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          couponModal.couponCodeList.isEmpty? Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,40,0,40),
                              child: Text('No Coupon Available',
                                  style:textStyleTheme.smallL
                              ),
                            ),
                          ):Column(
                            children: List.generate(couponModal.couponCodeList.length, (index) =>
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black,
                                    padding: EdgeInsets.all(0),
                                  ),
                                  onPressed: (){
                                   /* print(couponCodeList[index]['couponCode']);*/
                                    if((double.parse(widget.totalAmount)>couponModal.couponCodeList[index]['minimumCartValue'])){
                                      couponC.text=couponModal.couponCodeList[index]['couponCode'];
                                      couponId=couponModal.couponCodeList[index]['id'];
                                      couponValueList.clear();
                                      couponValueList.add(couponModal.couponCodeList[index]['couponCode'] );
                                      couponValueList.add(couponModal.couponCodeList[index]['discountPercentage'] );
                                    }
                                    setState(() {

                                    });

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,8,),
                                    child: Container(
                                     decoration: BoxDecoration(

                                       borderRadius: BorderRadius.all(Radius.circular(20))
                                     ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0,4,0,4,),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                   image: DecorationImage(
                                                       image: AssetImage(((index+1)%3==0)? 'assets/coupon3.png':
                                                       ((index+1)%2==0)? 'assets/coupon2.png':'assets/coupon1.png',),
                                                     fit: BoxFit.fill
                                                   )

                                              ),
                                              padding: const EdgeInsets.fromLTRB(30,10,30,10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(couponModal.couponCodeList[index]['discountPercentage'].toString()+'% OFF',
                                                        style:textStyleTheme.largeC20B),
                                                        Text('On minimum purchase of \u20B9'+couponModal.couponCodeList[index]['minimumCartValue'].toStringAsFixed(2),
                                                          style: textStyleTheme.smallC),
                                                        SizedBox(height: 20,),
                                                        Wrap(
                                                          children: [
                                                            Text('Code: ',
                                                              style: textStyleTheme.smallC),
                                                            Text(couponModal.couponCodeList[index]['couponCode'],
                                                              style: textStyleTheme.smallCB
                                                            ),
                                                          ],
                                                        ),
                                                        // Wrap(
                                                        //   children: [
                                                        //     Text('Expiry: ',
                                                        //       style: TextStyle(
                                                        //         color: AppColor.customBlack,
                                                        //
                                                        //       ),),
                                                        //     Text(couponModal.couponCodeList[index]['entryDate'],
                                                        //       style: TextStyle(
                                                        //           color: AppColor.customBlack,
                                                        //           fontWeight: FontWeight.bold
                                                        //       ),),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Image(image: AssetImage('assets/examplePie.png'),))
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            child: Visibility(
                                              visible: (double.parse(widget.totalAmount)<couponModal.couponCodeList[index]['minimumCartValue']),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    RotationTransition(
                                                      turns: new AlwaysStoppedAnimation(-15 / 360),
                                                      child: Text('NOT AVAILABLE',
                                                      textAlign: TextAlign.center,
                                                      style: textStyleTheme.largeB20
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          )

                        ],
                      ),
                    )
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}

class DolDurmaClipper extends CustomClipper<Path> {
  DolDurmaClipper({required this.right, required this.holeRadius});

  final double right;
  final double holeRadius;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - right - holeRadius, 0.0)
      ..arcToPoint(
        Offset(size.width - right, 0),
        clockwise: false,
        radius: Radius.circular(1),
      )
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - right, size.height)
      ..arcToPoint(
        Offset(size.width - right - holeRadius, size.height),
        clockwise: false,
        radius: Radius.circular(1),
      );

    path.lineTo(0.0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}