import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/localStorage.dart';
import 'package:organic_delight/AppManager/userData.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/AppManager/widgets/flatBurtton.dart';
import 'package:organic_delight/AppManager/widgets/textFeild.dart';
import 'package:organic_delight/Pages/Cart/CartModal.dart';
import 'package:organic_delight/Pages/CommonWidgets/Buttons/CommonButtons.dart';
import 'package:organic_delight/Pages/CommonWidgets/Drawer/Drawer.dart';
import 'package:organic_delight/Pages/Dashboard/Profile/ProfileModal.dart';
import 'package:organic_delight/Pages/Dashboard/WhishList/WishListController.dart';
import 'package:organic_delight/Pages/FromFridge/FridgeCart/fridge_cart_local_storage.dart';
import 'package:organic_delight/Pages/LoginPage/LoginPage.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  MyTextTheme textStyleTheme=MyTextTheme();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var startValidation=false;
  // final _formKey = GlobalKey<FormState>();
  bool isUpdating =false;

  ProfileModal modal=ProfileModal();
  LocalStorage storedData=Get.put(LocalStorage());
  FridgeCartLocalStorage fridgeStoredData=Get.put(FridgeCartLocalStorage());

  WishListController wishListC=Get.put(WishListController());
  CartModal cartModal=CartModal();

  TextEditingController nameC=TextEditingController();
  TextEditingController emailC=TextEditingController();
  TextEditingController mobileNoC=TextEditingController();

  UserData user=Get.put(UserData());
  App app = App();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async{
    nameC.text=  user.getName;
    emailC.text= user.getUserEmail;
    mobileNoC.text=  user.getUserContact;
  }


  onPressDrawer(){
    _scaffoldKey.currentState!.openDrawer();
  }


  onPressedLogOut(){
    onPressedLogOut() async{

      await user.removeUserData();
      await user.removeUserToken();
      await wishListC.removeProductList();
       await user.removeUserId();
      await storedData.removeProduct();
      await fridgeStoredData.removeFridgeProduct();
      await cartModal.getCartDetails(context);
      Navigator.pop(context);
      get();
    }
    AlertDialogue().show(context, 'Are you sure you want to Logout?',
        showCancelButton: true,
        firstButtonName: 'LogOut',
        showOkButton: false,
        firstButtonPressEvent: onPressedLogOut
    );
  }


  onPressedLogin() async{
   Navigator.push(context, MaterialPageRoute(builder: (context){
      return LoginPage();

    }));
    get();
    if(user.getUserData.isNotEmpty){
      alertToast(context, 'Welcome '+ user.getName);

    }
  }



  onPressedChangePassword() {
    modal.showChangePasswordDialogue(context);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: SimpleBuilder(
          builder: (_) => Scaffold(
            key: _scaffoldKey,
            drawer: MyDrawer(),
            body: user.getUserData.isEmpty? loginFirst():CustomScrollView(
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
                      leadingIcon: CommonButtons().drawerButton(onPressDrawer),
                      action: [
                        CommonButtons().cartButton(context),
                      ]
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([profilePart(),
                    ])),
              ],
            ),
          )
        )
      ),
    );
  }



  loginFirst(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        MyWidget().myAppBar(
            context: context,
            leadingIcon: CommonButtons().drawerButton(onPressDrawer),
            action: [
              CommonButtons().cartButton(context),
            ]
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          // image: NetworkImage(baseUrl+'/image'+listOfData[index]['mainImage']),
                            image: AssetImage('assets/profileBread.png'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('KINDLY',
                            textAlign: TextAlign.center,
                            style:textStyleTheme.veryLargeC30
                          ),

                          Text('Login',
                            textAlign: TextAlign.center,
                            style: textStyleTheme.largeC18
                          ),
                          Text('First',
                            textAlign: TextAlign.center,
                            style: textStyleTheme.veryLargeC30
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,0,),
                      child: FlatBtn(
                        title: 'Login',
                        onPress: onPressedLogin,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    SizedBox(
                        height: 150,
                        child: Image(image: AssetImage('assets/profileCake.png'),)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }



  profilePart() {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 80,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 60,),
                          Text('Name',
                            style: textStyleTheme.smallC
                          ),
                          SizedBox(height: 5,),
                          TextFieldClass(
                              controller: nameC,
                              validator: (value){
                                if(value!.length==0)
                                {
                                  return startValidation? 'Name must not be empty.': null;
                                }
                                else{
                                  return null;
                                }
                              },
                              hintText: 'Enter Name (ex:abc)',
                              enabled: isUpdating,
                              suffixIcon: Visibility(
                                  visible: isUpdating,
                                  child: Icon(Icons.edit,
                                    color: AppColor.orangeColor,))
                          ),
                          SizedBox(height: 15,),
                          Text('Email',
                            style:textStyleTheme.smallC
                          ),
                          SizedBox(height: 5,),
                          TextFieldClass(
                              controller: emailC,
                              validator: (value){
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
                              hintText: 'Enter Email (ex:abc@gmail.com)',
                              enabled: isUpdating,
                              suffixIcon: Visibility(
                                  visible: isUpdating,
                                  child: Icon(Icons.edit,
                                    color: AppColor.orangeColor,))
                          ),
                          SizedBox(height: 15,),
                          Text('Mobile No',
                            style:textStyleTheme.smallC
                          ),
                          SizedBox(height: 5,),
                          TextFieldClass(
                              controller: mobileNoC,
                              validator: (value){
                                if(value!.length==0)
                                {
                                  return startValidation? 'Password must not be empty.': null;
                                }
                                else{
                                  return null;
                                }
                              },
                              hintText: 'Enter Mobile No (ex:9999999999)',
                              enabled: isUpdating,
                              suffixIcon: Visibility(
                                  visible: isUpdating,
                                  child: Icon(Icons.edit,
                                    color: AppColor.orangeColor,))
                          ),
                          SizedBox(height: 20,),
                          bottomButtons(),

                          // updateButton(),
                          // updateOrCancelButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                child:  profileImageWidget(),)
            ],
          )

        ],
      ),
    );
  }


  bottomButtons(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.grey
            // textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            onPressedChangePassword();
          },
          child: Text('Change Password',
            style:textStyleTheme.smallOB
          ),
        ),

        TextButton(
          style: TextButton.styleFrom(
              primary: Colors.grey
            // textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            onPressedLogOut();
          },
          child: Text('Logout',
            style:textStyleTheme.smallO14B
          ),
        ),

      ],
    );
  }

  //
  // updateButton(){
  //   return   Visibility(
  //     visible: isUpdating,
  //     child: Column(
  //       children: [
  //         SizedBox(height: 20,),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             FlatButton(
  //               color: AppColor.buttonColor,
  //               shape: AppWidgets.buttonShape,
  //               child: Text('Update',
  //                 style: AppWidgets.buttonTextStyle,),
  //               onPressed: (){
  //                 // onPressedLogin();
  //               },
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // updateOrCancelButton(){
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       FlatButton(child: Text(isUpdating? 'Cancel':'Update',
  //       style: TextStyle(
  //         color: AppColor.orangeColor,
  //         fontWeight: FontWeight.bold
  //       ),),
  //         onPressed: () {
  //         setState(() {
  //           isUpdating=!isUpdating;
  //         } );
  //         },
  //       ),
  //     ],
  //   );
  // }

  profileImageWidget(){
    return  AvatarGlow(
      glowColor: AppColor.lightThemeColor,
      endRadius: 80.0,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 100),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 60.0,
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          backgroundImage: AssetImage('assets/user.jpg'),
          radius: 58.0,
        ),
      ),
    );
  }


}
