import 'package:flash_meet_frontend/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flash_meet_frontend/features/chat/presentation/bloc/chat_event.dart';
import 'package:flash_meet_frontend/features/chat/presentation/bloc/chat_state.dart';
import 'package:flash_meet_frontend/features/chat/presentation/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatListWidget extends StatefulWidget {
  final String meetId;

  const ChatListWidget({super.key, required this.meetId});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(GetMessagesEvent(meetId: widget.meetId));
    scrollController.addListener((){
      if(scrollController.position.atEdge && scrollController.position.pixels!=0){
        context.read<ChatBloc>().add(GetMessagesEvent(meetId: widget.meetId));
      }
    });
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      builder: (context, state) {
        if((state.messages?.isEmpty ?? false) && state.status!=ChatStatus.loading ){
          return Center(
            child: Text('No messages'),
          );
        }
        return Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              borderRadius: BorderRadius.circular(12)),
          child: ListView.separated(
            controller: scrollController,
            itemBuilder: (context, index) {
              final message = state.messages![index];
              final messageDate = DateFormat.yMMMd().format(message.createdAt);

              final bool showDate = index == 0 ||
                  DateFormat.yMMMd()
                          .format(state.messages![index - 1].createdAt) !=
                      messageDate;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showDate)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(child: Text(messageDate)),
                    ),
                  MessageWidget(messageEntity: message)
                ],
              );
            },
            separatorBuilder: (context,index){
              return SizedBox(height: 10,);
            },
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            itemCount: state.messages?.length ?? 0,
          ),
        );
      },
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300), curve: Curves.easeOut);
        });
      },
    );
  }
}
