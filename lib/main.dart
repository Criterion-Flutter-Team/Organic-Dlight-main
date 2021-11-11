import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organic_delight/AppManager/MtTextTheme.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'Pages/Dashboard/Dashboard.dart';
import 'firebase/FirebaseNotification.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organic Delight',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(


        accentColor: AppColor.lightThemeColor,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  MyTextTheme textStyleTheme=MyTextTheme();
  App app=App();

  @override
  void dispose() {
    super.dispose();
  }

  @override





  void initState() {
    // TODO: implement initState
    super.initState();
     FireBaseService().connect(context);


    WidgetsFlutterBinding.ensureInitialized();

    print(
        "                  \n"
            "         _______  \n"
            "       /   __   | \n"
            "      /  /   |  | \n"
            "     /  /____|  | \n"
            "    /  /_____|  | \n"
            "   /  /      |  | \n"
            "  /__/       |__| \n"
            "                       \n"
            "   ________    ______  \n"
            "  |   __   |  /  /|  | \n"
            "  |  |  |  | /  / |  | \n"
            "  |  |  |  |/  /  |  | \n"
            "  |  |  |__/__/   |  | \n"
            "  |  |            |  | \n"
            "  |__|            |__| \n"
            "                 \n"
            "         (())  \n"
            "          __   \n"
            "         |  |  \n"
            "         |  |  \n"
            "         |  |  \n"
            "         |  |  \n"
            "         |  |  \n"
            "         |__|  \n"
            "                    \n"
            "   _____________    \n"
            "  |  | _______  |   \n"
            "  |  | ______|__|   \n"
            "  |  | |  |         \n"
            "  |  |   |  |       \n"
            "  |  |     |  |     \n"
            "  |__|       |__|   \n"
    );
    print(
        "                                        (())                    \n"
            "         _______   ________    ______    __    _____________    \n"
            "       /   __   | |   __   |  /  /|  |  |  |  |  | _______  |   \n"
            "      /  /   |  | |  |  |  | /  / |  |  |  |  |  | ______|__|   \n"
            "     /  /____|  | |  |  |  |/  /  |  |  |  |  |  | |  |         \n"
            "    /  /_____|  | |  |  |__/__/   |  |  |  |  |  |   |  |       \n"
            "   /  /      |  | |  |            |  |  |  |  |  |     |  |     \n"
            "  /__/       |__| |__|            |__|  |__|  |__|       |__|   \n"
    );
    get();
  }

  get() async{
    pageRoute();
  }



  var user;

  pageRoute() async{

        Timer(
            Duration(seconds: 3),
                () =>
                toDashboard()
        );

  }

  toDashboard(){
    app.replaceNavigate(context, Dashboard(),routeName: '/DashboardView');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightThemeColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(217, 217, 217, 1),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 30,
                    child: Image(image: AssetImage('assets/logo.png'),)),
                SizedBox(height: 10,),
                Center(
                  child: JumpingText(
                    'Loading...',
                    style: textStyleTheme.smallLB

                  ),
                ),
                SizedBox(height: 60,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
