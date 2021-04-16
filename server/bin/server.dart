import 'dart:io';

import 'package:common/common.dart';
import 'package:socket_io/socket_io.dart';

void main(List<String> arguments) {
  final server = Server();

  server.on('connection', (client) {
    onConnection(client);
  });

  server.listen(Platform.environment['PORT'] ?? 3000);
}

void onConnection(Socket socket) {
  socket.on('enter_room', (data) {
    final name = data['name'];
    final room = data['room'];

    // conecta o client do socket um socket para classe informada.
    socket.join(room);
    socket.to(room).broadcast.emit(
          'message',
          SocketEvent(
            name: name,
            room: room,
            type: SocketEventType.enter_room,
          ),
        ); // emit para a conexão especifica ( room ) o evento informado, menos para si mesmo.

    socket.on('disconnect', (data) {
      socket.to(room).broadcast.emit(
            'message',
            SocketEvent(
              name: name,
              room: room,
              type: SocketEventType.leave_room,
            ),
          );
    });

    socket.on('message', (json) {
      socket.to(room).broadcast.emit(
            'message',
            json,
          );
    });
  });
}
