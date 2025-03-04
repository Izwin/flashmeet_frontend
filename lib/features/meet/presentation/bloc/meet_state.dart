import 'package:equatable/equatable.dart';
import 'package:flash_meet_frontend/features/meet/domain/entity/meet_entity.dart';

enum MeetStatus { initial, loading, success, left,canceled, error }

class MeetState extends Equatable {
  final MeetStatus status;
  final String? errorMessage;

  final MeetEntity? meetEntity;

  MeetState._({required this.status, this.errorMessage, this.meetEntity});

  factory MeetState.initial() => MeetState._(status: MeetStatus.initial);

  MeetState copyWith(
          {MeetStatus? status, String? errorMessage, MeetEntity? meetEntity}) =>
      MeetState._(
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage,
          meetEntity: meetEntity ?? this.meetEntity);

  @override
  List<Object?> get props => [status, errorMessage, meetEntity];
}
