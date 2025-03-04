import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_meet_frontend/core/api/api_config.dart';
import 'package:flash_meet_frontend/features/chat/domain/entity/message_entity.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket;

class ChatSocketDatasource {
  socket.Socket? _socket;
  Timer? _reconnectTimer;
  bool _isReconnecting = false;

  Future joinChat(
      {required String meetId,
      required Function(MessageEntity message) onNewMessage,
      required Function(String error) onError}) async {
    await _disconnectSocket();
    await _initializeSocket(onNewMessage: onNewMessage, onError: onError);
    _socket?.connect();
    _socket?.emit('joinRoom', {'meetingId': meetId});
  }

  Future _disconnectSocket() async {
    try {
      _reconnectTimer?.cancel();
      _socket?.clearListeners();
      _socket?.disconnect();
    } catch (e) {
      log('Error disconnecting socket: $e');
    }
  }

  Future _initializeSocket(
      {required Function(MessageEntity message) onNewMessage,
      required Function(String error) onError}) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final socketOptions = socket.OptionBuilder()
        .setExtraHeaders({'Authorization': token})
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build();

    _socket = socket.io(ApiConfig.BASE_URL, socketOptions);

    _socket?.onConnect((v) {
      _isReconnecting = false;
      _reconnectTimer?.cancel();
    });

    _socket?.onDisconnect((v) {
      _attemptReconnect(onNewMessage: onNewMessage, onError: onError);
    });

    _socket?.onConnectError((error) {
      _attemptReconnect(onNewMessage: onNewMessage, onError: onError);
    });

    _socket?.on(
        'newMessage', (data) => onNewMessage(MessageEntity.fromJson(data)));

    _socket?.on('error', (data) {
      onError(data.toString());
    });
  }

  Future _attemptReconnect(
      {required Function(MessageEntity message) onNewMessage,
      required Function(String error) onError}) async {
    if (_isReconnecting) return;
    _isReconnecting = true;

    _reconnectTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        _socket?.connect();
        if (_socket?.connected == true) {
          timer.cancel();
          _isReconnecting = false;
        }
      } catch (e) {
        onError.call('Reconnection failed');
      }
    });
  }

  void sendMessage(String meetingId, String message) async {
    _socket?.emit('sendMessage', {
      'meetingId': meetingId,
      'text': message,
    });
  }
}
