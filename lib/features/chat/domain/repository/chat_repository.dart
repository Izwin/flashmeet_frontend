import 'package:flash_meet_frontend/core/model/either.dart';
import 'package:flash_meet_frontend/core/model/failure.dart';
import 'package:flash_meet_frontend/features/chat/domain/entity/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> joinChat({required String meetId,
    required Function(MessageEntity message) onNewMessage,
    required Function(String error) onError});

  Future<Either<Failure, void>> sendMessage(String meetingId, String message);

  Future<Either<Failure, List<MessageEntity>>> getMessage(
      {required String meetId, DateTime? lastMessageDate, int? limit});
}
