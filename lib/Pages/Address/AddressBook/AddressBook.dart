
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/localStorage.dart';
import 'package:organic_delight/AppManager/widgets/MyAppBar.dart';
import 'package:organic_delight/Pages/Address/AddAddress/AddAddress.dart';
import 'package:get/get.dart';
import 'package:organic_delight/Pages/Address/AddressBook/AddressBookController.dart';
import 'package:organic_delight/Pages/Address/AddressBook/AddressBookModal.dart';
import 'package:organic_delight/Pages/Cart/CheckOut/ChekOutView.dart';

class AddressBook extends StatefulWidget {
  final bool showAddress;

  const AddressBook({Key? key, required this.showAddress}) : super(key: key);
  @override
  _AddressBookState createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {

  MyTextTheme textStyleTheme=MyTextTheme();
  AddressBookModal modal=AddressBookModal();

  AddressBookController controller=Get.put(AddressBookController());

  LocalStorage storedData = Get.put(LocalStorage());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }


  get() async{
  await getAddressList();
  }



  getAddressList() async{
    await modal.getAddress(context);

  }





  onPressedDelete(id,context)async{
    pressedDelete() async {
      await  modal.deleteAddressAt(id,context);
       get();
      setState(() {

      });
      Navigator.pop(context);

    }
    AlertDialogue().show(context, 'Do you want to delete this address?',
        showCancelButton: true,
        firstButtonName: 'Delete',
        showOkButton: false,
        firstButtonPressEvent: pressedDelete
    );
  }


  onPressedEditAddress(map,context)async {
    await App().navigate(context, AddAddress(editAddress: map,));
  }




  onPressedAddAddress() async{
    await App().navigate(context, AddAddress());
    get();
  }


  onPressedOnAddress(address) async{
    controller.updateDeliveryId=address['id'];
    setState(() {

    });
   //  Navigator.pop(context);
  }


