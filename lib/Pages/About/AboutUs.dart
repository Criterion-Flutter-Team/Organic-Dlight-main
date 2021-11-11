import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> with TickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  onPressDrawer(){
    _scaffoldKey.currentState!.openDrawer();
  }

  var justifyText=TextAlign.justify;
  @override
  bool _showBackToTopButton = false;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(

            controller: _scrollController,
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
                        action: [
                          CommonButtons().cartButton(context),
                        ]
                    ),
                   /* Expanded(child:   searchProducts())*/
                  ],
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

                        Container(

                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('About Us',style: MyTextTheme().mediumC15B),
                              ],
                            ),
                          ),
                        ),SizedBox(height: 30,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,

                          children: [

                            Center(
                              child: Container(
                                child:SizedBox(
                                    height: 150,
                                    child: Lottie.asset('assets/aboutUs.json')),

                                // decoration: BoxDecoration(
                                //     color: AppColor.white,

                                    /*  borderRadius: BorderRadius.all(Radius.circular(0)),
                                border: Border.all(color: Colors.grey.shade200,
                                    width: 2),*/

                                    // image: DecorationImage(
                                    //     image: AssetImage('assets/aboutUs.png',
                                    //
                                    //     ),
                                    //     fit: BoxFit.contain,
                                    //
                                    //
                                    //
                                    //
                                    // )


                                // ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 60,),

                        ExpansionTile(
                          iconColor:AppColor.lightThemeColor,
                          textColor: AppColor.lightThemeColor,
                          title:  Text('Privacy Policy',style:  TextStyle(fontSize: 16)),

                          children: [
                            ListTile(
                              title:  Text('''
This Privacy Policy describes our policies and procedures on the collection & use of your information when you use our website and tells you about your privacy rights.
We use your Personal data to provide and improve the website & service. By using the website, you agree to the collection and use of information in accordance with this Privacy Policy.
While using our website, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you. Personally identifiable information may include, but is not limited to: Email address, First name and Last name, Phone number, Address, State, Postal code, City.
When you access the website by or through a mobile device, we may collect certain information automatically, including, but not limited to, the type of mobile device you use, your mobile device unique ID, the IP address of your mobile device, your mobile operating system, the type of mobile Internet browser you use, unique device identifiers and other diagnostic data.
We may also collect information that your browser sends whenever you visit our website or when you access the website by or through a mobile device.
Your personal information which we collect during your visit to our website is kept confidential.\n
Use of your Personal Data:\n
•	To provide and maintain our Service, including to monitor the usage of our website.\n
•	To manage your Account. The Personal Data you provide can give you access to different functionalities of the Service that are available to you as a registered user.\n
•	To contact you by email, telephone calls, SMS, or other equivalent forms of electronic communication, informative communications related to the functionalities, products.\n
•	To provide you with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless you have opted not to receive such information.\n
•	Advertising. We use your personal information to display interest-based ads for features, products, and services that might be of interest to you.\n
•	To manage your requests: To attend and manage your requests to us.\n
•	For other purposes: We may use your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our website, products, services, marketing and your experience.\n
•	Your consent to this Privacy Policy followed by your submission of such information represents your agreement to that transfer.\n
•	The Company will take all steps reasonably necessary to ensure that your data is treated securely and in accordance with this Privacy Policy and no transfer of your Personal Data will take place to an organization or a country.\n
Data Retention:
When you place an order through the Site, we will maintain your Order Information in our records unless and until you ask us to delete this information.
\nChanges to this Privacy Policy:
We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.
\nContact Us:
If you have any questions about this Privacy Policy, You can contact us: info@theorganicdelight.com

''',textAlign: justifyText,style:  MyTextTheme().smallC14,),
                            ),

                          ],
                        ),
                        ExpansionTile(

                          iconColor:AppColor.lightThemeColor,
                          textColor: AppColor.lightThemeColor,
                          title:  Text('Terms and Conditions',style:TextStyle(fontSize: 16)),

                          children: [
                            ListTile(
                              title:  Text('''Please read these Terms of Service carefully before accessing or using our website. By accessing or using any part of the site, you agree to be bound by these Terms of Service.''',textAlign: justifyText,style: MyTextTheme().smallC14),

                            ),
                            ExpansionTile(

                              iconColor:AppColor.lightThemeColor,
                              textColor: AppColor.lightThemeColor,
                              title:  Text('Products & Services',style: TextStyle(fontSize: 15),),

                              children: [
                                ListTile(
                                  title:  Text('''
\n•	Prices for our products are subject to change without notice.
\n•	We have made every effort to display as accurately as possible the colors and images of our products that appear one the website. We cannot guarantee that your device’s display of any color will be accurate.
\n•	Each product is handmade & hence, the final product may not match the image on the website to 100%.
\n•	We reserve the right to limit the sales of our products, offers, discounts, promotions or services to any person. We may exercise this right on a case-by-case basis.
\n•	We reserve the right to limit the quantities of any products or services that we offer.
\n•	All descriptions of products or product pricing are subject to change at any time without notice, at the sole discretion of us.
\n•	We follow strict hygiene protocol and operate under a manufacturing FSSAI license. We are not liable for any health issue claims arising from the consumption of any of any of our products.
\n•	We reserve the right to discontinue any product, promotion or offer at any time.
\n•	We cannot guarantee product quality if they’re not stored as per storage instructions.
\n•	Certain products or services may be available exclusively online through the website. These products or services may have limited quantities.
  
''',textAlign: justifyText,style:  MyTextTheme().smallC14,),
                                ),

                              ],
                            ),

                            ExpansionTile(

                              iconColor:AppColor.lightThemeColor,
                              textColor: AppColor.lightThemeColor,
                              title:  Text('Refunds & Replacement',style: TextStyle(fontSize: 15),),

                              children: [
                                ListTile(
                                  title:  Text('''
\n•	Requests for replacements or refunds to orders should be made to info@theorganicdelight.com
\n•	Acceptance of requests for order refunds & replacements is subject to discretion by us. Refunds & Replacement must meet the company's policy on reasons, and this is at our discretion.
\n•	Refunds will only be credited to the original source of payment & will take 5 to 7 business days to process.
\n•	If the products are damaged, incomplete or different from the one you have ordered, please contact us immediately and we will have them replaced, upon investigation of the case.
''',textAlign: justifyText,style:  MyTextTheme().smallC14,),
                                ),

                              ],
                            ),
                            ExpansionTile(

                              iconColor:AppColor.lightThemeColor,
                              textColor: AppColor.lightThemeColor,
                              title:  Text('Cancellation & Modification',style: TextStyle(fontSize: 15),),

                              children: [
                                ListTile(
                                  title:  Text('''

\n•	Any requests to modify confirmed orders will be accepted only a minimum of 12 hours in advance.
\n•	Any requests for order cancellations will be accepted only a minimum of 24 hours in advance.
\•	Acceptance of requests for order modifications & cancellations is subject to discretion by us.
\n•	A valid reason for cancellation is required. Any cancellation will attract a 10% processing fee. Else, you can choose the option of 100% credit.
\n•	In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time the order was made.
''',textAlign: justifyText,style:  MyTextTheme().smallC14,),
                                ),

                              ],
                            ),
                            ExpansionTile(

                              iconColor:AppColor.lightThemeColor,
                              textColor: AppColor.lightThemeColor,
                              title:  Text('Ordering',style: TextStyle(fontSize: 15),),

                              children: [
                                ListTile(
                                  title:  Text('''
\n•	You agree to provide current, complete and accurate purchase and account information for all purchases made at our store. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed.
\n•	All billing & delivery information (first and last name, mobile number, email address, complete delivery address) must be accurate & complete. This is necessary for delivery to take place successfully.
\n•	All orders will be processed & confirmed only after a 100% advance payment is made.
\n•	GST & delivery amounts will be calculated after your product is added to the cart.
\n•	Delivery charges depend upon delivery areas & minimum order amount.
\n•	Minimum order amount to process your order, minimum order amount for free delivery & delivery charges are subject to change.
\n•	We may restrict orders and/or deliveries to certain areas and/or dates.
\n•	We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person or per order.
''',textAlign: justifyText,style:  MyTextTheme().smallC14,),
                                ),

                              ],
                            ),
                            ExpansionTile(
                              iconColor:AppColor.lightThemeColor,
                              textColor: AppColor.lightThemeColor,
                              title:  Text('Delivery',style: TextStyle(fontSize: 15),),

                              children: [
                                ListTile(
                                  title:  Text('''
\n•	We are not liable for the condition of products that reach the customer through third party logistics/ apps or any other type of pick up arranged by the customer.
\n•	All orders are committed to be delivered at any given point in time within the delivery time slot & not at any specific delivery time. Cancelling an order due to a fixed committed time is not guaranteed.
\n•	We are committed to delivering all our orders within the given time slot, on the given day. If by any chance an order is delivered outside of the committed time slot, it is not intentional, and at most would be liable to replace the cake or refund the amount.
\n•	We are committed to delivering all our orders within the given time slot, on the given day. If by any chance an order is missed and not delivered, it is not intentional, and at most would be liable to replace the cake or refund the amount.
\n•	If you happen to be unavailable when the delivery executive reaches your location, he will hand the order to your building’s security guard. Re-delivering our products is not possible due to their perishable nature.
''',textAlign: justifyText,style:  MyTextTheme().smallC14,),
                                ),

                              ],
                            ),
                            ExpansionTile(
                              iconColor:AppColor.lightThemeColor,
                              textColor: AppColor.lightThemeColor,
                              title:  Text('General',style: TextStyle(fontSize: 15),),

                              children: [
                                ListTile(
                                  title:  Text('''
\n•	We reserve the right to blacklist any customer that showcases disrespectful behavior, disregard or misconduct towards the company, its owners or employees.
\n•	Occasionally there may be information on our website that contains inaccuracies or omissions that may relate to product descriptions, pricing, promotions, offers, delivery charges & availability. We reserve the right to correct any errors, inaccuracies or omissions, and to change or update information or cancel orders if any information is inaccurate at any time without prior notice (including after you have submitted your order).
\n•	Ownership of the products is transferred completely to the customer only once full payment of the billed amount is made, and the product is delivered. Products are at the risk of the customers once they have been delivered.
\n•	You may not use our products & services for any illegal or unauthorized purpose.
\n•	We reserve the right to refuse service to anyone for any reason at any time.
\n•	You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the product & service, use of the service, or access to the service or any contact on the website through which the service is provided, without express written permission by us.
\n•	We shall not be liable to you for any modification, price change, suspension or discontinuance of the products & services.
\n•	We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers or distributors.
''',textAlign: justifyText,style:  MyTextTheme().smallC14,),
                                ),

                              ],
                            ),

                          ],
                        ),
                        ExpansionTile(
                          iconColor:AppColor.lightThemeColor,
                          textColor: AppColor.lightThemeColor,
                          title:  Text('Cancellation / Refund Policy',style: TextStyle(fontSize: 16)),

                          children: [
                            ListTile(
                              title:  Text('''You may return most new, unopened items within 2 days of delivery for a full refund. We will also pay the return shipping costs if the return is a result of our error (you received an incorrect or defective item, etc.). You should expect to receive your refund within two weeks of giving your package to the return shipper; however, in many cases you will receive a refund more quickly. This time period includes the transit time for us to receive your return from the shipper (5 to 7 business days), the time it takes us to process your return once we receive it (3 to 5 business days), and the time it takes your bank to process our refund request (5 business days).''',textAlign: justifyText,style: MyTextTheme().smallC14),
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),

                      ],
                    ),
                  ])),


            ],
          ),
          floatingActionButton: FloatingActionButton(
          onPressed: () {_scrollToTop();
            // Add your onPressed code here!
          },
          child: const Icon(Icons.navigation),
          backgroundColor: Colors.green,
        ),

      ),)
    );


  }

}
