import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_shop/locator.dart';
import 'package:my_shop/screens/brands_Screen.dart';
import 'navigation_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PusNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String> intialise() async {
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.initialize(platform,
        onSelectNotification: (String payload) async {
      manageNotificationview(payload);
    });
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage $message');
        showNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch $message');
        _serializeAndNavigate(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume $message');
        _serializeAndNavigate(message);
      },
    );
    return await _fcm.getToken();
  }

  void _serializeAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];
    manageNotificationview(view);
  }

  void manageNotificationview(String view) {
    if (view != null) {
      if (view == 'Brands') {
        locator<NavigationService>().navigateTo(BrandsScreen.routName);
      }
    }
  }

  Future unsubscribe() async {
    await _fcm.deleteInstanceID();
  }

  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
      'sdffds dsffds',
      "CHANNLE NAME",
      "channelDescription",
    );
    var notification = msg['notification'];
    var notificationData = msg['data'];
    var view = notificationData['view'];
    print(msg);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, notification['title'], notification['body'], platform,
        payload: view);
  }
}
