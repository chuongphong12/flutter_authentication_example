import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    getPermission();
    messageListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('android firebase initiated');
          return const NotificationPage();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void messageListener(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification!.body}');
        showDialog(
            context: context,
            builder: ((BuildContext context) {
              return DynamicDialog(
                  title: message.notification!.title,
                  body: message.notification!.body);
            }));
      }
    });
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<NotificationPage> {
  late String _token;
  late Stream<String> _tokenStream;
  int notificationCount = 0;

  final Dio dio = Dio();

  void setToken(String token) {
    print('FCM TokenToken: $token');
    setState(() {
      _token = token;
    });
  }

  @override
  void initState() {
    super.initState();
    //get token
    FirebaseMessaging.instance.getToken().then(
          ((value) => setToken(value!)),
        );
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase push notification'),
        ),
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(10),
            elevation: 10,
            child: ListTile(
              title: Center(
                child: OutlinedButton.icon(
                  label: const Text('Push Notification',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  onPressed: () {
                    sendPushMessageToWeb();
                  },
                  icon: const Icon(Icons.notifications),
                ),
              ),
            ),
          ),
        ));
  }

  //send notification
  sendPushMessageToWeb() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }
    try {
      await dio
          .request(
            'https://fcm.googleapis.com/v1/projects/flutter-authentication-93518/messages:send',
            options: Options(method: 'POST', headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Bearer ya29.a0ARrdaM8WUPpTApgJxDOEzrVZelqgW1zmXsXEECay7NOb6zL94HYSUA9AKFmZuzk9Kd9Qo0gqeHXgVlpZaVMZF92oIo_UFp5oKPPORduwqSDc4wYEdTHBcA-eQHzvBnbsrsR7L8QQKMrDQjEQ-IS3Wf4RggHj'
            }),
            data: json.encode({
              "message": {
                "token": _token,
                "notification": {
                  "title": "Breaking News",
                  "body": "New news story available."
                },
              }
            }),
          )
          .then((value) => print(value.data));
      print('FCM request for web sent!');
    } catch (e) {
      print(e);
    }
  }
}

//push notification dialog for foreground
class DynamicDialog extends StatefulWidget {
  final title;
  final body;
  const DynamicDialog({
    Key? key,
    this.title,
    this.body,
  }) : super(key: key);

  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<DynamicDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      actions: <Widget>[
        OutlinedButton.icon(
            label: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ],
      content: Text(widget.body),
    );
  }
}
