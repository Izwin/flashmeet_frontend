import 'package:dio/dio.dart';
import 'package:flash_meet_frontend/core/model/either.dart';
import 'package:flash_meet_frontend/core/model/failure.dart';
import 'package:flash_meet_frontend/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:flash_meet_frontend/features/chat/data/datasource/chat_socket_datasource.dart';
import 'package:flash_meet_frontend/features/chat/domain/entity/message_entity.dart';
import 'package:flash_meet_frontend/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatSocketDatasource chatSocketDatasource;
  final ChatRemoteDatasource chatRemoteDatasource;

  ChatRepositoryImpl(
      {required this.chatSocketDatasource, required this.chatRemoteDatasource});

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessage(
      {required String meetId, DateTime? lastMessageDate, int? limit}) async {
    try {
      return Right(await chatRemoteDatasource.getMessages(
          meetId: meetId, lastMessageDate: lastMessageDate, limit: limit));
    } on DioException catch (e) {
      return Left(ChatFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(ChatFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> joinChat(
      {required String meetId,
      required Function(MessageEntity message) onNewMessage,
      required Function(String error) onError}) async {
    try {
      await chatSocketDatasource.joinChat(
          meetId: meetId, onNewMessage: onNewMessage, onError: onError);
      return Right(null);
    } catch (e) {
      return Left(ChatFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(
      String meetingId, String message) async {
    try {
      return Right(chatSocketDatasource.sendMessage(meetingId, message));
    } catch (e) {
      return Left(ChatFailure(message: e.toString()));
    }
  }
}
