import 'package:flash_meet_frontend/core/router/app_router.dart';
import 'package:flash_meet_frontend/features/meet/domain/entity/meet_entity.dart';
import 'package:flash_meet_frontend/features/meet/presentation/page/meet_page.dart';
import 'package:flash_meet_frontend/features/profile/presentation/widgets/circle_user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LastMeetWidget extends StatelessWidget {

  final MeetEntity meetEntity;

  const LastMeetWidget({super.key, required this.meetEntity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.push(MeetPage.route(meetEntity.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(meetEntity.title,style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(width: 6,),
            Text('${meetEntity.date.hour}:${meetEntity.date.minute}',style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16,
            ),),
            Spacer(),
            ...meetEntity.attendees.map((attendee) => Padding(
              padding: const EdgeInsets.only(left: 4),
              child: CircleUserAvatar(
                width: 30,
                height: 30,
                url: attendee.avatar,
              ),
            )),
            SizedBox(width: 15,),
            Text('${DateFormat.yMMMd().format(meetEntity.date)}')
          ],
        ),
      ),
    );
  }
}
