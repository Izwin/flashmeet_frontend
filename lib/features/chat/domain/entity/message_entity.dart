import 'package:equatable/equatable.dart';
import 'package:flash_meet_frontend/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_entity.g.dart';

@JsonSerializable()
class MessageEntity extends Equatable{
  final String text;
  final DateTime createdAt;
  final UserEntity sender;

  MessageEntity({required this.text, required this.createdAt, required this.sender});

  factory MessageEntity.fromJson(Map<String,dynamic> json) => _$MessageEntityFromJson(json);

  @override
  List<Object?> get props => [
    text,
    createdAt,
    sender
  ];


}