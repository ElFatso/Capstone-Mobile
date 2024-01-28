// ignore_for_file: library_prefixes

import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessagingService {
  late IO.Socket socket;

  void initializeSocket() {
    socket = IO.io(ApiConstants.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      log('Connected to server');
    });

    socket.onDisconnect((_) {
      log('Disconnected from server');
    });
  }

  void joinRoom(String senderUUID, String receiverUUID) {
    socket.emit('join_room', {
      'senderUUID': senderUUID,
      'receiverUUID': receiverUUID,
    });
    log('Joined room');
  }

  void sendMessage(String senderUUID, String receiverUUID, String message) {
    socket.emit('send_message', {
      'senderUUID': senderUUID,
      'receiverUUID': receiverUUID,
      'message': message,
      'createdAt': DateTime.now().toIso8601String(),
    });
    log('Sent message');
  }

  void receiveMessage(Function(dynamic) callback) {
    socket.on('receive_message', (data) {
      if (data['createdAt'] == null) {
        data['createdAt'] =
            DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS").format(DateTime.now());
      }
      callback(data);
      log('Received message: $data');
    });
  }

  void dispose() {
    socket.dispose();
  }
}
