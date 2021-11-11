
import 'package:organic_delight/AppManager/appUtils.dart';
import 'package:organic_delight/AppManager/userData.dart';

class DashboardModal {

  App app=App();
  UserData user=UserData();





  generateGuestId(context) async {

    if(user.getGuestId=='' || user.getUserData.isNotEmpty){

      var body = {};
      var data = await app.api('GenerateGuestId', body, context,token: true);
      if (data['responseCode'] == 1) {

       await user.addGuestId(data['responseValue'].toString());
      }
      else {

      }

      return data;
    }

  }



}