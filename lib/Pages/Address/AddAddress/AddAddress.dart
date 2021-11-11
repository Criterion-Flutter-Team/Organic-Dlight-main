import 'dart:async';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/widgets/textFeild.dart';
import 'package:organic_delight/Pages/Address/AddAddress/AddAddressModal.dart';
import 'package:organic_delight/Pages/Address/AddAddress/MapAddressModal.dart';
import 'package:organic_delight/Pages/Address/AddAddress/MapModal.dart';

import 'LocationModal.dart';



class AddAddress extends StatefulWidget {

  final Map? editAddress;

  const AddAddress({Key? key,  this.editAddress,}) : super(key: key);
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {




  App app= App();
  MyTextTheme textStyleTheme=MyTextTheme();

  var id;

  LocationModal locationModal=LocationModal() ;
  MapModal mapModal=MapModal();

  AddAddressModal addressmodal=AddAddressModal();
  MapAddressModal modal=MapAddressModal();
  var startValidation=false;
  final _formKey = GlobalKey<FormState>();
  LatLng _currentLocation=LatLng(26.850000,80.949997);
  TextEditingController nameC=TextEditingController();
  TextEditingController addressC=TextEditingController();
  TextEditingController address2C=TextEditingController();
  TextEditingController landmarkC=TextEditingController();
  TextEditingController pincodeC=TextEditingController();
  // TextEditingController cityIdC=TextEditingController();
  // TextEditingController stateIdC=TextEditingController();
  // TextEditingController countryIdC=TextEditingController();
  TextEditingController contactC=TextEditingController();
  TextEditingController emailC=TextEditingController();



  Completer<GoogleMapController> _controller = Completer();

  TextEditingController _searchC=TextEditingController();


  List<AutocompletePrediction> predictions = [];

  bool showList=false;
  late GooglePlace googlePlace;
  final Set<Marker> _markers = {};
  List countries=[];
  List stateData=[];
  List cityData=[];

  var selectedCountry;
  var  selectedState;
  var  selectedCity;



  var initialCountry;
  var initialState;
  var initialCity;


  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted){
      setState(() {
        predictions = result.predictions!;
      } );
    }
  }



  @override
  void initState() {
    super.initState();
    get();
  }



  get() async{

    googlePlace = GooglePlace(secretMapKey);
  // await getAllCountries();

    print(selectedCountry);

    if(widget.editAddress==null)

    {
      await getCurrentLocation();
    }
    else{
      print(widget.editAddress!);
      nameC.text=widget.editAddress!['name'].toString();
      addressC.text=widget.editAddress!['addressLineOne'].toString();
      address2C.text=widget.editAddress!['addressLineTwo'].toString();
      landmarkC.text=widget.editAddress!['landmark'].toString();
      pincodeC.text=widget.editAddress!['pincode'].toString();
      // cityIdC.text=widget.editAddress!['cityId'].toString();
      // stateIdC.text=widget.editAddress!['stateId'].toString();
      // countryIdC.text=widget.editAddress!['countryId'].toString();
      contactC.text=widget.editAddress!['contact'].toString();
      emailC.text=widget.editAddress!['email'].toString();
      _searchC.clear();
      id=widget.editAddress!['id'].toString();

      // _searchC.text=widget.editAddress!['MapAddress'].toString();
      selectedType=widget.editAddress!['addressType'].toString();
      double lat= double.parse(widget.editAddress!['latitude'].toString());
      double lang= double.parse(widget.editAddress!['longitude'].toString());
      _currentLocation=LatLng(lat, lang);
      initialCountry=[
       {
         'id': widget.editAddress!['countryId'],
         'param': 'id'
       }
      ];
      selectedCountry=widget.editAddress!['countryId'];
      await getAlStates(selectedCountry);
      initialState=[
        {
          'id': widget.editAddress!['stateId'],
          'param': 'id'
        }
      ];
      selectedState=widget.editAddress!['stateId'];
      await getAllCities(selectedState);
      initialCity=[
        {
          'id': widget.editAddress!['cityId'],
          'param': 'id'
        }
      ];
      selectedCity=widget.editAddress!['cityId'];

      print(_currentLocation.toString());
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(modal.cameraPosition(_currentLocation)));
      _onAddMarkerButtonPressed(_currentLocation);

      setState(() {
      });

    }
  }
  getAllCountries() async{
    countries.clear();
    stateData.clear();
    cityData.clear();
    setState(() {

    });
    countries=await addressmodal.getAllCountry(context,setState);

  }

  getAlStates(cId) async{
    stateData.clear();
    cityData.clear();
    setState(() {

    });
    stateData= await addressmodal.getAllState(context,setState,countryID:cId);


  }
  getAllCities(sId) async{
    cityData.clear();
    setState(() {

    });
    cityData=await addressmodal.getAllCity(context, setState,stateId:sId);
  }


  void _onAddMarkerButtonPressed(pos) async{
    _markers.clear();

    var marker=await modal.customMarker();


      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(pos.toString()),
        position: pos,
        // infoWindow: InfoWindow(
        //   title: 'Really cool place',
        //   snippet: '5 Star Rating',
        // ),
        icon:  marker,
        onTap: (){
          print('jjjjjjjjjjjjjjjjjj');
        }

      ));
     if(mounted){
       setState(() {

       });
     }
  }


  _onTapGoogleMap(pos) async{
    print(pos.toString());
    _currentLocation=pos;
    _onAddMarkerButtonPressed(pos);
    var address= await modal.addressFromCoordinates(pos);
    _searchC.text=address;

  }


  getCurrentLocation() async{
    var data=await modal.getCurrentLocation();
    _currentLocation=LatLng(data.latitude,data.longitude);
    var address= await modal.addressFromCoordinates(_currentLocation);
    _searchC.text=address;

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(modal.cameraPosition(_currentLocation)));
    _onAddMarkerButtonPressed(_currentLocation);
  }


  onPressedAddAddress() async{
    setState(() {
      startValidation=true;
    });
    // if(selectedCountry==null ){
    //
    // AlertDialogue().show(context, 'please select country.');
    //
    // }
    // else if(selectedState==null){
    //
    //   AlertDialogue().show(context, 'please select State.');
    // }
    // else if(selectedCity==null){
    //   AlertDialogue().show(context, 'please select City');
    // }
    if(false){

  }
    else{
      if(_formKey.currentState!.validate()){
        if(widget.editAddress==null){
          await addressmodal.addAddress(
            context: context,
            name: nameC.text,
            addressLineOne: addressC.text,
            addressLineTwo: address2C.text,
            landmark: landmarkC.text,
            pincode: pincodeC.text,
            cityId: selectedCity,
            latitudes: _currentLocation.latitude,
            longitude: _currentLocation.longitude,
            stateId: selectedState,
            countryId: selectedCountry,
            contact: contactC.text,
            addressType: selectedType,
            email: emailC.text,
          );

        }
        else{
          addressmodal.updateAddress(
            context,
            name: nameC.text,
            addressLineOne: addressC.text,
            addressLineTwo: address2C.text,
            landmark: landmarkC.text,
            pincode: pincodeC.text,
            cityId: selectedCity,
            latitudes: _currentLocation.latitude,
            longitude: _currentLocation.longitude,
            stateId: selectedState,
            countryId: selectedCountry,
            contact: contactC.text,
            addressType: selectedType,
            email: emailC.text,
            id:id,

          );

        }

      }
    }
  }

  onSelectAddress(index) async{
    showList=false;
    setState(() {

    });
    FocusScope.of(context).unfocus();
    _searchC.text=predictions[index].description.toString();
    nameC.text=predictions[index].description.toString();
    print(predictions[index].description.toString());
    _currentLocation= await modal.coordinatesFromAddress(predictions[index].description.toString());
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(modal.cameraPosition(_currentLocation)));
    _onAddMarkerButtonPressed(_currentLocation);
  }


  late BitmapDescriptor customIcon1;
  createMark() async{
    var data= await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/marker.png');
    return data;
  }







  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          body:  Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      markers: _markers,
                      initialCameraPosition: modal.cameraPosition(_currentLocation),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      onTap:  (pos) async{
                        _onTapGoogleMap(pos);


                      },
                    ),
                    Column(
                      children: [
                        upperButtons(),
                        searchedList(),
                      ],
                    ),
                  ],
                ),),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,15,15,15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            SizedBox(height: 10,),
                            Text('Complete Address',
                              style:textStyleTheme.smallC14B
                            ),
                            SizedBox(height: 20,),


                            TextFieldClass(
                              textInputAction: TextInputAction.next,
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
                              labelText: 'Name*',
                            ),


                            SizedBox(height: 10,),

                            TextFieldClass(

                              textInputAction: TextInputAction.next,
                              maxLine: 3,
                              controller: addressC,
                              validator: (value){
                                if(value!.length==0)
                                {
                                  return startValidation? 'Address Line 1 must not be empty.': null;
                                }
                                else{
                                  return null;
                                }
                              },
                              labelText: 'Address Line One*',
                              // hintText: 'Address Line One*',
                            ),
                            SizedBox(height: 10,),

                            TextFieldClass(

                              textInputAction: TextInputAction.next,
                              maxLine: 3,
                              controller: address2C,
                              labelText: 'Address Line Two',
                              // hintText: 'Address Line Two',
                            ),
                            SizedBox(height: 10,),
                            TextFieldClass(
                              textInputAction: TextInputAction.next,
                              maxLine: 2,
                              controller: landmarkC,
                              validator: (value){
                                if(value!.length==0)
                                {
                                  return startValidation? 'Landmark must not be empty.': null;
                                }
                                else{
                                  return null;
                                }
                              },
                              labelText: 'Landmark*',
                              // hintText: 'Landmark',
                            ),
                            SizedBox(height: 10,),
                            TextFieldClass(
                              textInputAction: TextInputAction.next,
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              controller: pincodeC,
                              validator: (value){
                                if(value!.length==0)
                                {
                                  return startValidation? 'Pincode must not be empty.': null;
                                }
                                else if(value.length<6){
                                  return startValidation? 'please enter Valid PinCode': null;
                                }
                                else{
                                  return null;
                                }
                              },
                              labelText: 'Pincode*',
                            ),
                            SizedBox(height: 10,),
                            // textField(
                            //   maxLine: 5,
                            //   controller: cityIdC,
                            //   validator: (value){
                            //     if(value!.length==0)
                            //     {
                            //       return startValidation? 'CityId must not be empty.': null;
                            //     }
                            //     else{
                            //       return null;
                            //     }
                            //   },
                            //   decoration: InputDecoration(
                            //       focusedBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(color: Colors.green)
                            //       ),
                            //       labelText: 'CityId*',
                            //       labelStyle: TextStyle(color: Colors.grey),
                            //       border: OutlineInputBorder(
                            //           borderSide: BorderSide(color: Colors.grey)
                            //       )
                            //
                            //   ),
                            //   // hintText: 'CityId',
                            // ),
                            // SizedBox(height: 10,),

                            //
                            // CustomSearchableDropDown(
                            //   height: 30,
                            //   items: countries,
                            //   label: 'Select Country',
                            //   initialValue: initialCountry,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       border: Border.all(color: Colors.grey)
                            //   ),
                            //   prefixIcon:  Padding(
                            //     padding: const EdgeInsets.all(0.0),
                            //
                            //   ),
                            //   dropDownMenuItems: countries.map((item) {
                            //     return item['name'];
                            //   }).toList(),
                            //   onChanged: (value) async{
                            //     if(value!=null)
                            //     {
                            //       selectedCountry = value['id'];
                            //       initialCountry=null;
                            //       initialState=null;
                            //       initialCity=null;
                            //       await getAlStates(selectedCountry);
                            //     }
                            //     else{
                            //
                            //       selectedCountry=null;
                            //       print('heeeello');
                            //     }
                            //   },
                            // ),
                            //
                            // SizedBox(height: 10,),
                            //
                            // CustomSearchableDropDown(
                            //   height: 30,
                            //   items: stateData,
                            //   label: 'Select State',
                            //   initialValue: initialState,
                            //   decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(5),
                            //     border: Border.all(color: Colors.grey)
                            //   ),
                            //   prefixIcon:  Padding(
                            //     padding: const EdgeInsets.all(0.0),
                            //   ),
                            //   dropDownMenuItems: stateData.map((item) {
                            //     return item['name'];
                            //   }).toList(),
                            //   onChanged: (value)  async {
                            //     if(value!=null)
                            //     {
                            //
                            //       selectedState = value['id'];
                            //       initialState=null;
                            //       initialCity=null;
                            //     await getAllCities(selectedState);
                            //     }
                            //     else{
                            //       selectedState=null;
                            //     }
                            //   },
                            // ),
                            // SizedBox(height: 10,),
                            //
                            // CustomSearchableDropDown(
                            //   height: 30,
                            //   items: cityData,
                            //   label:  'Select City',
                            //   initialValue: initialCity,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       border: Border.all(color: Colors.grey)
                            //   ),
                            //   prefixIcon:  Padding(
                            //     padding: const EdgeInsets.all(0.0),
                            //   ),
                            //   dropDownMenuItems: cityData.map((item) {
                            //     return item['name'];
                            //   }).toList(),
                            //   onChanged: (value){
                            //     if(value!=null)
                            //     {
                            //       selectedCity = value['id'];
                            //       initialCity=null;
                            //     }
                            //     else{
                            //       selectedCity=null;
                            //     }
                            //   },
                            // ),
                            SizedBox(height: 10,),
                          //   textField(
                          //     maxLine: 5,
                          //    controller: stateIdC,
                          //     validator: (value){
                          //       if(value!.length==0)
                          //       {
                          //         return startValidation? 'StateId must not be empty.': null;
                          //       }
                          //       else{
                          //         return null;
                          //       }
                          //     },
                          // decoration: InputDecoration(
                          //     focusedBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(color: Colors.green)
                          //     ),
                          //   labelText: 'StateId',
                          //   labelStyle: TextStyle(color: Colors.grey),
                          //   border: OutlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.grey)
                          //   )
                          // ),
                          //     // hintText: 'StateId',
                          //   ),
                          //   SizedBox(height: 10,),
                          //   textField(
                          //     maxLine: 5,
                          //     controller: countryIdC,
                          //     validator: (value){
                          //       if(value!.length==0)
                          //       {
                          //         return startValidation? 'CountryId must not be empty.': null;
                          //       }
                          //       else{
                          //         return null;
                          //       }
                          //     },
                          //     // hintText: 'CountryId',
                          //     decoration: InputDecoration(
                          //         focusedBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(color: Colors.green)
                          //         ),
                          //       labelText: 'CountryId',
                          //       labelStyle: TextStyle(color: Colors.grey),
                          //       border: OutlineInputBorder(
                          //         borderSide: BorderSide(color: Colors.grey)
                          //       )
                          //     ),
                          //   ),

                            // SizedBox(height: 10,),
                            TextFieldClass(
                              textInputAction: TextInputAction.next,
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                              maxLength: 10,
                              validator: (value){
                                if(value!.length==0)
                                {
                                  return startValidation? 'Mobile must not be empty.': null;
                                }
                                else if(value.length<10){
                                  return startValidation? 'please enter valid number': null;
                                }
                                else{
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              controller: contactC,
                              labelText: 'Mobile No*',
                              // hintText: 'Mobile No*',
                            ),
                            SizedBox(height: 10,),

                            TextFieldClass(
                              textInputAction: TextInputAction.done,
                              controller: emailC,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value){
                                String pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if(value!.length==0){
                                  return startValidation? 'Email must not be empty':null;
                                }
                                else if (!regex.hasMatch(value))
                                  return startValidation? 'Enter valid email':null;
                                else
                                  return null;
                              },
                              labelText: 'Email',
                              // hintText: 'Email',
                            ),


                            SizedBox(height: 10,),
                            typeOfAddress(),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                  child:TextButton(

                                    style: TextButton.styleFrom(
                                      primary: Colors.grey,
                                       padding: EdgeInsets.all(0),
                                      backgroundColor: AppColor.lightThemeColor,
                                    shape: AppWidgets.buttonShape,
                                                      ),
                                    onPressed: () {
                                      onPressedAddAddress();
                                    },
                                    child:  Text( widget.editAddress==null? 'Add Address':'Update Address',
                                        style: textStyleTheme.mediumW
                                        // TextStyle(
                                        //     color: AppColor.white
                                        // )
                                    ),
                                  ),

                                  // FlatButton(
                                  //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  //   padding: EdgeInsets.all(0),
                                  //   color: AppColor.lightThemeColor,
                                  //   shape: AppWidgets.buttonShape,
                                  //   child: Text( widget.editAddress==null? 'Add Address':'Update Address',
                                  //       style: TextStyle(
                                  //           color: AppColor.white
                                  //       )),
                                  //   onPressed: (){
                                  //     onPressedAddAddress();
                                  //
                                  //   },
                                  // ),



                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  upperButtons(){
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back,
            color: AppColor.customBlack,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        Expanded(child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Container(
              height: 40,
              color: Colors.white54,
              child: TextField(
                controller: _searchC,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5,0,5,0),
                  hintText: 'Search Address Here',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
                onTap: (){
                  showList=true;
                  setState(() {

                  });
                },
                onChanged: (value) {
                  showList=true;
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
            ),
            Row(
              children: [
                SizedBox(
                    height: 30,
                    child: Image(image: AssetImage('assets/marker.png'),)),
                SizedBox(width: 5,),
                Expanded(child: Text('Pin your location',
                style: textStyleTheme.smallC12B
                  ,)),
              ],
            )
          ],
        ),),

        IconButton(
          icon: Icon(Icons.location_searching,
            color: AppColor.lightThemeColor,
          size: 20,),
          onPressed: (){
             getCurrentLocation();
          },
        ),
      ],
    );
  }


  searchedList(){
    return Expanded(
      child: Visibility(
        visible: showList,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8,0,8,8),
          child: ListView.builder(
            itemCount: predictions.length,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white,
                child: ListTile(
                  title: Text(predictions[index].description.toString()),
                  onTap: () async{
                    onSelectAddress(index);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  typeOfAddress(){
    return     Wrap(
      children: List.generate(listOfTypes.length, (index) =>  Padding(
        padding: const EdgeInsets.fromLTRB(0,2,4,2),
        child: GestureDetector(
          onTap: (){
            setState(() {
              selectedType=listOfTypes[index];

            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: selectedType==listOfTypes[index]? AppColor.lightThemeColor:Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4),),
                border: Border.all(color: AppColor.lightThemeColor,
                    width: 2)
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,4,8,4),
              child: Text(listOfTypes[index],
                style: TextStyle(
                    color: selectedType==listOfTypes[index]? Colors.white:AppColor.lightThemeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                ),),
            ),
          ),
        ),
      ),),
    );
  }

  List listOfTypes=[
    'Home',
    'Work',
    'Office',
  ];
  var selectedType='Home';



}
