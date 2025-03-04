import 'dart:async';

import 'package:flash_meet_frontend/features/chat/domain/entity/message_entity.dart';
import 'package:flash_meet_frontend/features/chat/domain/repository/chat_repository.dart';
import 'package:flash_meet_frontend/features/chat/presentation/bloc/chat_event.dart';
import 'package:flash_meet_frontend/features/chat/presentation/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc({required this.chatRepository}) : super(ChatState.initial()) {
    on<JoinChatEvent>(onJoinChatEvent);
    on<SendMessageEvent>(onSendMessageEvent);
    on<GetMessagesEvent>(onGetMessagesEvent);
  }

  Future onJoinChatEvent(JoinChatEvent event, Emitter<ChatState> _) async {
    emit(state.copyWith(status: ChatStatus.loading));

    var result = await chatRepository.joinChat(
        meetId: event.meetingId,
        onNewMessage: (MessageEntity message) {
          emit(state.copyWith(
              status: ChatStatus.newMessage,
              messages: [...(state.messages ?? []),message]));
        },
        onError: (String error) {
          emit(state.copyWith(status: ChatStatus.error, errorMessage: error));
        });
    result.fold((l) {
      emit(state.copyWith(status: ChatStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(status: ChatStatus.success));
    });
  }

  Future onSendMessageEvent(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(status: ChatStatus.loading));

    var result = await chatRepository.sendMessage(event.meetingId, event.text);
    result.fold((l) {
      emit(state.copyWith(status: ChatStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(status: ChatStatus.success));
    });
  }

  Future onGetMessagesEvent(
      GetMessagesEvent event, Emitter<ChatState> emit) async {
    if (state.isLastPage) return;
    emit(state.copyWith(status: ChatStatus.loading));

    var result = await chatRepository.getMessage(
        meetId: event.meetId,
        lastMessageDate: state.messages?.first.createdAt,
        limit: 12);

    result.fold((l) {
      emit(state.copyWith(status: ChatStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(
          status: ChatStatus.success,
          messages: [...r.reversed,...(state.messages ?? [])],
          isLastPage: r.length < 12));
    });
  }
}
