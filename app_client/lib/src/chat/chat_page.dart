import 'package:app_client/src/chat/chat_controller.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ChatPage extends StatefulWidget {
  final String room;
  final String name;

  const ChatPage({
    Key key,
    @required this.room,
    @required this.name,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatController controller;

  @override
  void initState() {
    super.initState();
    controller = ChatController(name: widget.name, room: widget.room);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room: ${widget.room}'),
      ),
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            RxBuilder(
              builder: (context) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.events.length,
                    itemBuilder: (context, index) {
                      var event = controller.events[index];
                      if (event.type == SocketEventType.enter_room) {
                        return ListTile(
                          title: Text(
                            '${controller.events[index].name} Entrou na sala',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        );
                      } else if (event.type == SocketEventType.leave_room) {
                        return ListTile(
                          title: Text(
                            '${controller.events[index].name} Saiu na sala',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                        );
                      }

                      return ListTile(
                        title: Text('${controller.events[index].name}'),
                        subtitle: Text('${controller.events[index].text}'),
                      );
                    },
                  ),
                );
              },
            ),
            Container(
              // padding: EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: controller.textController,
                focusNode: controller.focusNodeMessage,
                onSubmitted: (_) => controller.send(),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(35),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: controller.send,
                    ),
                    hintText: 'Type your text',
                    border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
