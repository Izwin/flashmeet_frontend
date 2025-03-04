import 'dart:async';

import 'package:flash_meet_frontend/features/meet/domain/repository/meet_repository.dart';
import 'package:flash_meet_frontend/features/profile/presentation/bloc/last_meets_event.dart';
import 'package:flash_meet_frontend/features/profile/presentation/bloc/last_meets_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LastMeetsBloc extends Bloc<LastMeetsEvent,LastMeetsState>{
  final MeetRepository meetRepository;

  LastMeetsBloc({required this.meetRepository}) : super(LastMeetsState.initial()){
    on<GetLastMeetsEvent>(onGetLastMeetsEvent);
  }

  Future onGetLastMeetsEvent(GetLastMeetsEvent event, Emitter<LastMeetsState> emit) async {
    if(state.status == LastMeetsStatus.loading || state.isLastPage){
      return;
    }
    if(event.refresh){
      emit(state.copyWith(
        currentPage: 1,
        isLastPage: false,
        lastMeets: []
      ));
    }
    emit(state.copyWith(status: LastMeetsStatus.loading));
    var result = await meetRepository.getLastMeets(page: state.currentPage,limit: 10);
    result.fold((l){
      emit(state.copyWith(status: LastMeetsStatus.error,errorMessage: l.message));
    }, (r){
      emit(state.copyWith(
        lastMeets: [...(state.lastMeets ?? []),...r],
        currentPage: state.currentPage+1,
        isLastPage: r.length<10,
        status: LastMeetsStatus.success,
      ));
    });
  }
}