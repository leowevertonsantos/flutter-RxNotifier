import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatController {
  final String room;
  final String name;
  final textController = TextEditingController();
  final focusNodeMessage = FocusNode();

  Socket socket;
  final events = RxList<SocketEvent>([]);

  ChatController({this.room, this.name}) {
    this.init();
  }

  void init() {
    focusNodeMessage.requestFocus();

    socket = io(
      'https://dart-server-ls.herokuapp.com',
      OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.connect();

    socket.onConnect((data) {
      socket.emit('enter_room', {
        'room': room,
        'name': name,
      });
    });

    socket.on('message', (data) {
      SocketEvent event = SocketEvent.fromJson(data);
      events.add(event);
    });
  }

  void send() {
    final event = SocketEvent(
      name: name,
      room: room,
      type: SocketEventType.message,
      text: this.textController.text,
    );

    this.socket.emit('message', event);
    this.events.add(event);

    textController.clear();
    focusNodeMessage.requestFocus();
  }

  void dispose() {
    socket.clearListeners();
    socket.dispose();
    events.dispose();
    textController.dispose();
    focusNodeMessage.dispose();
  }
}
