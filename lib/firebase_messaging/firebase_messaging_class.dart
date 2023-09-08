import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gojek_university_app/commons/common_imports/apis_commons.dart';
import 'package:gojek_university_app/firebase_messaging/constants/constants.dart';
import 'package:gojek_university_app/firebase_messaging/firebase_message_model.dart';
import 'package:http/http.dart' as http;
import '../commons/common_imports/common_libs.dart';

class MessagingFirebase {
  FirebaseAuth auth= FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseMessaging _firebaseMessaging=FirebaseMessaging.instance;
  List<String> ids = [];
  
  Future<bool> uploadFcmToken() async{
    try{
      String? token = await _firebaseMessaging.getToken();
      await store.collection('register_id').doc(token).set(MessageModel(register_id: token).toJson());
      return true;
    }catch(e){
      return false;
    }
  }

  Future<String> token() async {
    return await _firebaseMessaging.getToken() ?? "";
  }


  Future<bool> pushNotificationsAllDevice({
    required String title,
    required String body,
    required List<String> registerIds,
  }) async {
    List<String> tempLst = [];
    for (var element in registerIds) {
      print(' "$element" ');
      tempLst.add(' "$element" ');
    }

    try{
      String dataNotifications = '{'
          '"operation": "create",'
          '"notification_key_name": "appUser-testUser",'
          '"registration_ids": $tempLst,'
          '"notification" : {'
          '"title":"$title",'
          '"body":"$body"'
          ' },'
          '}';


      var response = await http.post(
        Uri.parse(Constants.BASE_URL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key= ${Constants.KEY_SERVER}',
          'project_id': "${Constants.SENDER_ID}"
        },
        body: dataNotifications,
      );
      if(response.body.toString() == '"registration_ids" field cannot be empty'){
        return false;
      }else{
        debugPrint(response.body.toString());
        return true;
      }

    }catch(e){
      debugPrint(e.toString());
      return false;
    }


    return true;
  }

  getRegisterIds()async{
    try{
      QuerySnapshot<Map<String, dynamic>> listOfData = await store.collection('register_id').get();
      for(int i = 0; i < listOfData.docs.length; i++){
        listOfData.docs[i].data()['register_id'];
        ids.add(listOfData.docs[i].data()['register_id'].toString());
      }

    }catch(e){
      debugPrint(e.toString());
    }
  }

}