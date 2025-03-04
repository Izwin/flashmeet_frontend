import 'package:flash_meet_frontend/features/main/presentation/bloc/main_bloc.dart';
import 'package:flash_meet_frontend/features/main/presentation/bloc/main_event.dart';
import 'package:flash_meet_frontend/features/main/presentation/bloc/main_state.dart';
import 'package:flash_meet_frontend/features/main/presentation/widgets/current_meet_widget.dart';
import 'package:flash_meet_frontend/features/main/presentation/widgets/nearby_meet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBottomSheet extends StatelessWidget {
  const MainBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(builder: (context, scrollController) {
      return BlocBuilder<MainBloc, MainState>(

        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .surface,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 10,
                    color: Colors.grey.withOpacity(.5)
                  )
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),

            ),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<MainBloc>().add(GetNearbyMeetsEvent());
                context.read<MainBloc>().add(GetCurrentMeetsEvent());
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(state.currentMeets?.isNotEmpty ?? false)Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Current meets',style: Theme.of(context).textTheme.bodyLarge,),
                          SizedBox(height: 10,),
                          ListView.separated(itemBuilder: (context,index){
                            return CurrentMeetWidget(meetEntity: state.currentMeets![index]);
                          },separatorBuilder: (context,index){
                            return SizedBox(height: 10,);
                          }, shrinkWrap: true,padding: EdgeInsets.zero,physics: NeverScrollableScrollPhysics(),itemCount: state.currentMeets?.length ?? 0,),
                          SizedBox(height: 10,),
                        ],
                      ),
                      Text('Meets near me',style: Theme.of(context).textTheme.bodyLarge,),
                      SizedBox(height: 10,),
                      ListView.separated(itemBuilder: (context, index) {
                        return NearbyMeetWidget(meetEntity: state.nearbyMeets![index]);
                      },separatorBuilder: (context,index){
                        return SizedBox(height: 10,);
                      }, itemCount:state.nearbyMeets?.length ?? 0,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),padding: EdgeInsets.zero,)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }, initialChildSize: .3, minChildSize: .3, maxChildSize: .6);
  }
}
