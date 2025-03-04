import 'package:equatable/equatable.dart';
import 'package:flash_meet_frontend/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meet_entity.g.dart';

@JsonSerializable()
class MeetEntity extends Equatable{
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final List<UserEntity> attendees;
  final UserEntity admin;
  final bool isFinished;
  final bool isCancelled;
  final double? latitude;
  final double? longitude;

  MeetEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.attendees,
      required this.admin,
      required this.isFinished,
      required this.isCancelled,
      required this.latitude,
      required this.longitude});

  @override
  List<Object?> get props => [id,title,description,date,attendees,admin,isFinished,isCancelled,latitude,longitude];

  factory MeetEntity.fromJson(Map<String,dynamic> json) => _$MeetEntityFromJson(json);


}
