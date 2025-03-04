import 'package:flash_meet_frontend/core/get_it/get_it.dart';
import 'package:flash_meet_frontend/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flash_meet_frontend/features/chat/presentation/bloc/chat_event.dart';
import 'package:flash_meet_frontend/features/chat/presentation/widgets/chat_list_widget.dart';
import 'package:flash_meet_frontend/features/chat/presentation/widgets/enter_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  final String meetId;

  const ChatPage({super.key, required this.meetId});

  static String route(String meetId) => '/chat/$meetId';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ChatBloc>()..add(JoinChatEvent(meetingId: meetId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chat',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: ChatListWidget(meetId: meetId),
            ),
            EnterMessageWidget(meetId: meetId)
          ],
        )),
      ),
    );
  }
}
