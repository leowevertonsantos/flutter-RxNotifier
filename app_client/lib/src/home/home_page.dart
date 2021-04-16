import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = 'Name';
  String room = 'Flutter1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Flutterando RXNotifier '),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => room = value,
              decoration: InputDecoration(labelText: 'Room'),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) => name = value,
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/chat',
                    arguments: {
                      'name': name,
                      'room': room,
                    },
                  );
                },
                child: Text('Start Chat'))
          ],
        ),
      ),
    );
  }
}
