import 'dart:async';

import 'package:flash_meet_frontend/features/meet/domain/repository/meet_repository.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_event.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetBloc extends Bloc<MeetEvent, MeetState> {
  final MeetRepository meetRepository;

  MeetBloc({required this.meetRepository}) : super(MeetState.initial()) {
    on<GetMeetEvent>(onGetMeetEvent);
    on<JoinMeetEvent>(onJoinMeetEvent);
    on<KickUserEvent>(onKickUserEvent);
    on<TransferAdminEvent>(onTransferAdminEvent);
    on<CancelMeetEvent>(onCancelMeetEvent);
    on<LeaveMeetEvent>(onLeaveMeetEvent);
  }

  Future onGetMeetEvent(GetMeetEvent event, Emitter<MeetState> emit) async {
    emit(state.copyWith(status: MeetStatus.loading));

    var result = await meetRepository.getMeet(event.meetId);
    result.fold((l) {
      emit(state.copyWith(status: MeetStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(status: MeetStatus.success, meetEntity: r));
    });
  }

  Future onJoinMeetEvent(JoinMeetEvent event, Emitter<MeetState> emit) async {
    if (state.meetEntity == null) {
      return;
    }
    emit(state.copyWith(status: MeetStatus.loading));
    var result = await meetRepository.joinMeet(state.meetEntity!.id);
    result.fold((l) {
      emit(state.copyWith(status: MeetStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(status: MeetStatus.success));
      add(GetMeetEvent(meetId: state.meetEntity!.id));
    });
  }

  Future onKickUserEvent(KickUserEvent event, Emitter<MeetState> emit) async {
    if (state.meetEntity == null) {
      return;
    }
    emit(state.copyWith(status: MeetStatus.loading));
    var result =
        await meetRepository.kickUser(state.meetEntity!.id, event.userId);
    result.fold((l) {
      emit(state.copyWith(status: MeetStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(status: MeetStatus.success));
      add(GetMeetEvent(meetId: state.meetEntity!.id));
    });
  }

  Future onTransferAdminEvent(
      TransferAdminEvent event, Emitter<MeetState> emit) async {
    emit(state.copyWith(status: MeetStatus.loading));
    var result =
        await meetRepository.transferAdmin(state.meetEntity!.id, event.userId);
    result.fold((l) {
      emit(state.copyWith(status: MeetStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(status: MeetStatus.success));
      add(GetMeetEvent(meetId: state.meetEntity!.id));
    });
  }

  Future onCancelMeetEvent(
      CancelMeetEvent event, Emitter<MeetState> emit) async {
    if (state.meetEntity == null) {
      return;
    }
    emit(state.copyWith(status: MeetStatus.loading));
    var result = await meetRepository.cancelMeet(state.meetEntity!.id);
    result.fold((l) {
      emit(state.copyWith(status: MeetStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(
        status: MeetStatus.canceled,
      ));
    });
  }

  Future onLeaveMeetEvent(LeaveMeetEvent event, Emitter<MeetState> emit) async {
    if (state.meetEntity == null) {
      return;
    }
    emit(state.copyWith(status: MeetStatus.loading));
    var result = await meetRepository.leaveMeet(state.meetEntity!.id);
    result.fold((l) {
      emit(state.copyWith(status: MeetStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(status: MeetStatus.left));
    });
  }
}
