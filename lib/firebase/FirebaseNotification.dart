
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:organic_delight/AppManager/AlertDialogue.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
List notificationList=[];

class FireBaseService{


  connect(context) async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    var data=await _firebaseMessaging.getToken();
    print('User Token: '+data.toString());
    // await FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification!.title}');
        print('Message also contained a notification: ${message.notification!.body}');

        AlertDialogue().show(context, message.notification!.body);
      }
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message whilst in the open!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification!.title}');
        print('Message also contained a notification: ${message.notification!.body}');

        AlertDialogue().show(context, message.notification!.body);
      }
    }
    );

  }

  getToken() async{
    var data=await _firebaseMessaging.getToken();
    return data;
  }

}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   // await Firebase.initializeApp();
//   //
//   // print("Handling a background message: ${message.messageId}");
// }

