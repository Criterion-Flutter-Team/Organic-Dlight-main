import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/widgets/textFeild.dart';
import 'package:organic_delight/Pages/Cart/CartModal.dart';
import 'package:organic_delight/Pages/LoginPage/LoginPageModal.dart';
import 'package:pin_code_fields/pin_code_fields.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

   bool isLogin=true;

   MyTextTheme textStyleTheme=MyTextTheme();

   TextEditingController  emailC=TextEditingController();
   TextEditingController  passWordC=TextEditingController();


   TextEditingController otpControlller=TextEditingController();


   TextEditingController  contactC=TextEditingController();
   TextEditingController  userNameC=TextEditingController();
   TextEditingController  signUpEmailC=TextEditingController();
   TextEditingController  signUpPassC=TextEditingController();
     TextEditingController confirmUpPassC=TextEditingController();

   LoginPageModal modal=LoginPageModal();
   CartModal cartModal=CartModal();



   App app=App();

   var startValidation=false;
   bool enteringOTP=false;
   bool forgotPassword=false;

   final _formKey = GlobalKey<FormState>();


   clearAllController(){
     emailC.clear();
     contactC.clear();
     passWordC.clear();
     userNameC.clear();
     signUpPassC.clear();
     signUpEmailC.clear();
     confirmUpPassC.clear();
    otpControlller.clear();
   }

   onPressedSignUp(isSignUp) async{
     FocusScope.of(context).unfocus();
     forgotPassword=false;
     setState(() {
       startValidation=true;
     });

     if(_formKey.currentState!.validate() || isSignUp==false)
     {
       var data= await modal.signUp(context,isSignUp,
       name: userNameC.text,
       email: signUpEmailC.text,
       contact: contactC.text,
       password: confirmUpPassC.text,
       );

       if(data['responseCode']==1){
        otpControlller.clear();

         setState(() {
           enteringOTP=true;
           startValidation=false;
         });
       }
     }
   }

   onPressedLogin() async{
     // app.navigate(context, Dashboard());
     FocusScope.of(context).unfocus();

     setState(() {
       startValidation=true;
     });
     if(_formKey.currentState!.validate())
     {
       var data= await modal.login(context, emailC.text, passWordC.text,);

       if(data['responseCode']==1){
         print('12343535');
         // addGuestIdDataToLoginID();
         clearAllController();
         setState(() {
           startValidation=false;
         }
         );
       }
     }
   }

   lostPassword() async{
     // app.navigate(context, Dashboard());
     FocusScope.of(context).unfocus();

print('forgotPassword');
         print(forgotPassword);
         setState(() {
           forgotPassword=true;
         });   }

  forgotPasswords() async{
     // app.navigate(context, Dashboard());
     FocusScope.of(context).unfocus();
         setState(() {
           enteringOTP=true;

         });
   }


   onPressedToggle(val){

     FocusScope.of(context).unfocus();
     clearAllController();
     isLogin=val;
     startValidation=false;
     if(val){
       enteringOTP=false;
     }
     setState(() {
       forgotPassword=false;
       enteringOTP=false;
     });
   }

   onPressedVerify() async{
     FocusScope.of(context).unfocus();
     setState(() {
       startValidation=true;
     });
     if(_formKey.currentState!.validate())
     {
       var data= await modal.verifyOtp(context, (
           isLogin?
               emailC.text
               :contactC.text), otpControlller.text, isLogin);
       if(data['responseCode']==1){
         clearAllController();
         setState(() {
           startValidation=false;
           enteringOTP=false;
           isLogin=true;
         });
       }
     }
   }


 requestOTP(mobileNo) async{
     FocusScope.of(context).unfocus();
     setState(() {
       startValidation=false;
     });
       var data= await modal.userLoginWithOTP(context, mobileNo);
       if(data['responseCode']==1){
         // clearAllController();
         setState(() {
           startValidation=false;
           enteringOTP=true;
           isLogin=true;

         });
       }
   }




  @override
  Widget build(BuildContext context) {
     var screenSize=MediaQuery.of(context).size;

    return  Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Stack(
              children: [
                Container(
                  decoration:  BoxDecoration(
                      image:  DecorationImage(
                        image:  AssetImage("assets/backGround.png"),
                        fit: BoxFit.fill,
                      )
                  ),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(icon: IconButton(
                            icon: Icon(Icons.arrow_back,
                            color: AppColor.customBlack,),
                            onPressed: (){
                              Navigator.pop(context); },
                          ),
                              onPressed: (){
                            Navigator.pop(context);
                              }),
                        ],
                      ),
                      SizedBox(
                          height: 30,
                          child: Image(image: AssetImage('assets/logo.png'),)),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                toggleButton(),
                                SizedBox(height: 20,),

                                enteringOTP? otpPart():isLogin? loginPart(): enteringOTP? otpPart():signUpPart(),
                                SizedBox(height: 20,),
                                Text('Our Social Pages',
                                  style: textStyleTheme.smallGreyB
                                ),
                                SizedBox(height: 30,),
                                socialButton(),
                                SizedBox(height: 30,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                        return  isKeyboardVisible? Container():SizedBox(
                            height: screenSize.height/3.6,
                            child: Image(image: AssetImage('assets/loginHuman.png'),));
                      }
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: -15,
                  child:  KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                        return  isKeyboardVisible? Container():SizedBox(
                            height: screenSize.height/6,
                            child: Image(image: AssetImage('assets/loginBags.png'),));
                      }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



   toggleButton(){
     return enteringOTP? SizedBox():Container(
       decoration: BoxDecoration(
           border: Border.all(
               color: Colors.grey.shade200
           ),
           borderRadius: BorderRadius.all(Radius.circular(20))
       ),
       child: Row(
         children: [
           Expanded(
             child: TextButton(
               style: TextButton.styleFrom(
                 primary: Colors.grey,
                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                 padding: EdgeInsets.all(0),
                 backgroundColor: isLogin? AppColor.buttonColor:Colors.white,
                 shape: AppWidgets.buttonShape,
               ),
               child: Text('Login',
                   style: TextStyle(
                       color: isLogin? Colors.white:AppColor.lightThemeColor
                   )),
               onPressed: (){
                 onPressedToggle(true);

               },
             ),
           ),
           Expanded(
             child: TextButton(
               style: TextButton.styleFrom(
                 primary: Colors.grey,
                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                 padding: EdgeInsets.all(0),
                 backgroundColor: !isLogin? AppColor.buttonColor:Colors.white,
                 shape: AppWidgets.buttonShape,
               ),
               child: Text('SignUp',
                   style: TextStyle(
                       color: !isLogin? Colors.white:AppColor.lightThemeColor
                   )),
               onPressed: (){
                 onPressedToggle(false);
               },
             ),
           ),
         ],
       ),
     );
   }



   loginPart(){
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text('Mobile No *',
         style:textStyleTheme.smallC
         ),
         SizedBox(height: 5,),
         TextFieldClass(
           inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
           keyboardType: TextInputType.number,
           maxLength: 10,
           controller: emailC,
           validator: (value){
             if(value!.length==0)
             {
               return startValidation? 'Mobile must not be empty.': null;
             }
             else{
               return null;
             }
           },

           hintText: 'Enter Your Registered Number',
         ),
         SizedBox(height: 15,),
         Text('Password *',
           style:textStyleTheme.smallC
         ),
         SizedBox(height: 5,),

         TextFieldClass(
           controller: passWordC,
           validator: (value){
             if(value!.length==0)
             {
               return startValidation? 'Password must not be empty.': null;
             }
             else{
               return null;
             }
           },
           hintText: 'Enter Password',
           isPasswordField: true,
         ),
         // Row(
         //   mainAxisAlignment: MainAxisAlignment.end,
         //   children: [
         //     FlatButton(
         //       child: Text('Lost your Password?',
         //       style: TextStyle(
         //         color: AppColor.customBlack
         //       ),),
         //         onPressed: (){
         //           lostPassword();
         //         },
         //
         //     ),
         //   ],
         // ),
         SizedBox(height: 20,),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [

             TextButton(
               style: TextButton.styleFrom(
                   backgroundColor: AppColor.buttonColor,
                   shape: AppWidgets.buttonShape,
                   padding: EdgeInsets.symmetric(horizontal: 22,vertical: 5)
               ),
               onPressed: () {
                 onPressedLogin();
               },
               child:  Text('Login',
                 style: textStyleTheme.mediumW,),
             ),



           ],
         ),
         SizedBox(height: 10,),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(
               "OR",
               style: textStyleTheme.smallC12B

             ),
           ],
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [

             TextButton(
                 onPressed: (){
                   requestOTP(emailC.text);
                 },

                 child: Text(
                   "Request OTP",
                   style:textStyleTheme.smallL12B

                 )),
           ],
         )
       ],
     );
   }

   signUpPart(){
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [

         Text('Name *',
           style:textStyleTheme.smallC
         ),
         SizedBox(height: 5,),
         TextFieldClass(
           controller: userNameC,
           validator: (value){
             if(value!.length==0)
             {
               return startValidation? 'Name must not be empty.': null;
             }
             else{
               return null;
             }
           },
           hintText: 'Enter Name (ex: abc)',
         ),
         SizedBox(height: 15,),
         Text('Contact *',
           style:textStyleTheme.smallC
         ),
         SizedBox(height: 5,),
         TextFieldClass(
           inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
           maxLength: 10,
           validator: (value){
             if(value!.length==0)
             {
               return startValidation? 'Contact must not be empty.': null;
             }
             else if(value.length<10){
               return startValidation? 'Please Enter full no.': null;
             }
             else{
               return null;
             }
           },
           controller: contactC,
           keyboardType: TextInputType.number ,
           hintText: 'Enter Contact (ex: 9999999999)',
         ),
         SizedBox(height: 15,),
         Text('Email *',
           style:textStyleTheme.smallC
         ),
         SizedBox(height: 5,),
         TextFieldClass(
           controller: signUpEmailC,
           keyboardType: TextInputType.emailAddress,
           validator:(value) {
             Pattern pattern =
                 r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
             RegExp regex = new RegExp(pattern.toString());
             if(value!.length==0){
               return startValidation? 'Email can not be empty':null;
             }
             else if (!regex.hasMatch(value))
               return startValidation? 'Enter valid email':null;
             else
               return null;
           },
           hintText: 'Enter Name (ex: abc@gmail.com)',
         ),
         SizedBox(height: 15,),
         Text('Password *',
           style:textStyleTheme.smallC
         ),
         SizedBox(height: 5,),
         TextFieldClass(
           controller: signUpPassC,
           validator: (value){
             if(value!.length==0)
             {
               return startValidation? 'Password must not be empty.': null;
             }
             else{
               return null;
             }
           },
           hintText: 'Enter Password',
           isPasswordField: true,
         ),
         SizedBox(height: 15,),
         Text('Confirm Password *',
           style: textStyleTheme.smallC
         ),
         SizedBox(height: 5,),
         TextFieldClass(
           controller: confirmUpPassC,
           validator: (value){
             if(value!.length==0)
             {
               return startValidation? 'Confirm Password must not be empty.': null;
             }
             else if(value.toString()!=signUpPassC.text){
             return startValidation? 'Password does not match.': null;
             }
             else{
               return null;
             }
           },
           hintText: 'Confirm Password',
           isPasswordField: true,
         ),
         SizedBox(height: 20,),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [

             TextButton(
               style: TextButton.styleFrom(
                   backgroundColor: AppColor.buttonColor,
                   shape: AppWidgets.buttonShape,
                   padding: EdgeInsets.symmetric(horizontal: 22,vertical: 5)
               ),

               onPressed: () {
                 onPressedSignUp(true);
               },
               child:  Text('SignUp',
                 style: textStyleTheme.mediumW),
             ),

           ],
         )
       ],
     );
   }

   otpPart(){
     return Column(
       children: [
         Padding(
           padding:
           const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
           child: RichText(
             text: TextSpan(
                 text: "Enter the code sent to ",
                 children: [
                   TextSpan(
                       text: "${
                           isLogin?
                               emailC.text
                               :contactC.text}",
                       style: textStyleTheme.largeL15B
                   ),
                 ],
                 style:textStyleTheme.largeB5415
             ),
             textAlign: TextAlign.center,
           ),
         ),

         Padding(
             padding: const EdgeInsets.symmetric(
                 vertical: 8.0, horizontal: 30),
             child: PinCodeTextField(
               appContext: context,
               pastedTextStyle:textStyleTheme.smallLB,
               length: 5,
               obscureText: true,
               obscuringCharacter: '*',
               // obscuringWidget: FlutterLogo(
               //   size: 24,
               // ),
               blinkWhenObscuring: true,
               animationType: AnimationType.fade,
               validator: (v) {
                 if (v!.length < 5) {
                   return "OTP must be filled completely.";
                 }
                 else {
                   return null;
                 }
               },
               pinTheme: PinTheme(
                 activeColor: AppColor.lightThemeColor,
                 activeFillColor: AppColor.lightThemeColor,
                 shape: PinCodeFieldShape.box,
                 borderRadius: BorderRadius.circular(5),
                 fieldHeight: 50,
                 fieldWidth: 40,
               ),
               cursorColor: Colors.black,
               animationDuration: Duration(milliseconds: 300),
               enableActiveFill: true,
               controller: otpControlller,
               keyboardType: TextInputType.number,
               boxShadows: [
                 BoxShadow(
                   offset: Offset(0, 1),
                   color: Colors.black12,
                   blurRadius: 10,
                 )
               ],
               onCompleted: (v) {
                 print("Completed");
               },
               // onTap: () {
               //   print("Pressed");
               // },
               onChanged: (value) {

               },
               beforeTextPaste: (text) {
                 print("Allowing to paste $text");
                 //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                 //but you can show anything you want here, like your pop up saying wrong paste format or etc
                 return true;
               },
             )),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(
               "Didn't receive the code? ",
               style: textStyleTheme.largeB5415

             ),
             TextButton(
                 onPressed: (){
                   if(isLogin){
                     otpControlller.clear();
                     requestOTP(emailC.text);
                   }

                   else{
                     onPressedSignUp(false);
                   }
                 },
                 child: Text(
                   "RESEND",
                   style:textStyleTheme.largeSkyBlue

                 ))
           ],
         ),
         SizedBox(height: 15,),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [

             TextButton(
               style: TextButton.styleFrom(
                 backgroundColor: AppColor.buttonColor,
                 shape: AppWidgets.buttonShape,
                 padding: EdgeInsets.symmetric(horizontal: 22,vertical: 5)
               ),

               onPressed: () {
                 onPressedVerify();
               },
               child:  Text('Verify',
                 style:textStyleTheme.mediumW),
             ),




           ],
         )
       ],
     );
   }



   socialButton(){
     return     Row(
       children: [
         Expanded(child: SizedBox()),
         Expanded(
           child: IconButton(
             icon: Image(
               image: AssetImage('assets/facebook.png'
               ),
             ),
             onPressed: (){
               alertToast(context, 'FaceBook page will be available soon');
               // ProgressDialogue().show(context,
               //   loadingText: 'Loading'
               // );
             },
           ),
         ),
         Expanded(
           child: IconButton(
             icon: Image(
               image: AssetImage('assets/instagram.png'
               ),
             ),
             onPressed: (){
               alertToast(context, 'Instagram page will be available soon');
             },
           ),
         ),
         Expanded(
           child: IconButton(
             icon: Image(
               image: AssetImage('assets/linkedin.png'
               ),
             ),
             onPressed: () async{
               alertToast(context, 'LinkedIn page will be available soon');
             },
           ),
         ),
         Expanded(child: SizedBox()),
       ],
     );
   }
}
