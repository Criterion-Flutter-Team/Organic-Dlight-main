
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';



class UserData extends GetxController {
  final userData = GetStorage();

  String get getGuestId => (getUserData.isEmpty? userData.read('guestId'): '') ?? '';

  String get getUserToken => userData.read('userToken') ?? '';
  Map get getUserData => userData.read('userData') ?? {};
  String get getName => getUserData.isNotEmpty ? getUserData['name'].toString():'Shopper';
  String get getUserId => getUserData.isNotEmpty ? getUserData['userId'].toString():'';
  String get getUserName => getUserData.isNotEmpty ? getUserData['userName'].toString():'';
  String get getUserEmail => getUserData.isNotEmpty ? getUserData['email'].toString():'';
  String get getUserContact => getUserData.isNotEmpty ? getUserData['userName'].toString():'Guest Login';


  addGuestId(String val) {
    userData.write('guestId', val);
  }

  addToken(String val) {
    userData.write('userToken', val);
  }

  removeUserToken() async {
    await userData.remove('userToken');
  }

  removeGuestId() async{
    await userData.remove('guestId');
  }

  addUserData(Map val) async {
    await userData.write('userData', val);
  }

  removeUserId() async{
    await userData.remove('userId');
  }

  removeUserData() async{
    await userData.remove('userData');
  }

}



