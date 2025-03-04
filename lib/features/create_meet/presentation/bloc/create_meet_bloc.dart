import 'dart:async';

import 'package:flash_meet_frontend/features/create_meet/presentation/bloc/create_meet_event.dart';
import 'package:flash_meet_frontend/features/create_meet/presentation/bloc/create_meet_state.dart';
import 'package:flash_meet_frontend/features/meet/domain/repository/meet_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateMeetBloc extends Bloc<CreateMeetEvent,CreateMeetState>{
  final MeetRepository meetRepository;

  CreateMeetBloc({required this.meetRepository}) : super(CreateMeetState.initial()){
    on<CreateMeetEvent>(onCreateMeetEvent);
  }

  Future onCreateMeetEvent(CreateMeetEvent event, Emitter<CreateMeetState> emit) async {
    emit(state.copyWith(status: CreateMeetStatus.loading));
    var result = await meetRepository.createMeet(title: event.title, description: event.description, time: event.time, location: event.location);
    result.fold((l){
      emit(state.copyWith(status: CreateMeetStatus.error,errorMessage: l.message));
    }, (r){
      emit(state.copyWith(status: CreateMeetStatus.success,createdMeet: r));
    });
  }
}