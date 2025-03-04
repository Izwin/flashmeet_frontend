import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_bloc.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MeetDetailsSection extends StatelessWidget {
  const MeetDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetBloc, MeetState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Text('Meet Details',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(width: 5,),
                Icon(Icons.info_outline,color: Theme.of(context).colorScheme.onSurface,)
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                borderRadius: BorderRadius.circular(12)
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${state.meetEntity?.title}',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16
                      ),),
                      SizedBox(width: 5,),
                      Text(DateFormat('HH:mm').format(state.meetEntity?.date.toLocal() ?? DateTime.now()),style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300
                      ),)
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text('${state.meetEntity?.description}',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 14
                  ),)
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
