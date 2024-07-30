import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationSarvice{
  var database = FirebaseDatabase.instance;
  getNotificationToken()async{
    FirebaseMessaging getTokens = FirebaseMessaging.instance;
    var get = await getTokens.getToken();
    print(get);
  }
}