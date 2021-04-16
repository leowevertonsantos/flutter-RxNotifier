import 'dart:convert';

import 'package:common/common.dart';
import 'package:test/test.dart';

void main() {
  group('Commons instance classes Group', () {
    SocketEvent socketEvent;

    test('FROM Json TO Json', () {
      final jsonValue = {
        'name': 'Leo',
        'room': 'flutter_1',
        'text': '',
        'type': 'SocketEventType.enter_room',
      };

      socketEvent = SocketEvent.fromJson(json.encode(jsonValue));

      expect(socketEvent.name, 'Leo');
      expect(socketEvent.type, SocketEventType.enter_room);
      expect(socketEvent.toJson(), json.encode(jsonValue));
    });
  });
}
