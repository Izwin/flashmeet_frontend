import 'package:equatable/equatable.dart';
import 'package:flash_meet_frontend/features/chat/domain/entity/message_entity.dart';

enum ChatStatus {
  initial,
  loading,
  success,
  newMessage,
  error,
}

class ChatState extends Equatable{
  final ChatStatus status;
  final String? errorMessage;
  final List<MessageEntity>? messages;
  final bool isLastPage;

  ChatState._(
      {required this.status,
      this.errorMessage,
      this.messages,
      this.isLastPage = false});

  factory ChatState.initial() => ChatState._(status: ChatStatus.initial);

  ChatState copyWith(
          {ChatStatus? status,
          String? errorMessage,
          List<MessageEntity>? messages,
          DateTime? lastMessageDate,
          bool? isLastPage}) =>
      ChatState._(
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage,
          messages: messages ?? this.messages,
          isLastPage: isLastPage ?? this.isLastPage);

  @override
  List<Object?> get props => [status,errorMessage,messages,isLastPage];
}
