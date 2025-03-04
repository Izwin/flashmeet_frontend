import 'package:flash_meet_frontend/core/router/app_router.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_bloc.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_state.dart';
import 'package:flash_meet_frontend/features/meet/domain/entity/meet_entity.dart';
import 'package:flash_meet_frontend/features/meet/presentation/page/meet_page.dart';
import 'package:flash_meet_frontend/features/profile/presentation/widgets/circle_user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NearbyMeetWidget extends StatelessWidget {
  final MeetEntity meetEntity;

  const NearbyMeetWidget({super.key, required this.meetEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return InkWell(
          onTap: (){
            context.push(MeetPage.route(meetEntity.id));
          },
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                borderRadius: BorderRadius.circular(16)),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Text(
                  meetEntity.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(width: 5),
                Text(
                  '${meetEntity.date.hour}:${meetEntity.date.minute}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Spacer(),
                ...meetEntity.attendees.map((attendee) => Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: CircleUserAvatar(
                        width: 40,
                        height: 40,
                        url: attendee.avatar,
                      ),
                    )),
                if (!meetEntity.attendees.any((u) => u.id == state.userEntity?.id))
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      style: IconButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.surface,
                          backgroundColor: Theme.of(context).colorScheme.primary),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
