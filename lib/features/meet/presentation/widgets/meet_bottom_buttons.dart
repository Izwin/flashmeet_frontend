import 'package:flash_meet_frontend/core/router/app_router.dart';
import 'package:flash_meet_frontend/core/ui/default_button.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_bloc.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_state.dart';
import 'package:flash_meet_frontend/features/chat/presentation/page/chat_page.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_bloc.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_event.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MeetBottomButtons extends StatelessWidget {
  const MeetBottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetBloc, MeetState>(
      builder: (context, meetState) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (!(meetState.meetEntity?.attendees
                    .any((e) => e.id == state.userEntity?.id) ??
                false)) {
              return DefaultButton(
                text: 'Join',
                onPressed: (){
                  context.read<MeetBloc>().add(JoinMeetEvent());
                },
              );
            }
            if(meetState.meetEntity?.admin.id == state.userEntity?.id){
              return Row(
                children: [
                  Expanded(child: DefaultButton(
                    text: 'Chat',
                    onPressed: (){
                      context.push(ChatPage.route(meetState.meetEntity?.id ?? ''));
                    },
                  )),
                  if(!(meetState.meetEntity?.isFinished ?? true))Row(
                    children: [
                      SizedBox(width: 10,),
                      IconButton(onPressed: (){
                        context.read<MeetBloc>().add(CancelMeetEvent());
                      }, icon: Icon(CupertinoIcons.clear_circled),style: IconButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.surface,
                        backgroundColor: Theme.of(context).colorScheme.error
                      ),),
                    ],
                  ),
                ],
              );
            }
            return Row(
              children: [
                Expanded(child: DefaultButton(
                  text: 'Chat',
                  onPressed: (){
                    context.push(ChatPage.route(meetState.meetEntity?.id ?? ''));
                  },
                ),),
                if(!(meetState.meetEntity?.isFinished ?? true))
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      IconButton(onPressed: (){
                        context.read<MeetBloc>().add(LeaveMeetEvent());
                      }, icon: Icon(Icons.exit_to_app),style: IconButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.surface,
                        backgroundColor: Theme.of(context).colorScheme.error
                      ),),
                    ],
                  )
              ],
            );
            return Container();
          },
        );
      },
    );
  }
}
