

import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications{

	static FirebaseMessaging messaging = FirebaseMessaging.instance;
	static String? token; 
	static final StreamController<Map<String,dynamic>> _messageStream = StreamController.broadcast();
	static Stream<Map<String,dynamic>> get messageStream => _messageStream.stream;



	static Future initialize()async{
		token = await messaging.getToken(); // TODO: ALMACENAR EL TOKEN EN EL USUARIO, ATRIBUTO DEVICES
		print(token);
		FirebaseMessaging.onMessage.listen(_onUseHandler);
		FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
		FirebaseMessaging.onMessageOpenedApp.listen(_openedAppHandler);
		 
	}
	static Future _backgroundHandler(RemoteMessage message) async {
		_messageStream.add(message.data);
	}
	 
	static Future _onUseHandler(RemoteMessage message) async {
		_messageStream.add(message.data);
	}

	static Future _openedAppHandler(RemoteMessage message) async {
		print("_openedAppHandler ${message.messageId}");
		_messageStream.add(message.data);
	}

	static void closeStream(){
		_messageStream.close();
	}

}