


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:organic_delight/AppManager/appColors.dart';

class ReceiptAlert{




  show(context,
      {
        String? transactionId,
        String? orderId,
        String? totalAmount,
        String? orderDate,
        bool? checkIcon
      }
      ){
    var canPressOk=true;
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return StatefulBuilder(
              builder: (context,setState)
              {
                return Transform.scale(
                  scale: a1.value,
                  child: Opacity(
                    opacity: a1.value,
                    child: WillPopScope(
                      onWillPop: (){
                        Navigator.pop(context);
                        return Future.value(false);
                      },
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Container(
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(40,20,40,20),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                          child: Column(
                                            children: [

                                              SizedBox(
                                                  height: 150,
                                                  child: Lottie.asset('assets/receipt.json')),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    // Wrap(
                                                    //   children: [
                                                    //     Text("Transaction Id :",
                                                    // style: TextStyle(
                                                    //     fontWeight: FontWeight.bold)),
                                                    //     Text(transactionId.toString(),
                                                    //       style: TextStyle(
                                                    //       ),),
                                                    //   ],
                                                    // ),

                                                    Wrap(
                                                      children: [
                                                        Text("Order Id :",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold)),
                                                        Text(orderId.toString(),
                                                          style: TextStyle(
                                                          ),),
                                                      ],
                                                    ),
                                                    Wrap(
                                                      children: [
                                                        Text("Order Date :",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold)),
                                                        Text(orderDate.toString(),
                                                          style: TextStyle(
                                                          ),),
                                                      ],
                                                    ),
                                                    Wrap(
                                                      children: [
                                                        Text("Total Amount :",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                            )),
                                                        Text( ' \u20B9 ' +totalAmount.toString(),
                                                          style: TextStyle(color: AppColor.lightThemeColor
                                                          ),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(8,0,8,0,),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                      style: TextButton.styleFrom(
                                                        primary: Colors.black,
                                                        padding: EdgeInsets.all(8),
                                                      ),
                                                      onPressed: () {
                                                        if(canPressOk)
                                                        {
                                                          canPressOk=false;
                                                          Navigator.pop(context);
                                                        }
                                                      },
                                                      child: Text(
                                                        'Continue Shopping',
                                                        style: TextStyle(color: AppColor.lightThemeColor,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        }).then((val){
      canPressOk=false;
    });
  }



}