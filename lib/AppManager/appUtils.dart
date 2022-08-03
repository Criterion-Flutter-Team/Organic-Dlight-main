

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organic_delight/AppManager/AlertDialogue.dart';

import 'package:organic_delight/AppManager/userData.dart';




// Live URL
String baseUrl='https://theorganicdelight.com:86/api/Organic/';
String imageUrl='https://theorganicdelight.com/ProductImages/';
String fridgeImageUrl='https://theorganicdelight.com/FridgeProductImages/';

// Local URL
// String baseUrl='http://182.156.200.178:147/api/Organic/';
// String imageUrl='http://182.156.200.178:140/ProductImages/';
// String fridgeImageUrl='http://182.156.200.178:140/FridgeProductImages/';

String secretMapKey='AIzaSyB0AW2vBqSKJPqegh75EhUUxPljXPhaxqU';


UserData user=UserData();
Map cancelResponse={'status': 'error', 'detail': 'Try Again...'};

class App
{
  api(url,body,context,{
  token
  })
  async {
    try{
      print(baseUrl+url);
      print('body');
      print(body);
      var myToken;
      if(token!=null){
        myToken=  user.getUserToken;
      }
      print('ammmmmmmmmmmmm'.toString());
      print(token.toString());
      print(myToken.toString());

      var response = token==null?  await http.post(
          Uri.parse(baseUrl+url),
          body: body
      ):
      await http.post(
          Uri.parse(baseUrl+url),
          headers: {
            'Authorization': myToken
          },
          body: body
      );
      var data = json.decode(response.body);
      print(data);
      if(data is List){
        return data[0];
      }
      else{

        return data;
        // if((data['message']=='Invalid Token' || data['message']=='Unauthorised User' || data['message']=='Token expired') ){
        //   Navigator.popUntil(context, ModalRoute.withName('/DashboardView'));
        //   await user.removeUserData();
        //   alertToast(context, data['message']);
        // }
        // else{
        //   return data;
        // }
      }
    }
    on SocketException {
      print('No Internet connection');
      var retry=await apiDialogue(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
      );
      if(retry){
        var data= await api(url,body,context,
            token: token);
        return data;
      }
      else{
        return cancelResponse;
      }

    }
    on TimeoutException catch (e) {
      print('Time Out '+e.toString());
      var retry=await apiDialogue(context, 'Alert  !!!', 'Time Out, plz check your connection.',
      );
      if(retry){
        var data= await api(url,body,context,
            token: token,);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
    catch (e) {
      print('Error in Api: $e');
      var retry=await apiDialogue(context, 'Alert  !!!', 'Some Error Occur, plz check your connection.',
      );
      if(retry){
        var data= await api(url,body,context,
            token: token);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
  }



  navigate(context,route,{
  String? routeName
  }) async{
    var data=await Navigator.push(context, MaterialPageRoute(
        settings: routeName!=null? RouteSettings(name: routeName): null,
        builder: (BuildContext context)
    {
      return route;
    }));
    return data;
  }

  replaceNavigate(context,route,{
    String? routeName
  }) async{
    var data=await Navigator.pushReplacement(context, MaterialPageRoute(
        settings: routeName!=null? RouteSettings(name: routeName): null,
        builder: (BuildContext context)
        {
          return route;
        }));
    return data;
  }

  navigateTransparent(context,route) async{
    var data=await Navigator.push(context, PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return route;
      },
      transitionsBuilder: (context, a1, a2, widget) {
        return widget;
      },
      transitionDuration: Duration(milliseconds: 200),
    )
    );
    return data;
  }






// tabletOrAndroidView(widget)
// {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       isTablet?
//       SizedBox(
//         width: 600,
//         child:   widget,)
//           :
//       Expanded(
//         child:   widget,
//       ),
//     ],
//   );
// }
//
//
// tabletOrAndroidViewHeight(h)
// {
//   return isTablet? (h+(h/3)).toDouble():h.toDouble();
// }
//
// tabletOrAndroidViewTextSize(s)
// {
//   return  isTablet? (s*2).toDouble():s.toDouble();
// }




}


apiDialogue(context,alert,msg){
  var canPressOk=true;
  var retry=false;
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
                      return Future.value(false);
                    },
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.bottomCenter,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(0)),
                                    border: Border.all(
                                        color: Colors.red,
                                        width: 2
                                    )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(msg.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                ),),
                                            ),
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
                                                  retry=false;
                                                }
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(color: Colors.red,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),

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
                                                  retry=true;
                                                }
                                              },
                                              child: Text(
                                                'Retry',
                                                style: TextStyle(color: Colors.red,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
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
    return retry;
  });
}


















class DioData {

  Dio dio= new  Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,));


  api(url,body,context) async{
    dio.options.contentType= Headers.formUrlEncodedContentType;
    // var formData = FormData.fromMap({
    //   'userName': 'wendux',
    //   'age': 25,
    //   'file': await MultipartFile.fromFile('./text.txt',filename: 'upload.txt')
    // });
    try {
      print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'+url.toString());
      print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'+body.toString());
      var response = await dio.post(url,
          data: body,
          options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              }
              ),
              );
      print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'+response.toString());
    } catch (e) {
      print(e);
    }

  }
}