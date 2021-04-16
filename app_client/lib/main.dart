import 'package:app_client/src/chat/chat_page.dart';
import 'package:app_client/src/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter RxNotifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => HomePage(),
        '/chat': (ctx) {
          final args = ModalRoute.of(ctx).settings.arguments as Map;
          return ChatPage(room: args['room'], name: args['name']);
        },
      },
    );
  }
}
