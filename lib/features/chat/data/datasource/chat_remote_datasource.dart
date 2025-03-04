import 'package:dio/dio.dart';
import 'package:flash_meet_frontend/features/chat/domain/entity/message_entity.dart';

class ChatRemoteDatasource {
  final Dio dio;

  ChatRemoteDatasource({required this.dio});

  Future<List<MessageEntity>> getMessages(
      {required String meetId, DateTime? lastMessageDate, int? limit}) async {
    var result = await dio.get('/messages/$meetId/messages', queryParameters: {
      'lastMessageDate': lastMessageDate?.toIso8601String(),
      'limit': limit
    });
    return (result.data['messages'] as List)
        .map((e) => MessageEntity.fromJson(e))
        .toList();
  }
}
