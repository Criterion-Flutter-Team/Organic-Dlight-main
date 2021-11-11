// import 'dart:convert';
// import 'dart:io';
//
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:riqhub_merchant/AppManager/appWidgets.dart';
// import 'package:riqhub_merchant/AppManager/userData.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io' as Io;
//
// import 'appColors.dart';
// import 'appUtils.dart';
//
// class ProfileImage{
//
//   UserData user=UserData();
//
//   Future getImage() async{
//     final image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     var crop= await _cropImage(image.path);
//     return crop;
//   }
//   _cropImage(filePath) async {
//     File croppedImage = await ImageCropper.cropImage(
//       sourcePath: filePath,
//       maxWidth: 1080,
//       maxHeight: 1080,
//     );
//     return croppedImage;
//   }
//
//   Future getCameraImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);
//     var crop= await _cropImage(image.path);
//     return crop;
//   }
//
//
//   updateImage(context,profile) async{
//     var merId= await user.getUserMerchantId();
//     var body={
//       'merchant_id': merId.toString(),
//       'profile_pic': profile.toString(),
//     };
//     var data= await app.api('merchant_profile_change', body, context);
//     print(data);
//     if(data!=null)
//     {
//       if(data['status']=='success' )
//       {
//         changeProfileOnLocal(data['profile_pic']);
//       //  app.showDialogue(context, 'Alert  !!!', data['msg']);
//       }
//       else{
//       //  app.showDialogue(context, 'Alert  !!!', data['msg']);
//       }
//     }
//
//     return data;
//   }
//
//
//   changeProfileOnLocal(pic) async{
//     print(pic);
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var data= await prefs.getString('userData');
//     var dec=jsonDecode(data);
//     dec[0]['profile_pic']='profile/'+pic.toString();
//     print(dec);
//     prefs.setString('userData', jsonEncode(dec));
//   }
//
//
//   getPicInBase64(pics) async{
//     var str= await pics.path;
//     var converted= (base64.encode(await Io.File(str).readAsBytes()));
//     return converted;
//   }
//
//
//   getListOfPicsInBase64(pics) async{
//     var list=[];
//     for(int i=0; i<pics.length; i++)
//     {
//       if(pics[i]['file']!='')
//       {
//         // print('scuccess'+pics.length.toString()+pics[i]['file'].toString());
//         // var d= (base64.encode(await Io.File(pics[i]['file']).readAsBytes()));
//         // list.add({'image': d});
//
//
//         var d= (base64.encode(await Io.File(pics[i]['file']).readAsBytes()));
//         list.add(d);
//
//
//         // print('scuccess'+pics.length.toString()+pics[i]['file'].toString());
//         // if(i==(pics.length-1))
//         // {
//         //   var d= (base64.encode(await Io.File(pics[i]['file']).readAsBytes()));
//         //   list.add(d);
//         // }
//         // else{
//         //   var d= (base64.encode(await Io.File(pics[i]['file']).readAsBytes())+',');
//         //   list.add(d);
//         // }
//       }
//     }
//     print('pppppppppppppp'+list.length.toString()+' '+list.toString());
//     return list;
//   }
//
//
//   profileImageData(context,isUpdating,profileUrl) {
//     return  Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         isUpdating?
//         SizedBox(
//           height: 200,
//           width: 200,
//           child: PopupMenuButton(
//             offset: Offset(150,180),
//             color: AppColor.lightThemeColor,
//             icon: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 profileUrl!=null? SizedBox(
//                   height: 160,
//                   child: Image(
//                     image: NetworkImage(imageUrl+ profileUrl.toString()),
//                   ),
//                 ):Icon(Icons.person,
//                   color: AppColor.iconAndTextColor,
//                   size: app.tabletOrAndroidViewHeight(150),),
//                 Text('Change',
//                   style: TextStyle(
//                     color: AppColor.lightThemeColor,
//                     fontSize: app.15,
//                   ),)
//               ],
//             ),
//             onSelected: (val) async{
//               switch(val)
//               {
//                 case 1:
//                   var im=await getCameraImage();
//                   var con= await getPicInBase64(im);
//                   updateImage(context, con);
//                 break;
//                 case 2:
//                 var im=await getImage();
//                 var con= await getPicInBase64(im);
//                 updateImage(context, con);
//                 break;
//               }
//             },
//             itemBuilder: (BuildContext context) => <PopupMenuEntry>[
// //                                  const PopupMenuItem(
// //                                    value: 0,
// //                                    child: Text('View image',
// //                                      style: TextStyle(
// //                                          color: Colors.white
// //                                      ),),
// //                                  ),
//               const PopupMenuItem(
//                 value: 1,
//                 child: Text('Camera',
//                   style: TextStyle(
//                       color: Colors.white
//                   ),),
//               ),
//               const PopupMenuItem(
//                 value:  2,
//                 child: Text('Gallery',
//                   style: TextStyle(
//                       color: Colors.white
//                   ),),
//               ),
//             ],
//           ),
//         ):Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             profileUrl!=null? SizedBox(
//               height: 160,
//               child: Image(
//                 image: NetworkImage(imageUrl+(profileUrl??'') .toString()),
//               ),
//             ):Icon(Icons.person,
//               color: AppColor.iconAndTextColor,
//               size: app.tabletOrAndroidViewHeight(150),),
//           ],
//         ),
//       ],
//     );
//   }
//
// }