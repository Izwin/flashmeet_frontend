import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_meet_frontend/core/router/app_router.dart';
import 'package:flash_meet_frontend/features/auth/domain/entity/user_entity.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_bloc.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_state.dart';
import 'package:flash_meet_frontend/features/meet/domain/entity/meet_entity.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_bloc.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_event.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_state.dart';
import 'package:flash_meet_frontend/features/profile/presentation/widgets/circle_user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AttendeeWidget extends StatelessWidget {
  final UserEntity attendee;

  const AttendeeWidget({super.key, required this.attendee});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
  builder: (context, userState) {
    return BlocBuilder<MeetBloc, MeetState>(
  builder: (context, state) {
    return Container(
      child: Row(
        children: [
          CircleUserAvatar(
            width: 40,
            height: 40,
              url: attendee.avatar,
          ),
          SizedBox(
            width: 15,
          ),
          Text(attendee.name,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),),
          Spacer(),
          _buildIcon(context, state.meetEntity, attendee, userState.userEntity)
          
        ],
      ),
    );
  },
);
  },
);
  }
  
  Widget _buildIcon(BuildContext context, MeetEntity? meetEntity, UserEntity attendee, UserEntity? user){
    if(meetEntity?.admin.id == attendee.id){
      return IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.star_fill,color: Theme.of(context).colorScheme.primary,));
    }
    if(meetEntity?.admin.id == user?.id){
      return IconButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (_){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.person,color: Theme.of(context).colorScheme.onSurface,),
                  title: Text('View Profile'),
                  onTap: () {
                    context.pop();
                    showDialog(context: context, builder: (context){
                      return Center(child: CachedNetworkImage(imageUrl: attendee.avatar));
                    },barrierDismissible: true);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.star,color: Theme.of(context).colorScheme.primary,),
                  title: Text('Make Admin', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary
                  ),),
                  onTap: (){
                    context.read<MeetBloc>().add(TransferAdminEvent(userId: attendee.id));
                    context.pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout,color: Theme.of(context).colorScheme.error,),
                  title: Text('Kick',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error
                  ),),
                  onTap: (){
                    context.read<MeetBloc>().add(KickUserEvent(userId: attendee.id));
                    context.pop();
                  },
                )
              ],
            ),
          );
        });
      }, icon: Icon(Icons.more_vert,color: Theme.of(context).colorScheme.onSurface,));
    }
    return Container();
  }
}
