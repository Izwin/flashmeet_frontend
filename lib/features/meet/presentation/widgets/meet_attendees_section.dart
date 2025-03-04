import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_bloc.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_state.dart';
import 'package:flash_meet_frontend/features/meet/presentation/widgets/attendee_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetAttendeesSection extends StatelessWidget {
  const MeetAttendeesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetBloc, MeetState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Text(
                  'Attendees',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.people,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(20),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return AttendeeWidget(
                      attendee: state.meetEntity!.attendees[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                }, 
                itemCount: state.meetEntity?.attendees.length ?? 0,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
              ),
            )
          ],
        );
      },
    );
  }
}
