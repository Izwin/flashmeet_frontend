import 'package:equatable/equatable.dart';
import 'package:flash_meet_frontend/features/meet/domain/entity/meet_entity.dart';

enum CreateMeetStatus { initial, loading, success, error }

class CreateMeetState extends Equatable{
  final CreateMeetStatus status;
  final String? errorMessage;
  final MeetEntity? createdMeet;

  CreateMeetState._(
      {required this.status, this.errorMessage, this.createdMeet});

  factory CreateMeetState.initial() =>
      CreateMeetState._(status: CreateMeetStatus.initial);

  CreateMeetState copyWith(
          {CreateMeetStatus? status,
          String? errorMessage,
          MeetEntity? createdMeet}) =>
      CreateMeetState._(
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage,
          createdMeet: createdMeet ?? this.createdMeet);

  @override
  List<Object?> get props => [status,errorMessage,createdMeet];
}