  onPressProceedToPay(){
    Map sendAddress={};

    for(int i=0; i<controller.getAddressList.length; i++){

      if(controller.getSelectedAddressId==controller.getAddressList[i]['id']){
        sendAddress=controller.getAddressList[i];
      }

    }

    App().navigate(context, CheckOutView(

      address: sendAddress,

    ));
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          body:  Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      pinned: false,
                      //  snap: true,
                      //  expandedHeight:  kToolbarHeight,
                      forceElevated: false,
                      floating: true,
                      flexibleSpace:  MyWidget().myAppBar(
                        title: "Address Book",
                        context: context,
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
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: GetBuilder<AddressBookController>(
                              init: AddressBookController(),
                              builder: (_) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Select Address',
                                    style:textStyleTheme.smallC14B
                                    ),
                                    SizedBox(height: 10,),
                                    controller.getAddressList.isEmpty? Column(
                                      children: [
                                        SizedBox(height: 60,),
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Card(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 80,),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text('No Address To Select Please Add Address',
                                                          textAlign: TextAlign.center,
                                                          style:
                                                          textStyleTheme.smallCB
                                                         ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 40,),
                                                  addNewAddressButton(),
                                                  SizedBox(height: 40,),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              top: -80,
                                              child: SizedBox(
                                                  height: 150,
                                                  child: Image(image: AssetImage('assets/addAddress.png'),)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ):Column(
                                      children: [
                                        Column(
                                          children: List.generate(controller.getAddressList.length, (index) {
                                            return   Card(
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  primary: Colors.green,
                                                  padding: EdgeInsets.all(0)
                                                  
                                                ),
                                                onPressed: (){
                                                  onPressedOnAddress(controller.getAddressList[index]);
                                                },
                                                child: Padding(
                                                  padding: widget.showAddress==true ?  EdgeInsets.all(15): EdgeInsets.symmetric(horizontal: 6,vertical: 14),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            deliveryAddress(index),
                                                            fieldWidget(
                                                              'Name',
                                                                controller.getAddressList[index]['name'].toString()
                                                            ),
                                                            fieldWidget(
                                                                'Complete Address',
                                                                (
                                                                    controller.getAddressList[index]['city'].toString()+' '+
                                                                        controller.getAddressList[index]['state'].toString()+' '+
                                                                        controller.getAddressList[index]['country'].toString()+' '+
                                                                        controller.getAddressList[index]['pincode'].toString()
                                                                )
                                                            ),
                                                            fieldWidget(
                                                                'Address Line 1',
                                                                controller.getAddressList[index]['addressLineOne'].toString()
                                                            ),
                                                            fieldWidget(
                                                                controller.getAddressList[index]['addressLineTwo']==""? '':'Address Line 2',
                                                                controller.getAddressList[index]['addressLineTwo'].toString()
                                                            ),
                                                            fieldWidget(
                                                                'Landmark',
                                                                controller.getAddressList[index]['landmark'].toString()
                                                            ),


                                                          ],
                                                        ),
                                                      ),
                                                      popUpMenu(controller.getAddressList[index],controller.getAddressList[index]['id'],context),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        addNewAddressButton(),
                                      ],
                                    ),

                                    SizedBox(height: 40,),
                                  ],
                                );
                              }
                            ),
                          ),
                        ])),
                  ],
                ),
              ),
              proceedToPay()
            ],
          ),
        ),
      ),
    );
  }

  deliveryAddress(index){
    return widget.showAddress?
    Visibility(
      visible: (controller.getAddressList[index]['id']==controller.getSelectedAddressId),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    color: AppColor.lightThemeColor,
                    borderRadius: BorderRadius.circular(20),

                ),
              ),
              SizedBox(width: 5,),
              Text('Delivery Address',
                style:textStyleTheme.smallO12B

              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    ):SizedBox();
  }

  fieldWidget(title,val){
    return title==''? SizedBox(): Padding(
      padding: const EdgeInsets.fromLTRB(15,0,0,5,),
      child:Wrap(
        children: [
          Text(title.toString()+': ',
          style: textStyleTheme.smallC12
    ),
          Text(val,
          style:textStyleTheme.smallL12
          ),
          SizedBox(height: 5,),
        ],
      ),
    );
  }


  addressType(type){
    return type==1? 'Home':
        type==2? 'Office':
            'Work';
  }


  popUpMenu(map,id,context){
    return  SizedBox(
      height: 15,
      child: PopupMenuButton(
      // /  offset: Offset(150,180),
        color: Colors.white,
        padding: EdgeInsets.all(0),
        icon: SizedBox(
            child: Image(image: AssetImage('assets/threedot.png'),height: 80,width: 80, color: Colors.grey[900],)),
        onSelected: (val){
          switch(val)
          {
            case 0:
              onPressedEditAddress(map,context);
            break;
            case 1:
              onPressedDelete(id,context);
            break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          PopupMenuItem(
            height: 40,
            value: 0,
            child: Row(
              children: [
                Icon(Icons.edit,
                size: 18,
                    color: AppColor.customBlack,),
                SizedBox(width: 5,),
                Text('Edit',
                  style:textStyleTheme.smallC14B
          ),
              ],
            ),
          ),
          PopupMenuItem(
            height: 40,
            value: 1,
            child: Row(
              children: [
                Icon(Icons.delete,
                  size: 18,
                  color: AppColor.customBlack,),
                SizedBox(width: 5,),
                Text('Delete',
                  style:textStyleTheme.smallC14B
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  addNewAddressButton(){
    return   TextButton(

        style: TextButton.styleFrom(
          primary: Colors.grey
        ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add,
              color: AppColor.orangeColor
          ),
          Text('Add Address',
            style:textStyleTheme.smallOB
            ),
        ],
      ),
      onPressed: (){
        onPressedAddAddress();
      },
    );
  }


  proceedToPay() {
    return  widget.showAddress==true ? Visibility(
      visible: controller.getAddressList.map((item) {
        return item['id'];
      }).toList().contains(controller.getSelectedAddressId),
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
                  style: textStyleTheme.smallCB
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: AppColor.lightThemeColor,
                ),
                child: Text(
                  'Proceed To Pay',
                  style:textStyleTheme.mediumW
                ),
                onPressed: () {
                  onPressProceedToPay();


                },
              ),
            ),
          ],
        ),
      ),
    ):SizedBox();
  }




}
